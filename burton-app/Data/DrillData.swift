import Foundation

struct DrillData {
    static let all: [Drill] = fullSwingDrills + shortGameDrills + puttingDrills + mentalDrills

    // MARK: - Full Swing Drills (25)

    static let fullSwingDrills: [Drill] = [
        // --- Beginner ---
        Drill(
            id: "drill_headcover_path",
            name: "Headcover Swing Path",
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
            name: "Grip Pressure Check",
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
            name: "Alignment Station",
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
            id: "drill_tee_progression",
            name: "Tee Height Progression",
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
            name: "Feet Together Balance",
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
            name: "Coin Strike",
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
            id: "drill_speed_whoosh",
            name: "Speed Whoosh",
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
            id: "drill_half_swing",
            name: "9-to-3 Half Swing",
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
        Drill(
            id: "drill_towel_connection",
            name: "Towel Connection",
            instructions: [
                "Tuck a small towel or glove under both armpits.",
                "Make smooth three-quarter swings without dropping the towel.",
                "This forces your arms and body to rotate together as a unit.",
                "If the towel falls from your lead arm, your arms are disconnecting from your body.",
                "Hit 20 balls keeping the towel in place on both sides.",
                "Remove the towel and hit 10 more — you should feel a much more connected, powerful swing."
            ],
            durationMinutes: 10,
            equipment: ["Any iron", "Small towel or glove", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_slow_motion",
            name: "Slow Motion Swing",
            instructions: [
                "Make a full swing in extreme slow motion — take 10 seconds from start to finish.",
                "Feel every position: takeaway, top of backswing, transition, impact, follow-through.",
                "Do 5 slow-motion swings without a ball, checking your positions at each stage.",
                "Now hit a ball at 30% speed, maintaining the same awareness.",
                "Gradually increase to 50%, then 70%, then full speed over 20 balls.",
                "If you lose the feel at any speed, slow back down one level.",
                "This drill builds muscle memory for proper positions throughout the swing."
            ],
            durationMinutes: 15,
            equipment: ["Any iron", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_wall_posture",
            name: "Wall Posture Check",
            instructions: [
                "Stand with your back against a wall, feet about 12 inches from the baseboard.",
                "Bend from your hips (not your waist) until your head comes off the wall.",
                "Your rear end and upper back should still touch the wall.",
                "Let your arms hang naturally — this is your ideal posture at address.",
                "Hold a club and memorize this feeling.",
                "Step away from the wall and replicate the posture. Hit 10 balls.",
                "Return to the wall between sets to recalibrate. Do 3 sets of 10."
            ],
            durationMinutes: 10,
            equipment: ["Any club", "A wall", "Range balls"],
            category: .fullSwing,
            difficulty: .beginner
        ),
        // --- Intermediate ---
        Drill(
            id: "drill_split_grip",
            name: "Split Grip Release",
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
            id: "drill_line_drill",
            name: "Divot Line",
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
            name: "Step-Through Power",
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
            id: "drill_toe_hits",
            name: "Anti-Shank Toe Hit",
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
            id: "drill_pause_top",
            name: "Pause at the Top",
            instructions: [
                "Take the club to the top of your backswing and pause for a full 2 seconds.",
                "During the pause, feel your weight loaded into your trail side and your shoulders fully turned.",
                "After 2 seconds, start the downswing smoothly — don't lunge.",
                "The pause breaks the urge to rush the transition, which is the #1 amateur mistake.",
                "Hit 20 balls with the 2-second pause. Focus on smooth tempo, not distance.",
                "Then hit 10 without the pause. Your transition should feel much calmer."
            ],
            durationMinutes: 15,
            equipment: ["Any iron", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_one_arm_swing",
            name: "Lead Arm Only Swing",
            instructions: [
                "Grip a short iron with only your lead hand (left for righties).",
                "Make smooth half swings, hitting balls off a tee.",
                "Focus on rotating your body to move the club — don't just use your arm.",
                "Hit 15 balls lead-hand only. This trains the lead side to control the swing.",
                "Switch to trail-hand only for 15 balls — this builds feel and release.",
                "Then hit 15 with both hands. Notice how each hand's role feels clearer.",
                "If you can't hit the ball one-handed, start with practice swings only."
            ],
            durationMinutes: 15,
            equipment: ["Short iron", "Tees", "Range balls"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_stock_distances",
            name: "Stock Distance Ladder",
            instructions: [
                "Pick one wedge (pitching wedge or gap wedge).",
                "Hit 5 balls with a half swing (9-to-3). Note the average carry distance.",
                "Hit 5 balls with a three-quarter swing. Note the average carry.",
                "Hit 5 balls with a full swing. Note the average carry.",
                "Record these three distances — they are your 'stock' yardages for that club.",
                "Repeat with your sand wedge and lob wedge.",
                "You now have 9 predictable distances inside 120 yards."
            ],
            durationMinutes: 20,
            equipment: ["PW, GW, SW or LW", "Range balls", "Notepad or phone"],
            category: .fullSwing,
            difficulty: .intermediate
        ),
        // --- Advanced ---
        Drill(
            id: "drill_pump_drill",
            name: "Lag Pump",
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
            id: "drill_shot_shaping",
            name: "Shot Shaping: Draw & Fade",
            instructions: [
                "Start with your normal 7-iron shot. Hit 5 straight balls as a baseline.",
                "For a draw: aim your feet and body 10-15 yards right of target. Keep the clubface at the target. Swing along your body line.",
                "Hit 10 draws. The ball should start right and curve left back to target.",
                "For a fade: aim your body 10-15 yards left of target. Keep the clubface at the target. Swing along your body line.",
                "Hit 10 fades. The ball should start left and curve right back to target.",
                "Alternate: draw, straight, fade, straight. 5 of each to build command of shot shape.",
                "On the course, commit to one shape per hole based on the hole's design."
            ],
            durationMinutes: 25,
            equipment: ["7-iron", "Range balls", "Alignment sticks"],
            category: .fullSwing,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_trajectory_control",
            name: "Trajectory Control: High & Low",
            instructions: [
                "With a 7-iron, hit 5 normal trajectory shots. Note the peak height.",
                "For low shots: move the ball back 2 inches in your stance, lean the shaft forward, and make a three-quarter swing. Hit 10 balls.",
                "For high shots: move the ball forward 1 inch, widen your stance slightly, and feel like you're swinging up through the ball. Hit 10 balls.",
                "Now play a game: call out 'high' or 'low' before each shot and alternate for 10 balls.",
                "This is essential for playing in wind and controlling distance into greens.",
                "Practice with your 5-iron and PW as well — trajectory control works with every club."
            ],
            durationMinutes: 20,
            equipment: ["7-iron, 5-iron, PW", "Range balls"],
            category: .fullSwing,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_stinger",
            name: "Stinger Punch Shot",
            instructions: [
                "Tee up a ball at normal driver height. Use a 3 or 4 iron.",
                "Grip down 1 inch on the club for extra control.",
                "Play the ball slightly back of center. Press the shaft forward at address.",
                "Make a three-quarter backswing and drive through with a low, abbreviated finish (hands at chest height max).",
                "The ball should fly low and piercing with heavy topspin for extra roll.",
                "Hit 15 balls. Target trajectory: under 50 feet peak height.",
                "This is your go-to shot in strong wind or when you need to keep the ball under trees."
            ],
            durationMinutes: 15,
            equipment: ["3 or 4 iron", "Tees", "Range balls"],
            category: .fullSwing,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_speed_training",
            name: "Overspeed Training Protocol",
            instructions: [
                "You need three 'clubs': a light one (alignment stick), your normal driver, and a weighted club or two clubs held together.",
                "Set 1: Make 5 max-effort swings with the light stick. Swing as FAST as possible.",
                "Set 2: Make 5 max-effort swings with your normal driver.",
                "Set 3: Make 5 swings with the heavy club. These will feel slow but build strength.",
                "Rest 30 seconds between sets. Do 3 rounds (45 total swings).",
                "After the protocol, hit 5 balls with your driver. You'll notice increased speed.",
                "Do this 3x per week for 6 weeks to gain 5-8 mph of clubhead speed."
            ],
            durationMinutes: 20,
            equipment: ["Alignment stick", "Driver", "Weighted club or 2 irons held together"],
            category: .fullSwing,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_swing_plane",
            name: "Swing Plane Window",
            instructions: [
                "Set up two alignment sticks as a 'window': one angled from the ball to your trail shoulder, one from the ball to your lead shoulder.",
                "Make slow swings and check that the club stays within this window on both the backswing and downswing.",
                "Film yourself from down-the-line to verify the club stays in the corridor.",
                "If the club goes above the window, you're too steep. Below = too flat.",
                "Hit 20 balls with the sticks in place, checking plane on every swing.",
                "This is the most precise way to train a consistent swing plane.",
                "Review video after the session and note any tendencies."
            ],
            durationMinutes: 20,
            equipment: ["Alignment sticks", "Any iron", "Phone for video", "Range balls"],
            category: .fullSwing,
            difficulty: .advanced
        ),
    ]

    // MARK: - Short Game Drills (18)

    static let shortGameDrills: [Drill] = [
        // --- Beginner ---
        Drill(
            id: "drill_landing_zone",
            name: "Landing Zone Target",
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
            id: "drill_clock_chipping",
            name: "Clock Chipping Distance",
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
        Drill(
            id: "drill_bump_run",
            name: "Bump and Run Basics",
            instructions: [
                "Use a 7 or 8 iron for this shot — not a wedge.",
                "Play the ball back in your stance (off your trail foot).",
                "Make a putting-style stroke with your shoulders — minimal wrist action.",
                "The ball should pop up slightly and then roll like a putt.",
                "Practice from 5, 10, and 15 yards off the green.",
                "This is the safest, most consistent shot around the green for beginners.",
                "Use this anytime there's no obstacle between you and the pin."
            ],
            durationMinutes: 10,
            equipment: ["7 or 8 iron", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_basic_pitch",
            name: "Basic Pitch Shot",
            instructions: [
                "Use a pitching wedge or gap wedge.",
                "Set up with the ball centered in your stance. Open your stance slightly (feet aimed a bit left for righties).",
                "Make a smooth swing with your arms and body together — like a mini full swing.",
                "The ball should fly higher than a chip and land softly with less roll.",
                "Practice from 20, 30, and 40 yards to the pin.",
                "Hit 10 balls at each distance. Track your landing spot consistency.",
                "The pitch is your go-to when you need to carry over a bunker or rough."
            ],
            durationMinutes: 15,
            equipment: ["PW or GW", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_up_and_down",
            name: "Up-and-Down Challenge",
            instructions: [
                "Drop 10 balls in different spots around the practice green (varying distances and lies).",
                "For each ball, chip or pitch onto the green and then putt out.",
                "Count how many times you get up-and-down (on the green + 1 putt = success).",
                "Your goal: 4 out of 10 for beginners, 6 out of 10 for intermediates, 8 out of 10 for advanced.",
                "Repeat the circuit and try to beat your score.",
                "This is the most game-like short game practice you can do.",
                "Track your score over weeks to measure improvement."
            ],
            durationMinutes: 20,
            equipment: ["Wedges", "Putter", "10 golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_basic_bunker",
            name: "Basic Bunker Escape",
            instructions: [
                "Draw a line in the sand about 2 inches behind where the ball sits.",
                "Open the clubface of your sand wedge (aim face right of target).",
                "Open your stance (aim feet left of target). The club and body cancel out.",
                "Swing along your foot line and enter the sand at the line you drew — NOT at the ball.",
                "The sand lifts the ball out. You never actually hit the ball directly.",
                "Practice without a ball first: just splash sand onto the green.",
                "Once you can splash sand consistently, add a ball. Hit 20 bunker shots."
            ],
            durationMinutes: 15,
            equipment: ["Sand wedge", "Practice bunker", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_fringe_chip",
            name: "Fringe Putting Hybrid",
            instructions: [
                "From the fringe (just off the green), practice using your putter instead of chipping.",
                "Hit 10 putts from the fringe, judging how much extra force the longer grass requires.",
                "Now chip 10 balls from the same spots with an 8-iron bump-and-run.",
                "Compare results: which method gets closer to the hole more consistently?",
                "Most beginners will find the putter more reliable from the fringe.",
                "Rule of thumb: if the grass is short and flat, putt it. Save chipping for longer grass or obstacles."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "8-iron", "Golf balls"],
            category: .shortGame,
            difficulty: .beginner
        ),
        // --- Intermediate ---
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
            id: "drill_flop_shot",
            name: "Flop Shot Technique",
            instructions: [
                "Use your most lofted wedge (56 or 60 degree).",
                "Open the clubface wide — the face should almost point at the sky.",
                "Open your stance significantly (feet aimed 30-40 degrees left for righties).",
                "Make an aggressive swing along your foot line. The open face creates height, not distance.",
                "The ball should pop up high and land softly with minimal roll.",
                "Practice over a towel placed 5 yards away — the ball should clear it and stop quickly.",
                "Start with good lies only. This shot requires confident, committed swings."
            ],
            durationMinutes: 15,
            equipment: ["Lob wedge (58-60°)", "Golf balls", "Towel"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_bunker_distance",
            name: "Bunker Distance Control",
            instructions: [
                "Set up 3 targets on the green at 10, 20, and 30 feet from the bunker edge.",
                "Hit 5 bunker shots to each target distance.",
                "For shorter shots: smaller swing, same sand entry point.",
                "For longer shots: bigger swing and/or slightly less open clubface.",
                "The key variable is swing length, NOT how hard you swing.",
                "Track how many land within 6 feet of each target. Goal: 3 out of 5.",
                "Most amateurs only practice 'getting out' — this drill teaches distance control."
            ],
            durationMinutes: 20,
            equipment: ["Sand wedge", "Practice bunker", "Golf balls", "3 towels or targets"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_uneven_lies",
            name: "Uneven Lie Chipping",
            instructions: [
                "Find spots around the practice green with uphill, downhill, and sidehill lies.",
                "Uphill: play ball slightly forward, swing up the slope, expect higher flight and less roll.",
                "Downhill: play ball back, lean with the slope, expect lower flight and more roll.",
                "Ball above feet: stand taller, grip down, expect ball to go left.",
                "Ball below feet: bend more at the knees, expect ball to go right.",
                "Hit 5 chips from each lie type. Adjust your target based on the slope's effect.",
                "This is what separates okay chippers from great ones — adapting to the terrain."
            ],
            durationMinutes: 20,
            equipment: ["Wedges", "Golf balls"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_partial_wedge",
            name: "Wedge Distance Matrix",
            instructions: [
                "Bring your PW, GW, SW, and LW to the range.",
                "For each club, hit 10 balls at each of these swing lengths: half, three-quarter, and full.",
                "Record the average carry distance for each club at each swing length.",
                "You now have a matrix of 12 predictable distances (4 clubs x 3 swings).",
                "Write these down and keep them in your bag or phone.",
                "On the course, pick the club/swing combo that matches your yardage.",
                "Update the matrix every month as your distances may change."
            ],
            durationMinutes: 30,
            equipment: ["PW, GW, SW, LW", "Range balls", "Notepad or phone"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_hinge_hold",
            name: "Hinge and Hold Chip",
            instructions: [
                "Set up with your weight 60% on your lead foot. Keep it there throughout the shot.",
                "On the backswing, hinge your wrists early — let the club cock upward.",
                "On the downswing, hold that wrist angle through impact — don't flip or release.",
                "The ball should come out low with lots of backspin and check up quickly.",
                "Practice with your sand wedge from 10-15 yards off the green.",
                "Hit 20 balls, focusing on the 'hold' through impact — the shaft should lean forward at contact.",
                "This shot gives you spin control that a basic chip doesn't."
            ],
            durationMinutes: 15,
            equipment: ["Sand wedge", "Golf balls"],
            category: .shortGame,
            difficulty: .intermediate
        ),
        // --- Advanced ---
        Drill(
            id: "drill_lob_over_obstacle",
            name: "Lob Over Obstacle",
            instructions: [
                "Place a chair, bag, or obstacle between you and the practice green.",
                "Using a lob wedge with an open face, hit shots that clear the obstacle and land softly.",
                "Start 5 yards from the obstacle and work back to 10, then 15 yards.",
                "This simulates short-sided pins with bunkers or mounding in the way.",
                "The key: commit to an aggressive swing. Deceleration causes skulled shots over the green.",
                "Hit 15 balls from each distance. Goal: 60%+ clearing the obstacle and staying on the green.",
                "This shot wins strokes in tournament play when most players are afraid to try it."
            ],
            durationMinutes: 20,
            equipment: ["Lob wedge", "An obstacle (bag, chair)", "Golf balls"],
            category: .shortGame,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_short_sided",
            name: "Short-Sided Recovery",
            instructions: [
                "Drop balls in the worst spots around the green: tight lies, downhill to the pin, minimal green to work with.",
                "For each ball, evaluate: what's the highest-percentage shot to get up and down?",
                "Sometimes the best play is to chip to 10 feet and make the putt, not try a hero shot.",
                "Practice both the safe play (center of green) and the aggressive play (at the pin).",
                "Hit 5 from each of 4 tough spots (20 shots total). Track up-and-down percentage.",
                "Compare safe vs. aggressive results. You'll learn when risk is worth it.",
                "Tour pros choose the safe play more often than you'd think."
            ],
            durationMinutes: 25,
            equipment: ["Wedges", "Putter", "Golf balls"],
            category: .shortGame,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_spin_control",
            name: "Spinning Wedge Control",
            instructions: [
                "Use a premium urethane golf ball (spin requires the right ball).",
                "Hit wedge shots from 40-60 yards with a clean lie.",
                "For maximum spin: ball back in stance, hands forward, hit ball then turf, accelerate through.",
                "For medium spin: normal setup, smooth swing.",
                "For low spin (release shot): ball forward, sweep it, let it release and roll out.",
                "Hit 10 shots of each type. Watch how the ball reacts on the green.",
                "On the course, choose your spin type based on pin position and green slope."
            ],
            durationMinutes: 20,
            equipment: ["Sand or gap wedge", "Premium golf balls", "Clean lie"],
            category: .shortGame,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_hardpan",
            name: "Hardpan and Tight Lies",
            instructions: [
                "Find a bare, tight lie area (no grass under the ball) on the practice area.",
                "Use a club with less bounce (PW or GW instead of SW) to avoid the club bouncing off the hard surface.",
                "Play the ball back in your stance. Keep your hands ahead through impact.",
                "Make a descending strike — you must hit the ball first, not the ground.",
                "Start with half swings and build up. Hit 15 balls from tight lies.",
                "Then find patchy, thin lies and practice from those. Hit 15 more.",
                "This builds confidence for those scary bare lies on the course."
            ],
            durationMinutes: 15,
            equipment: ["PW or GW", "Golf balls"],
            category: .shortGame,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_buried_bunker",
            name: "Buried Bunker Shot",
            instructions: [
                "Press a ball into the sand so it's half-buried (a fried egg lie).",
                "CLOSE the clubface — this is opposite of a normal bunker shot.",
                "The closed face acts like a knife to dig under the ball.",
                "Aim slightly left of target (the ball will come out right with a closed face).",
                "Make a steep, aggressive downward chop into the sand 1 inch behind the ball.",
                "The ball will come out low with no spin and lots of roll — plan for it.",
                "Hit 15 buried lies. Goal: get it on the green, accept it won't stop fast."
            ],
            durationMinutes: 15,
            equipment: ["Sand wedge", "Practice bunker", "Golf balls"],
            category: .shortGame,
            difficulty: .advanced
        ),
    ]

    // MARK: - Putting Drills (16)

    static let puttingDrills: [Drill] = [
        // --- Beginner ---
        Drill(
            id: "drill_ladder_putting",
            name: "Ladder Putting",
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
            name: "Gate Putting",
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
            name: "Circle of Confidence",
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
        Drill(
            id: "drill_eyes_closed_putt",
            name: "Eyes Closed Distance Feel",
            instructions: [
                "Set up a putt from 20 feet. Look at the hole, then close your eyes.",
                "Putt the ball with your eyes closed, relying purely on feel.",
                "Open your eyes and see where the ball ended up.",
                "Your body has better distance instincts than you think — but you have to trust it.",
                "Do 10 putts with eyes closed from 20 feet. Track how many finish within 3 feet.",
                "Then try 30 feet and 40 feet with eyes closed.",
                "This drill trains your subconscious distance calibration."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_ruler_alignment",
            name: "Ruler Alignment",
            instructions: [
                "Find a straight, flat putt of about 6 feet.",
                "Lay a yardstick or ruler on the ground pointing from the ball to the hole.",
                "Set the ball at one end and putt along the ruler's edge.",
                "If the ball stays on the ruler's line, your face and path are square.",
                "If it drifts left, your face is closed or path is left. Right = face open or path right.",
                "Make 20 putts along the ruler. Aim for the ball tracking the line for at least 3 feet.",
                "This is the fastest way to groove a straight putting stroke."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "Yardstick or ruler", "Golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_one_hand_putt",
            name: "Lead Hand Only Putting",
            instructions: [
                "Grip the putter with only your lead hand (left for righties).",
                "Putt 10 balls from 5 feet, focusing on keeping the putter face square through the stroke.",
                "The lead hand controls the face angle — this drill isolates that skill.",
                "Then switch to trail-hand only for 10 putts. The trail hand controls speed.",
                "Finally, putt 10 with both hands. Notice how each hand's job is now clearer.",
                "If one hand feels much weaker, spend extra time with that hand.",
                "Great warm-up drill before any round."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_speed_calibration",
            name: "Speed Calibration",
            instructions: [
                "Place a club on the ground 2 feet past the hole (this is your 'back wall').",
                "Every putt should reach the hole but NOT go past the club on the ground.",
                "This trains you to putt with 'dying speed' — the ball barely reaches the hole.",
                "Start from 5 feet. Once you can land 8 out of 10 in the zone, move to 10 feet.",
                "Then 15 feet, then 20 feet.",
                "Putts that die at the hole have a bigger effective cup size because the ball can fall in from any angle.",
                "Putts that blast past only go in if perfectly centered."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "An extra club", "Golf balls"],
            category: .putting,
            difficulty: .beginner
        ),
        // --- Intermediate ---
        Drill(
            id: "drill_break_reading",
            name: "Break Reading Practice",
            instructions: [
                "Find a putt with obvious slope (you can see it breaks left or right).",
                "Before putting, walk to the low side and read the slope. Pick an aim point.",
                "Putt 5 balls to that aim point. Watch how the ball breaks.",
                "Adjust your aim point based on results and putt 5 more.",
                "Repeat until you're consistently starting the ball on your intended line.",
                "Move to a different breaking putt and repeat the process.",
                "Track how many adjustments you need — fewer adjustments = better green reading."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_uphill_downhill",
            name: "Uphill/Downhill Speed",
            instructions: [
                "Find a putt with significant uphill slope. Putt 5 balls from 15 feet uphill.",
                "Note how much harder you need to hit uphill vs. flat.",
                "Now turn around and putt 5 balls downhill from the same distance.",
                "Note how much softer the stroke needs to be going downhill.",
                "Alternate: 3 uphill, then 3 downhill, for 20 total putts.",
                "Your brain needs to quickly recalibrate between uphill and downhill — this trains that skill.",
                "On the course, the most common 3-putt is a downhill putt hit too hard."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_lag_putt_challenge",
            name: "Lag Putt Challenge",
            instructions: [
                "From 40 feet, putt 10 balls. Count how many finish within 3 feet of the hole.",
                "If you get 7 or more, move back to 50 feet.",
                "If you get fewer than 5, move up to 30 feet and work on feel.",
                "The goal is NOT to make these — it's to leave yourself a tap-in.",
                "Focus on speed, not line. From 40+ feet, speed accounts for 90% of the result.",
                "Practice your pre-putt routine: look at the hole, look at the ball, feel the distance in your body, putt.",
                "Eliminating 3-putts drops 3-5 strokes per round for most amateurs."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_coin_putting",
            name: "Coin Putting Focus",
            instructions: [
                "Place a coin on the green 6 feet from you (no hole needed).",
                "Try to roll the ball directly over the coin.",
                "A coin is much smaller than a hole — this sharpens your aim dramatically.",
                "Hit 20 putts at the coin. Count how many roll directly over or within 1 inch.",
                "Move the coin to 10 feet and repeat.",
                "When you go back to putting at a real hole, it will look enormous.",
                "Use this drill to sharpen your stroke when your putting feels off."
            ],
            durationMinutes: 10,
            equipment: ["Putter", "A coin", "Golf balls"],
            category: .putting,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_aimpoint_basics",
            name: "AimPoint Green Reading",
            instructions: [
                "Stand behind the ball and straddle the putt line with your feet.",
                "Feel which foot has more weight on it — that's the low side of the slope.",
                "Rate the slope: 1 (barely tilting) to 5 (very steep).",
                "Hold up 1-5 fingers at arm's length. The number of fingers = your aim offset from the hole.",
                "For a 'level 2' right-to-left putt, aim 2 fingers right of the hole edge.",
                "Putt 10 balls using AimPoint reads. Compare your results to your instinct reads.",
                "This system gives you a repeatable, objective way to read greens."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .intermediate
        ),
        // --- Advanced ---
        Drill(
            id: "drill_pressure_putt_tourney",
            name: "Tournament Putting Sim",
            instructions: [
                "Play a 9-hole putting game: place balls at 3, 5, 8, 10, 15, 20, 25, 30, and 40 feet.",
                "Each putt is worth points: make it = +2, inside 3 feet = +1, outside 3 feet = 0, 3-putt = -2.",
                "Keep a running score. Par is 9 points (one point per hole).",
                "This simulates the variety of putts you face in a real round.",
                "Track your score over multiple sessions. Aim to beat your personal best.",
                "The pressure builds as you go — especially on the scoring putts at 3-8 feet.",
                "If you consistently score 12+, you have tour-level putting."
            ],
            durationMinutes: 20,
            equipment: ["Putter", "Golf balls", "Scorecard or phone"],
            category: .putting,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_double_break",
            name: "Double-Break Reading",
            instructions: [
                "Find a long putt (20+ feet) that breaks in two directions — first one way, then the other.",
                "These are the hardest putts in golf. Most amateurs have no strategy for them.",
                "Identify the 'apex' point where the putt changes direction.",
                "Read the first break normally and pick your initial aim point.",
                "Then factor the second break: how will the ball's reduced speed affect the final curve?",
                "Putt 10 balls, adjusting your read each time. Track how close you get.",
                "Even getting within 4 feet on a double-breaker is a win."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_clock_6ft",
            name: "Clock Drill at 6 Feet",
            instructions: [
                "Place 12 balls in a clock pattern around the hole, each exactly 6 feet away.",
                "You must make ALL 12 putts in a row. Each putt has a different break.",
                "If you miss one, start over from the beginning.",
                "This is the ultimate confidence builder — but it's brutally hard.",
                "The pressure builds with every make. By putt 10, your hands will feel it.",
                "Track how many attempts it takes to complete the clock. Tour pros average 2-3 attempts.",
                "Once you conquer 6 feet, you'll never fear a 6-footer on the course again."
            ],
            durationMinutes: 20,
            equipment: ["Putter", "12 golf balls"],
            category: .putting,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_speed_die",
            name: "Speed Die Drill",
            instructions: [
                "Pick a 20-foot putt. Hit 5 balls that die into the front edge of the cup.",
                "Hit 5 balls that are 'firm' — they would go 18 inches past if they miss.",
                "Hit 5 balls that are 'aggressive' — they would go 3 feet past if they miss.",
                "Notice how each speed changes the effective break. Firm putts break less.",
                "Now pick a breaking putt and repeat: 5 dying, 5 firm, 5 aggressive.",
                "The firm speed will need less aim, but missing leaves a longer comebacker.",
                "Choose your speed strategy based on the situation: firm for straight putts, dying for downhill."
            ],
            durationMinutes: 15,
            equipment: ["Putter", "Golf balls"],
            category: .putting,
            difficulty: .advanced
        ),
    ]

    // MARK: - Mental Game Drills (15)

    static let mentalDrills: [Drill] = [
        // --- Beginner ---
        Drill(
            id: "drill_pressure_practice",
            name: "Pressure Simulation",
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
            name: "Pre-Shot Visualization",
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
        Drill(
            id: "drill_post_shot",
            name: "Post-Shot Routine",
            instructions: [
                "After every shot (good or bad), follow this 3-step process:",
                "Step 1: React honestly for 3 seconds. Fist pump or grimace — let it out briefly.",
                "Step 2: Analyze. What caused the result? One short thought only: 'aimed too far right' or 'great tempo.'",
                "Step 3: Release. Take one deep breath and let the shot go completely. It's done.",
                "Practice this routine for every shot on the range and every shot on the course.",
                "The goal: by the time you reach your ball, the previous shot is completely gone from your mind.",
                "This prevents bad shots from snowballing into bad holes."
            ],
            durationMinutes: 5,
            equipment: ["None"],
            category: .mental,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_positive_self_talk",
            name: "Positive Self-Talk",
            instructions: [
                "For your next range session, pay attention to your inner voice after each shot.",
                "Every time you catch a negative thought ('I'm terrible', 'here comes the slice'), stop it.",
                "Replace it with a neutral or positive statement: 'next one' or 'I know how to fix that.'",
                "Keep a tally: how many negative thoughts did you catch and replace in 50 balls?",
                "Your goal is to reduce negative self-talk by 50% over 4 sessions.",
                "On the course: pick 3 positive phrases and repeat one before every tee shot.",
                "Research shows positive self-talk directly improves motor performance in golf."
            ],
            durationMinutes: 10,
            equipment: ["Any club", "Range balls"],
            category: .mental,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_shot_commitment",
            name: "Full Commitment Practice",
            instructions: [
                "On the range, pick a specific target for every single shot. No 'just hitting balls.'",
                "Before each shot, go through your full pre-shot routine: pick target, visualize, commit.",
                "Once you step up to the ball, you are NOT allowed to back off or change your mind.",
                "If you feel doubt creeping in, swing anyway. Committed swings with a bad plan beat uncommitted swings every time.",
                "Rate each shot: was I 100% committed? Partially committed? Not committed?",
                "Goal: 80%+ of shots at 100% commitment by the end of the session.",
                "On the course, indecision is the #1 cause of bad shots."
            ],
            durationMinutes: 15,
            equipment: ["Any club", "Range balls"],
            category: .mental,
            difficulty: .beginner
        ),
        Drill(
            id: "drill_mindful_walking",
            name: "Mindful Walking Between Shots",
            instructions: [
                "During your next round, use the walk between shots as a mental reset.",
                "For the first 30 seconds after hitting, do your post-shot routine (react, analyze, release).",
                "For the middle of the walk: notice the course. Look at the trees, feel the air, enjoy the walk.",
                "Do NOT think about your score, the last hole, or upcoming holes.",
                "In the final 30 seconds before reaching your ball, shift to 'assessment mode': wind, lie, distance.",
                "This walking pattern keeps your mind fresh and prevents mental fatigue.",
                "Tour pros use a 'think box' (behind ball) and 'play box' (over ball) system — this is the same concept."
            ],
            durationMinutes: 5,
            equipment: ["None"],
            category: .mental,
            difficulty: .beginner
        ),
        // --- Intermediate ---
        Drill(
            id: "drill_bounce_back",
            name: "Bounce-Back Drill",
            instructions: [
                "On the range, intentionally hit 3 bad shots (top it, chunk it, slice it).",
                "After the bad shots, immediately follow with your pre-shot routine and hit the best shot you can.",
                "Rate the recovery shot. Was it solid despite the bad shots before it?",
                "Repeat: 3 bad shots, then 1 great recovery. Do this 5 times.",
                "This trains your brain to reset after mistakes — the #1 skill in competitive golf.",
                "On the course, your score is determined by how you respond to bad shots, not by avoiding them.",
                "The best players in the world make bogey and follow with birdie. Train that ability."
            ],
            durationMinutes: 15,
            equipment: ["Any club", "Range balls"],
            category: .mental,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_process_focus",
            name: "Process Over Outcome",
            instructions: [
                "Play a practice round where you score yourself on PROCESS, not results.",
                "Before each shot, give yourself a process goal: 'full shoulder turn' or 'smooth tempo.'",
                "After each shot, score yourself: did you execute the process? Yes = 1 point. No = 0.",
                "Ignore where the ball goes. A perfect process with a bad result still gets a point.",
                "A bad process with a good result gets zero points.",
                "Goal: 14+ out of 18 process points per round.",
                "When you focus on process, results take care of themselves."
            ],
            durationMinutes: 10,
            equipment: ["Scorecard", "Pen"],
            category: .mental,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_scoring_game",
            name: "Competitive Scoring Game",
            instructions: [
                "On the range, play an imaginary 9-hole course you know well.",
                "For each hole: pick the right club, aim at a specific target, and play your shot.",
                "Score each hole: fairway hit? Green hit? Estimate putts based on proximity.",
                "Move through all 9 holes with full pre-shot routines and different clubs.",
                "This transforms mindless range time into focused, game-like practice.",
                "Keep a running score and try to beat your best 'range round.'",
                "Research shows game-like practice transfers to the course 3x better than block practice."
            ],
            durationMinutes: 25,
            equipment: ["Full set of clubs", "Range balls", "Scorecard"],
            category: .mental,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_distraction_training",
            name: "Distraction Training",
            instructions: [
                "Have a friend stand nearby and make noise (talking, jingling keys) during your swing.",
                "Your goal: execute your pre-shot routine and swing as if they weren't there.",
                "Start with mild distractions and increase intensity over the session.",
                "If you flinch or lose focus, restart your routine from the beginning.",
                "Hit 20 balls with distractions. Track how many you execute cleanly.",
                "On the course, you'll face distractions constantly: cart noise, wind, playing partners.",
                "Training with distractions makes you bulletproof under pressure."
            ],
            durationMinutes: 15,
            equipment: ["Any club", "Range balls", "A friend"],
            category: .mental,
            difficulty: .intermediate
        ),
        Drill(
            id: "drill_focus_reset",
            name: "Focus Reset Trigger",
            instructions: [
                "Choose a physical trigger to reset your focus: adjusting your glove, pulling your sleeve, or tapping the club.",
                "Practice the trigger on the range: before each shot, perform your trigger deliberately.",
                "The trigger signals your brain: 'previous shot is gone, this shot matters now.'",
                "Hit 30 balls, performing the trigger before every single one. Make it automatic.",
                "On the course, use the trigger whenever your mind wanders to past or future holes.",
                "Tour pros all have a reset trigger — most fans never notice it.",
                "After 2 weeks of practice, the trigger becomes your instant focus switch."
            ],
            durationMinutes: 10,
            equipment: ["Any club", "Range balls"],
            category: .mental,
            difficulty: .intermediate
        ),
        // --- Advanced ---
        Drill(
            id: "drill_tournament_sim",
            name: "Full Tournament Simulation",
            instructions: [
                "Play a full 18-hole round treating it like a tournament: no mulligans, no gimmes, no breakfast balls.",
                "Use only one ball per hole (switch to a new ball if you lose one, with a penalty stroke).",
                "Before the round, set a target score. Play to beat it.",
                "Between holes, practice your walking routine: release, enjoy, assess.",
                "After the round, review: where did you lose strokes? Mental errors or physical errors?",
                "Rate your mental game 1-10 for each of these: commitment, composure, focus, routine.",
                "Do one tournament simulation per month to track your competitive readiness."
            ],
            durationMinutes: 10,
            equipment: ["Full set", "Scorecard", "One ball per hole"],
            category: .mental,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_course_management",
            name: "Course Management Strategy",
            instructions: [
                "Before your next round, create a strategy card for each hole.",
                "For each hole: where is the safe miss? Where should you aim the tee shot? What's the bail-out on the approach?",
                "Play the round following your strategy card exactly — even when you feel like going for the pin.",
                "After the round, compare: how many strokes did the strategy save vs. your usual aggressive play?",
                "Most amateurs aim at the pin. Tour pros aim at the fat side of the green.",
                "Reduce your 'hero shot' attempts by 50% and watch your scores drop.",
                "Update your strategy card after each round based on what you learned."
            ],
            durationMinutes: 15,
            equipment: ["Notepad", "Course map or yardage book"],
            category: .mental,
            difficulty: .advanced
        ),
        Drill(
            id: "drill_emotional_regulation",
            name: "Emotional Regulation Practice",
            instructions: [
                "During a practice round, deliberately put yourself in frustrating situations (bad lies, hard pins).",
                "Monitor your emotional state on a 1-10 scale after each shot (1 = calm, 10 = furious).",
                "When you hit a 6 or above, stop. Use your breathing routine. Walk slowly. Reset.",
                "The goal: keep your emotional average below 4 for the entire round.",
                "Track your highest emotional spike and what triggered it.",
                "Over multiple rounds, your spikes should get lower and recover faster.",
                "Elite performers don't avoid emotions — they manage the intensity and duration."
            ],
            durationMinutes: 10,
            equipment: ["Scorecard for tracking", "Pen"],
            category: .mental,
            difficulty: .advanced
        ),
    ]
}
