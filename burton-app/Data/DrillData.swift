import Foundation

struct DrillData {
    static let all: [Drill] = [
        // MARK: - Full Swing Drills
        Drill(
            id: "drill_headcover_path",
            name: "Headcover Swing Path Drill",
            instructions: [
                "Place a headcover or small towel about 4 inches outside and behind the ball.",
                "Take your normal stance and address the ball.",
                "Make half swings focusing on swinging the club inside the headcover on the downswing.",
                "If you hit the headcover, your path is too outside-in (causing a slice).",
                "Gradually work up to full swings while avoiding the headcover.",
                "Hit 20-30 balls. Your natural shot shape should start shifting from a slice toward a draw."
            ],
            durationMinutes: 15,
            equipment: ["Headcover or towel", "Irons", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_grip_pressure",
            name: "Grip Pressure Check Drill",
            instructions: [
                "Rate your grip pressure from 1 (barely holding the club) to 10 (death grip).",
                "You want to be at a 4-5 out of 10.",
                "Hold the club at a 4 and make slow-motion swings, maintaining that same pressure throughout.",
                "Hit 10 balls at 50% speed, keeping grip pressure constant.",
                "Hit 10 balls at 75% speed, same pressure.",
                "Hit 10 balls at full speed. Notice how much more fluid your swing feels.",
                "Check in on grip pressure before every shot during your next round."
            ],
            durationMinutes: 10,
            equipment: ["Any club", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_alignment_sticks",
            name: "Alignment Station Drill",
            instructions: [
                "Lay one alignment stick (or club) on the ground along your target line.",
                "Lay a second stick parallel to the first, along your toe line at address.",
                "Lay a third stick perpendicular to mark ball position.",
                "Hit 20 balls, checking that your feet, hips, and shoulders are all parallel to the target line.",
                "Between every 5 balls, step away and realign from scratch.",
                "This drill resets your alignment when it has drifted."
            ],
            durationMinutes: 15,
            equipment: ["2-3 alignment sticks or old clubs", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_split_grip",
            name: "Split Grip Release Drill",
            instructions: [
                "Grip the club with your hands about 2 inches apart on the grip.",
                "Make slow half swings with a short iron.",
                "Feel how the club rotates naturally through impact.",
                "The split grip exaggerates hand rotation awareness.",
                "Hit 15 balls with the split grip, then 15 with your normal grip.",
                "Notice the improved feel for clubface rotation."
            ],
            durationMinutes: 10,
            equipment: ["Short iron (8 or 9)", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_tee_progression",
            name: "Tee Height Progression Drill",
            instructions: [
                "Start by hitting balls off a high tee with a 7-iron — this makes solid contact easy.",
                "Hit 5 good shots off the high tee.",
                "Lower the tee to half height. Hit 5 more solid shots.",
                "Lower the tee so it's barely above ground. Hit 5 more.",
                "Finally, hit 5 balls off the ground with no tee.",
                "If contact gets bad at any stage, go back one tee height.",
                "This progressively builds confidence in your ability to strike the ball cleanly."
            ],
            durationMinutes: 15,
            equipment: ["7-iron", "Tees at various heights", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_feet_together",
            name: "Feet Together Balance Drill",
            instructions: [
                "Stand with your feet touching (no wider than 2 inches apart).",
                "Hit balls with a 7 or 8 iron using a three-quarter swing.",
                "Focus on staying balanced — you shouldn't fall over.",
                "This drill eliminates swaying and promotes a centered turn.",
                "Hit 20 balls. You'll be amazed how solid the contact becomes.",
                "Return to your normal stance. You should feel much more centered and balanced."
            ],
            durationMinutes: 10,
            equipment: ["7 or 8 iron", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_coin_drill",
            name: "Coin Strike Drill",
            instructions: [
                "Place a coin on the ground where the ball would normally be.",
                "Without a ball, make practice swings trying to clip the coin off the ground.",
                "The goal is to brush the ground right at the coin's location.",
                "Once you can consistently move the coin, place a ball on top of the coin.",
                "Hit the ball without worrying about the coin — just make the same swing.",
                "This trains you to hit the ball with a slight descending blow."
            ],
            durationMinutes: 10,
            equipment: ["Short iron", "A coin", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_line_drill",
            name: "Divot Line Drill",
            instructions: [
                "Spray a line of paint or lay a string on the ground perpendicular to your target.",
                "Set up with the ball just in front of (target side of) the line.",
                "Hit shots and check where your divot starts relative to the line.",
                "Your divot should start AT the line or slightly ahead of it — never behind it.",
                "If your divot starts behind the line, focus on getting your weight forward before impact.",
                "Hit 20 balls, tracking your divot start point each time."
            ],
            durationMinutes: 15,
            equipment: ["Short iron", "String or spray paint", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_step_through",
            name: "Step-Through Power Drill",
            instructions: [
                "Set up to the ball normally with a mid-iron.",
                "Make your backswing.",
                "As you start the downswing, step your trail foot forward (like a baseball player stepping into a pitch).",
                "Hit the ball and finish walking toward the target.",
                "This drill forces proper weight transfer to the lead side.",
                "Hit 15-20 balls. Feel the power that comes from using your lower body.",
                "Return to a normal swing. The weight shift feel should carry over."
            ],
            durationMinutes: 10,
            equipment: ["Mid-iron (6 or 7)", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_speed_whoosh",
            name: "Speed Whoosh Drill",
            instructions: [
                "Turn a club upside down and hold it by the clubhead.",
                "Make full swings and listen for the 'whoosh' sound.",
                "Try to make the loudest whoosh happen at the bottom of the swing arc (where the ball would be).",
                "If the whoosh happens early (before the ball), you're releasing too soon.",
                "Do 10 swings as fast as possible with the inverted club.",
                "Now flip the club around and hit a ball. Notice the increased speed.",
                "Repeat 3 sets of 10 whooshes followed by 5 real balls."
            ],
            durationMinutes: 10,
            equipment: ["Any club"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_pump_drill",
            name: "Lag Pump Drill",
            instructions: [
                "Take a mid-iron to the top of your backswing.",
                "Start the downswing but stop when your hands reach hip height — the club should still be cocked.",
                "Go back to the top. Pump down and stop again.",
                "On the third pump, complete the swing and hit the ball.",
                "You should feel the club lagging behind your hands.",
                "Hit 15 balls with the pump drill. Feel the lag increasing your speed at impact."
            ],
            durationMinutes: 10,
            equipment: ["Mid-iron", "Range balls"],
            category: .fullSwing,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_toe_hits",
            name: "Anti-Shank Toe Hit Drill",
            instructions: [
                "Place a ball in your normal position.",
                "Set up so the ball is aligned with the TOE of the club (not the center).",
                "Make easy swings and intentionally hit the ball off the toe.",
                "This retrains your brain to keep the club away from the hosel.",
                "Hit 20 balls off the toe, then move the ball to center.",
                "Your subconscious will now have a built-in buffer against shanking."
            ],
            durationMinutes: 10,
            equipment: ["Short iron", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_gate_drill",
            name: "Gate Drill for Path",
            instructions: [
                "Place two tees in the ground about 3 inches apart, just wider than your clubhead.",
                "Set the ball between the tees.",
                "Make swings and try to pass the clubhead through the gate without hitting either tee.",
                "If you hit the outside tee, your path is too outside-in.",
                "If you hit the inside tee, your path is too inside-out.",
                "Start with half swings and work up to full swings.",
                "Hit 20 balls through the gate."
            ],
            durationMinutes: 15,
            equipment: ["Short iron", "Tees", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_half_swing",
            name: "9-to-3 Half Swing Drill",
            instructions: [
                "Imagine a clock face. Take the club back to 9 o'clock (hands at hip height).",
                "Swing through to 3 o'clock (matching follow-through height).",
                "Focus on making clean, centered contact with this abbreviated swing.",
                "Hit 20 balls with the 9-to-3 swing before moving to a full swing.",
                "This drill rebuilds your swing from a solid foundation.",
                "If full-swing contact gets shaky, return to the half swing to recalibrate."
            ],
            durationMinutes: 10,
            equipment: ["Any iron", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        // MARK: - Short Game Drills
        Drill(
            id: "drill_landing_zone",
            name: "Landing Zone Target Drill",
            instructions: [
                "Place a towel on the green 3-6 feet onto the putting surface.",
                "Chip from various lies around the green, trying to land the ball on the towel.",
                "The ball should land on the towel and roll to the hole.",
                "Move the towel for different chip distances.",
                "Hit 10 chips with a pitching wedge, 10 with a 9-iron, 10 with a 7-iron.",
                "Notice how each club produces different rollout from the same landing spot."
            ],
            durationMinutes: 15,
            equipment: ["PW, 9-iron, 7-iron", "A towel", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_one_hand_chip",
            name: "Trail Hand Only Chipping",
            instructions: [
                "Grip a wedge with only your trail hand (right hand for righties).",
                "Chip balls from just off the green using a gentle pendulum motion.",
                "This drill develops feel and touch in your dominant hand.",
                "Hit 15 one-hand chips, focusing on soft, consistent contact.",
                "Switch to both hands and chip 15 more. Notice the improved feel.",
                "This is a great warm-up drill before any round."
            ],
            durationMinutes: 10,
            equipment: ["Sand or lob wedge", "Golf balls"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_clock_chipping",
            name: "Clock Chipping Distance Drill",
            instructions: [
                "Using the same club (pitching wedge), hit chips with three different swing lengths.",
                "7 o'clock backstroke (hands barely past trail thigh) = short chip.",
                "8 o'clock backstroke (hands at hip height) = medium chip.",
                "9 o'clock backstroke (hands at waist height) = longer chip.",
                "Hit 10 balls at each length and note the carry + roll distance for each.",
                "This gives you three predictable distances with one club.",
                "Repeat with your sand wedge for three more distances."
            ],
            durationMinutes: 15,
            equipment: ["Pitching wedge", "Sand wedge", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        // MARK: - Putting Drills
        Drill(
            id: "drill_ladder_putting",
            name: "Ladder Putting Drill",
            instructions: [
                "Place tees or markers at 10, 20, 30, and 40 feet from your starting position.",
                "Putt one ball to each distance in sequence (10, 20, 30, 40 feet).",
                "Then putt back: 40, 30, 20, 10 feet.",
                "The goal: each ball finishes within 3 feet of its target.",
                "If you miss a target by more than 3 feet, start the ladder over.",
                "This drill builds distance control — the #1 key to eliminating three-putts."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "4 golf balls", "4 tees or markers"],
            category: .putting,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_gate_putting",
            name: "Gate Putting Drill",
            instructions: [
                "Place two tees just wider than your putter head, about 6 inches in front of the ball.",
                "Putt through the gate to a hole 5 feet away.",
                "The gate forces a straight backstroke and follow-through.",
                "Make 10 putts in a row through the gate.",
                "If you hit a tee, restart your count.",
                "Once you can make 10 in a row, move the gate 3 inches in front of the ball for a bigger challenge."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "2 tees", "Golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_circle_putting",
            name: "Circle of Confidence Drill",
            instructions: [
                "Place 4 balls in a circle around the hole, each 3 feet away (like a compass: N, S, E, W).",
                "Make all 4 putts. Each putt has a different break.",
                "If you miss one, start over from the beginning.",
                "Once you make 4 in a row, move the balls to 4 feet.",
                "Then try 5 feet.",
                "The goal: build bulletproof confidence inside 5 feet.",
                "Before a round, complete the 3-foot circle to lock in your stroke."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "4 golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        // MARK: - Mental Game Drills
        Drill(
            id: "drill_pressure_practice",
            name: "Pressure Simulation Drill",
            instructions: [
                "Set up a putting challenge: make 5 three-foot putts in a row.",
                "If you miss, start over at zero.",
                "Once completed, increase to 7 in a row.",
                "As the count gets higher, you'll feel genuine pressure — that's the point.",
                "Practice your breathing routine between each putt.",
                "This trains you to perform your technique when anxiety creeps in.",
                "Do this drill twice a week to build competitive toughness."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf ball"],
            category: .mental,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_breathing_routine",
            name: "Box Breathing Routine",
            instructions: [
                "Stand behind the ball as part of your pre-shot routine.",
                "Breathe in slowly for 4 counts through your nose.",
                "Hold your breath for 4 counts.",
                "Breathe out slowly for 4 counts through your mouth.",
                "Hold empty for 4 counts.",
                "Repeat once more, then step up to the ball and hit your shot.",
                "Practice this on EVERY shot during your next range session so it becomes automatic."
            ],
            durationMinutes: 5,
            equipment: ["None"],
            category: .mental,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_visualization",
            name: "Pre-Shot Visualization Drill",
            instructions: [
                "Before each shot on the range, close your eyes for 3 seconds.",
                "Visualize the ball flight you want: trajectory, shape, and landing spot.",
                "Open your eyes, look at the target, and see the same ball flight in your mind's eye.",
                "Step up and swing. Don't judge the result — just repeat the process.",
                "Do this for an entire bucket of balls (40-50 shots).",
                "Over time, your brain starts to produce the shots you visualize.",
                "Use this technique on the course for every shot."
            ],
            durationMinutes: 10,
            equipment: ["Any club", "Range balls"],
            category: .mental,
            difficulty: .beginner
        ),
    ]
}
