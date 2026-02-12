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
        )
    ]
}
