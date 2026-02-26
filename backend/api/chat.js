export const config = {
  runtime: "edge",
};

// ---------------------------------------------------------------------------
// Task-type routing: model, thinking config, token caps, and rate limits
// ---------------------------------------------------------------------------
const TASK_CONFIG = {
  video_analysis: {
    model: "claude-sonnet-4-5-20250929",
    thinking: { type: "enabled", budget_tokens: 4096 },
    maxOutputTokens: 1500,
    rateLimit: 35,
  },
  chat: {
    model: "claude-sonnet-4-5-20250929",
    thinking: null,
    maxOutputTokens: 800,
    rateLimit: 160,
  },
  title: {
    model: "claude-haiku-4-5-20241022",
    thinking: null,
    maxOutputTokens: 20,
    rateLimit: 100,
  },
  summary: {
    model: "claude-haiku-4-5-20241022",
    thinking: null,
    maxOutputTokens: 150,
    rateLimit: 100,
  },
  profile: {
    model: "claude-haiku-4-5-20241022",
    thinking: null,
    maxOutputTokens: 500,
    rateLimit: 50,
  },
};

// ---------------------------------------------------------------------------
// In-memory rate limiting (resets on cold start)
// ---------------------------------------------------------------------------
const rateLimitMap = new Map();
const RATE_WINDOW_MS = 60 * 60 * 1000; // 1 hour

function checkRateLimit(deviceId, taskType) {
  const config = TASK_CONFIG[taskType];
  if (!config) return false;

  const key = `${deviceId}:${taskType}`;
  const now = Date.now();
  const entry = rateLimitMap.get(key);

  if (!entry || now - entry.windowStart > RATE_WINDOW_MS) {
    rateLimitMap.set(key, { windowStart: now, count: 1 });
    return true;
  }

  if (entry.count >= config.rateLimit) {
    return false;
  }

  entry.count++;
  return true;
}

// ---------------------------------------------------------------------------
// Handler
// ---------------------------------------------------------------------------
export default async function handler(req) {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: corsHeaders(),
    });
  }

  if (req.method !== "POST") {
    return new Response("Method not allowed", { status: 405 });
  }

  const deviceId = req.headers.get("x-device-id");
  if (!deviceId) {
    return new Response(
      JSON.stringify({ error: "Missing device ID" }),
      { status: 400, headers: { "content-type": "application/json" } }
    );
  }

  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return new Response(
      JSON.stringify({ error: "Server configuration error" }),
      { status: 500, headers: { "content-type": "application/json" } }
    );
  }

  try {
    const body = await req.json();
    const { system, messages, stream = true } = body;

    // Backward compat: old clients that don't send task_type default to "chat"
    const taskType = body.task_type || "chat";
    const taskConfig = TASK_CONFIG[taskType];

    if (!taskConfig) {
      return new Response(
        JSON.stringify({ error: "Invalid task_type" }),
        { status: 400, headers: { "content-type": "application/json" } }
      );
    }

    if (!checkRateLimit(deviceId, taskType)) {
      return new Response(
        JSON.stringify({ error: "Rate limit exceeded. Please try again later." }),
        { status: 429, headers: { "content-type": "application/json" } }
      );
    }

    // Build max_tokens: if thinking is enabled, add budget to output cap
    const maxTokens = taskConfig.thinking
      ? taskConfig.maxOutputTokens + taskConfig.thinking.budget_tokens
      : taskConfig.maxOutputTokens;

    const anthropicBody = {
      model: taskConfig.model,
      max_tokens: maxTokens,
      system: [
        {
          type: "text",
          text: system,
          cache_control: { type: "ephemeral" },
        },
      ],
      messages,
      stream,
    };

    // Only add thinking when configured (saves output-rate tokens on non-video calls)
    if (taskConfig.thinking) {
      anthropicBody.thinking = taskConfig.thinking;
    }

    const response = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": apiKey,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify(anthropicBody),
    });

    if (!response.ok) {
      const errorText = await response.text();
      return new Response(errorText, {
        status: response.status,
        headers: { "content-type": "application/json", ...corsHeaders() },
      });
    }

    if (stream) {
      return new Response(response.body, {
        headers: {
          "content-type": "text/event-stream",
          "cache-control": "no-cache",
          ...corsHeaders(),
        },
      });
    }

    const data = await response.json();
    return new Response(JSON.stringify(data), {
      headers: { "content-type": "application/json", ...corsHeaders() },
    });
  } catch (error) {
    return new Response(
      JSON.stringify({ error: "Internal server error" }),
      { status: 500, headers: { "content-type": "application/json" } }
    );
  }
}

function corsHeaders() {
  return {
    "access-control-allow-origin": "*",
    "access-control-allow-methods": "POST, OPTIONS",
    "access-control-allow-headers": "content-type, x-device-id",
  };
}
