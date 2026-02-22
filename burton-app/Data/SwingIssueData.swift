import Foundation

struct SwingIssueData {
    static let all: [SwingIssue] = [
        SwingIssue(
            id: "slice",
            name: "Slice",
            description: "The ball curves dramatically from left to right (for right-handed golfers), often ending up in trouble off the fairway.",
            commonCauses: [
                "Open clubface at impact",
                "Outside-to-inside swing path",
                "Weak grip",
                "Poor shoulder alignment",
                "Early release of the hands"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_grip_fix", "tip_swing_path", "tip_clubface_awareness", "tip_shoulder_alignment"],
            linkedDrillIDs: ["drill_headcover_path", "drill_grip_pressure", "drill_alignment_sticks"]
        ),
        SwingIssue(
            id: "hook",
            name: "Hook",
            description: "The ball curves sharply from right to left (for right-handed golfers), often diving into trouble on the left side.",
            commonCauses: [
                "Closed clubface at impact",
                "Inside-to-outside swing path",
                "Overly strong grip",
                "Excessive hand rotation through impact",
                "Swing too flat"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_grip_fix", "tip_swing_path", "tip_clubface_awareness", "tip_release_timing"],
            linkedDrillIDs: ["drill_headcover_path", "drill_grip_pressure", "drill_split_grip"]
        ),
        SwingIssue(
            id: "topping",
            name: "Topping the Ball",
            description: "Hitting the top half of the ball, causing it to dribble along the ground instead of getting airborne.",
            commonCauses: [
                "Lifting up during the swing (early extension)",
                "Trying to scoop the ball into the air",
                "Poor weight transfer",
                "Ball position too far forward",
                "Tension and anxiety over the shot"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_stay_down", "tip_weight_transfer", "tip_ball_position"],
            linkedDrillIDs: ["drill_tee_progression", "drill_feet_together", "drill_coin_drill"]
        ),
        SwingIssue(
            id: "fat_shots",
            name: "Fat Shots",
            description: "Hitting the ground well before the ball, resulting in a heavy, short shot that loses significant distance.",
            commonCauses: [
                "Weight staying on back foot",
                "Casting or early release",
                "Swaying instead of turning",
                "Ball position too far back",
                "Dipping the head/upper body in the downswing"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_weight_transfer", "tip_ball_position", "tip_stay_down", "tip_divot_pattern"],
            linkedDrillIDs: ["drill_line_drill", "drill_feet_together", "drill_step_through"]
        ),
        SwingIssue(
            id: "shanks",
            name: "Shanks",
            description: "The ball shoots off sharply to the right after being struck by the hosel of the club — one of golf's most dreaded mishits.",
            commonCauses: [
                "Standing too close to the ball",
                "Weight moving toward toes during swing",
                "Excessive inside-out path",
                "Hands getting too far from the body",
                "Tension and over-thinking"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_setup_distance", "tip_balance", "tip_swing_path"],
            linkedDrillIDs: ["drill_toe_hits", "drill_feet_together", "drill_gate_drill"]
        ),
        SwingIssue(
            id: "lack_of_distance",
            name: "Lack of Distance",
            description: "Shots consistently fall short compared to expected yardages, costing strokes on approach shots.",
            commonCauses: [
                "Insufficient hip rotation",
                "Poor sequencing (arms before body)",
                "Lack of lag in the downswing",
                "Weak grip leading to glancing contact",
                "Inadequate shoulder turn"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_hip_rotation", "tip_lag", "tip_release_timing", "tip_grip_fix"],
            linkedDrillIDs: ["drill_speed_whoosh", "drill_step_through", "drill_pump_drill"]
        ),
        SwingIssue(
            id: "inconsistent_contact",
            name: "Inconsistent Contact",
            description: "Striking the ball differently each time — sometimes thin, sometimes fat, with no predictable pattern.",
            commonCauses: [
                "Inconsistent setup and posture",
                "Swaying off the ball",
                "Varying grip pressure",
                "Lack of a pre-shot routine",
                "Trying too many swing thoughts"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_preshot_routine", "tip_setup_distance", "tip_grip_fix", "tip_one_thought"],
            linkedDrillIDs: ["drill_feet_together", "drill_grip_pressure", "drill_half_swing"]
        ),
        SwingIssue(
            id: "poor_chipping",
            name: "Poor Chipping",
            description: "Difficulty getting up and down from around the green — chunks, skulls, and poor distance control on chip shots.",
            commonCauses: [
                "Trying to lift the ball instead of hitting down",
                "Too much wrist action",
                "Inconsistent ball position",
                "Weight on the back foot",
                "Using the wrong club selection"
            ],
            category: .shortGame,
            linkedTipIDs: ["tip_chipping_setup", "tip_club_selection_chips", "tip_weight_forward"],
            linkedDrillIDs: ["drill_landing_zone", "drill_one_hand_chip", "drill_clock_chipping"]
        ),
        SwingIssue(
            id: "three_putting",
            name: "Three-Putting",
            description: "Regularly taking three or more putts per green, often due to poor lag putting or missed short putts.",
            commonCauses: [
                "Poor distance control on lag putts",
                "Inconsistent stroke tempo",
                "Misreading greens",
                "Deceleration through the ball",
                "Poor alignment on short putts"
            ],
            category: .putting,
            linkedTipIDs: ["tip_lag_putting", "tip_green_reading", "tip_putting_tempo", "tip_short_putt_routine"],
            linkedDrillIDs: ["drill_ladder_putting", "drill_gate_putting", "drill_circle_putting"]
        ),
        SwingIssue(
            id: "first_tee_nerves",
            name: "First Tee Nerves",
            description: "Anxiety and tension on the first tee or in pressure situations that leads to poor swings and bad decisions.",
            commonCauses: [
                "Fear of embarrassment",
                "Overthinking mechanics",
                "Lack of a consistent pre-shot routine",
                "Physical tension from anxiety",
                "Result-oriented thinking instead of process focus"
            ],
            category: .mental,
            linkedTipIDs: ["tip_breathing", "tip_preshot_routine", "tip_one_thought", "tip_acceptance"],
            linkedDrillIDs: ["drill_pressure_practice", "drill_breathing_routine", "drill_visualization"]
        ),

        // MARK: - Swing Mechanic Faults

        SwingIssue(
            id: "early_extension",
            name: "Early Extension",
            description: "Hips thrust toward the ball during the downswing instead of rotating. Causes the body to stand up through impact, leading to inconsistent strikes — blocks, hooks, and thin shots.",
            commonCauses: [
                "Limited hip mobility",
                "Poor setup posture — too upright or too bent over",
                "Trying to generate power with the arms instead of rotation",
                "Ball position too far from the body",
                "Lack of core stability"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_stay_down", "tip_hip_rotation"],
            linkedDrillIDs: ["drill_wall_drill", "drill_feet_together"]
        ),
        SwingIssue(
            id: "over_the_top",
            name: "Over the Top",
            description: "The club moves outward at the start of the downswing instead of dropping into the slot. Creates a steep, outside-in path that produces pulls and slices.",
            commonCauses: [
                "Starting the downswing with the shoulders instead of the lower body",
                "Rushing the transition",
                "Grip too weak, forcing a compensation to square the face",
                "Lack of wrist hinge creating a flat, armsy swing",
                "Ball position too far forward"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_swing_path", "tip_clubface_awareness"],
            linkedDrillIDs: ["drill_headcover_path", "drill_pump_drill", "drill_step_through"]
        ),
        SwingIssue(
            id: "casting",
            name: "Casting / Early Release",
            description: "Releasing the wrist hinge too early in the downswing — throwing the clubhead at the ball instead of maintaining lag. Costs distance and shaft lean at impact.",
            commonCauses: [
                "Trying to hit AT the ball instead of through it",
                "Grip too tight, preventing natural release",
                "Poor sequencing — arms fire before hips",
                "No feel for lag or wrist hinge",
                "Scooping to help the ball into the air"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_lag", "tip_release_timing"],
            linkedDrillIDs: ["drill_pump_drill", "drill_speed_whoosh"]
        ),
        SwingIssue(
            id: "reverse_pivot",
            name: "Reverse Pivot",
            description: "Weight moves toward the target on the backswing and falls backward on the downswing — the opposite of proper weight transfer. Kills power and contact.",
            commonCauses: [
                "Trying to keep the head perfectly still",
                "Sliding instead of turning",
                "Fear of swaying causing an overcorrection",
                "Poor understanding of weight transfer",
                "Too narrow a stance"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_weight_transfer"],
            linkedDrillIDs: ["drill_step_through", "drill_feet_together"]
        ),
        SwingIssue(
            id: "sway",
            name: "Lateral Sway",
            description: "The body slides laterally off the ball during the backswing instead of rotating around a stable center. Makes it hard to return to the ball consistently.",
            commonCauses: [
                "Confusing rotation with lateral movement",
                "Insufficient hip flexibility",
                "Stance too wide, encouraging slide",
                "No resistance in the trail leg",
                "Poor core engagement"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_hip_rotation", "tip_balance"],
            linkedDrillIDs: ["drill_feet_together", "drill_wall_drill"]
        ),
        SwingIssue(
            id: "loss_of_posture",
            name: "Loss of Posture",
            description: "Spine angle changes during the swing — standing up, dipping down, or rounding forward. Destroys the consistent arc needed for solid contact.",
            commonCauses: [
                "Weak core muscles",
                "Trying to generate power with the upper body",
                "Poor setup posture to begin with",
                "Looking up too early to watch the ball",
                "Insufficient hip rotation forcing the body to compensate"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_stay_down", "tip_hip_rotation"],
            linkedDrillIDs: ["drill_wall_drill", "drill_half_swing"]
        ),
        SwingIssue(
            id: "chicken_wing",
            name: "Chicken Wing",
            description: "The lead elbow bends and pulls away from the body through impact instead of extending fully. Reduces power and causes weak, pushed shots.",
            commonCauses: [
                "Fear of hooking — pulling the handle to keep the face open",
                "Body stalling through impact, arms have to compensate",
                "Grip too strong, overcorrecting by holding off the release",
                "Insufficient body rotation through the ball",
                "Disconnected arms from the body turn"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_release_timing", "tip_hip_rotation"],
            linkedDrillIDs: ["drill_split_grip", "drill_speed_whoosh"]
        ),
        SwingIssue(
            id: "flat_backswing",
            name: "Flat Backswing / Inside Takeaway",
            description: "The club works too far inside and below the ideal swing plane on the backswing. Forces a compensation in the downswing — usually coming over the top or getting stuck.",
            commonCauses: [
                "Rolling the forearms open in the takeaway",
                "Rotating the body too early without moving the arms up",
                "Grip too strong, encouraging inside rotation",
                "Trying to swing around the body instead of up and around",
                "Misunderstanding of 'swing inside-out'"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_swing_path"],
            linkedDrillIDs: ["drill_alignment_sticks", "drill_half_swing"]
        ),
        SwingIssue(
            id: "steep_backswing",
            name: "Steep Backswing / Outside Takeaway",
            description: "The club moves outside the ideal plane in the takeaway — too upright and away from the body. Often leads to a steep downswing and over-the-top move.",
            commonCauses: [
                "Picking the club up with the hands instead of turning",
                "Dominant trail hand taking over the takeaway",
                "Insufficient shoulder turn",
                "Standing too close to the ball",
                "Trying to keep the club 'on line' too long"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_swing_path", "tip_shoulder_alignment"],
            linkedDrillIDs: ["drill_alignment_sticks", "drill_half_swing"]
        ),
        SwingIssue(
            id: "overswing",
            name: "Over-Swinging / Past Parallel",
            description: "The club goes well past parallel at the top of the backswing, creating a long, loose swing that's hard to control. Adds timing and reduces consistency.",
            commonCauses: [
                "Trying to generate more power by swinging longer",
                "Loose grip allowing the club to keep moving",
                "Insufficient core stability to brace the backswing",
                "Lead arm bending excessively at the top",
                "Confusing a big turn with a big arm swing"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_swing_path"],
            linkedDrillIDs: ["drill_half_swing", "drill_pump_drill"]
        ),
        SwingIssue(
            id: "body_stall",
            name: "Restricted Hip Rotation / Body Stall",
            description: "The body stops rotating through impact, forcing the hands and arms to flip the club. Kills power, consistency, and shaft lean. One of the biggest power leaks in amateur golf.",
            commonCauses: [
                "Limited hip mobility or flexibility",
                "Fear of going left (for right-handers)",
                "Poor lower body initiation — arms dominate the downswing",
                "Weight stuck on the back foot",
                "Insufficient athletic setup — knees too straight, hips too locked"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_hip_rotation", "tip_weight_transfer"],
            linkedDrillIDs: ["drill_step_through", "drill_speed_whoosh"]
        ),
        SwingIssue(
            id: "poor_weight_transfer",
            name: "Poor Weight Transfer",
            description: "Weight stays on the back foot through impact instead of shifting to the lead side. Causes fat shots, thin shots, and major power loss.",
            commonCauses: [
                "Fear of sliding or swaying",
                "Hanging back trying to lift the ball",
                "Insufficient lower body initiation in the downswing",
                "Reverse pivot in the backswing",
                "Too wide a stance restricting movement"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_weight_transfer"],
            linkedDrillIDs: ["drill_step_through", "drill_feet_together"]
        ),
        SwingIssue(
            id: "poor_grip",
            name: "Grip Issues",
            description: "Grip too weak, too strong, too much in the palm, or inconsistent pressure — the most fundamental fault that affects everything downstream.",
            commonCauses: [
                "Never been properly taught grip fundamentals",
                "Club sitting in the palm instead of the fingers",
                "Knuckle count wrong for desired ball flight",
                "Grip pressure too tight, restricting wrist hinge",
                "Trail hand too dominant, overpowering the lead"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_grip_fix"],
            linkedDrillIDs: ["drill_grip_pressure"]
        ),
        SwingIssue(
            id: "poor_setup",
            name: "Setup / Alignment Issues",
            description: "Stance width, ball position, alignment, or posture at address is off — causing compensations throughout the entire swing.",
            commonCauses: [
                "Feet aimed differently than shoulders",
                "Ball position inconsistent between shots",
                "Too much or too little knee flex",
                "Spine angle too upright or too hunched",
                "Standing too close or too far from the ball"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_ball_position", "tip_setup_distance", "tip_shoulder_alignment"],
            linkedDrillIDs: ["drill_alignment_sticks"]
        ),
        SwingIssue(
            id: "poor_tempo",
            name: "Poor Tempo / Rushing",
            description: "Swing tempo is too fast, especially in the transition from backswing to downswing. Destroys sequencing and timing.",
            commonCauses: [
                "Anxiety or adrenaline on the course",
                "Trying to hit the ball too hard",
                "No defined tempo ratio (should be roughly 3:1 back to down)",
                "Rushing the takeaway, which speeds up everything",
                "Tension in the hands and forearms"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_one_thought"],
            linkedDrillIDs: ["drill_feet_together", "drill_half_swing"]
        ),
        SwingIssue(
            id: "flipping",
            name: "Flipping / Scooping at Impact",
            description: "The wrists break down and flip through impact instead of maintaining shaft lean. Adds loft, kills compression, and produces weak, high shots with no penetrating ball flight.",
            commonCauses: [
                "Trying to help the ball into the air instead of hitting down",
                "Body stalling, forcing the hands to save the shot",
                "Weight on the back foot at impact",
                "No understanding of how shaft lean creates compression",
                "Casting earlier in the downswing leaving nothing to release properly"
            ],
            category: .fullSwing,
            linkedTipIDs: ["tip_lag", "tip_release_timing", "tip_weight_transfer"],
            linkedDrillIDs: ["drill_pump_drill", "drill_step_through"]
        )
    ]
}
