export const config = {
  runtime: "edge",
};

// Simple in-memory rate limiting (resets on cold start)
// Replace with Vercel KV for persistent rate limiting at scale
const rateLimitMap = new Map();
const RATE_LIMIT = 50; // messages per window
const RATE_WINDOW_MS = 60 * 60 * 1000; // 1 hour

function checkRateLimit(deviceId) {
  const now = Date.now();
  const entry = rateLimitMap.get(deviceId);

  if (!entry || now - entry.windowStart > RATE_WINDOW_MS) {
    rateLimitMap.set(deviceId, { windowStart: now, count: 1 });
    return true;
  }

  if (entry.count >= RATE_LIMIT) {
    return false;
  }

  entry.count++;
  return true;
}

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

  if (!checkRateLimit(deviceId)) {
    return new Response(
      JSON.stringify({ error: "Rate limit exceeded. Please try again later." }),
      { status: 429, headers: { "content-type": "application/json" } }
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
    const {
      system,
      messages,
      stream = true,
      max_tokens = 2048,
    } = body;

    // Build the request to Anthropic with prompt caching on system prompt
    const anthropicBody = {
      model: "claude-sonnet-4-5-20250929",
      max_tokens,
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
