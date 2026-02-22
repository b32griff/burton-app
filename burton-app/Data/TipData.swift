import Foundation

struct TipData {
    static let all: [Tip] = [
        // MARK: - Grip & Setup
        Tip(
            id: "tip_grip_fix",
            title: "Fix Your Grip for Straighter Shots",
            summary: "A neutral grip is the foundation of a square clubface at impact.",
            body: "Check your grip by looking down at address. You should see two to two-and-a-half knuckles on your lead hand. The V formed by your thumb and index finger on both hands should point toward your trail shoulder. A grip that's too weak (rotated toward the target) opens the face and causes slices. Too strong (rotated away) closes it and causes hooks. Practice your grip at home for 5 minutes daily — muscle memory builds fast.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_setup_distance",
            title: "Perfect Your Setup Distance",
            summary: "Standing the right distance from the ball prevents many common mishits.",
            body: "At address, let your arms hang naturally from your shoulders. The butt end of the club should be about a fist's width from your thigh. If you're reaching, you'll likely hit the toe or shank it. If you're too close, you'll feel cramped and hit it fat. A good test: take your trail hand off the club at address. If your arm swings freely without hitting your body, you're at the right distance.",
            difficulty: .beginner,
            linkedIssueIDs: ["shanks", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_ball_position",
            title: "Nail Your Ball Position",
            summary: "Correct ball position changes with each club and affects strike quality.",
            body: "Driver: inside your lead heel. Long irons and hybrids: one ball back from the driver position. Mid irons: center of your stance. Short irons and wedges: slightly ahead of center. When your ball position drifts, your low point shifts too — leading to tops (too far forward) and fat shots (too far back). Use alignment sticks on the range to check your ball position until it becomes automatic.",
            difficulty: .beginner,
            linkedIssueIDs: ["topping", "fat_shots"]
        ),
        // MARK: - Swing Path & Clubface
        Tip(
            id: "tip_swing_path",
            title: "Understand Your Swing Path",
            summary: "The path your club travels through impact determines the ball's starting direction.",
            body: "An outside-to-inside path sends the ball left of target (for righties) and puts slice spin on it. An inside-to-outside path starts the ball right with draw/hook spin. The goal for most golfers is a slightly inside-to-square path. Imagine a clock face on the ground: you want to swing from 4 o'clock to 10 o'clock, not from 2 to 8. Place a headcover just outside the ball to train an in-to-out path.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "shanks"]
        ),
        Tip(
            id: "tip_clubface_awareness",
            title: "Master Clubface Control",
            summary: "The clubface angle at impact is the #1 factor in where the ball goes.",
            body: "The clubface accounts for about 75% of the ball's starting direction. If you slice, your face is open to the path. If you hook, it's closed. A simple awareness drill: hit balls with a half swing and focus solely on where the face is pointing at impact. Try to hit intentional fades and draws. When you can control the face, you control the ball. Start with short irons where the feedback is clearest.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_shoulder_alignment",
            title: "Check Your Shoulder Alignment",
            summary: "Where your shoulders aim often overrides where your feet point.",
            body: "Many golfers align their feet correctly but let their shoulders open toward the target. This produces an outside-in swing path and a slice. At address, your shoulder line should be parallel to your target line — just like a railroad track. Have a friend hold a club across your shoulders to check. If you've been slicing, odds are you'll feel like you're aiming right of target when you're actually square. Trust it.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice"]
        ),
        // MARK: - Weight & Balance
        Tip(
            id: "tip_weight_transfer",
            title: "Transfer Your Weight Like a Pro",
            summary: "Proper weight shift creates power and ensures ball-first contact.",
            body: "At the top of your backswing, about 60% of your weight should be on your trail foot. As you start the downswing, shift onto your lead foot so that at impact, 80% or more of your weight is forward. The key move: feel like your lead hip bumps toward the target to start the downswing, then rotates. If your weight stays back, you'll hit fat shots and tops. Practice hitting balls with your trail foot on its toe at impact.",
            difficulty: .intermediate,
            linkedIssueIDs: ["topping", "fat_shots"]
        ),
        Tip(
            id: "tip_balance",
            title: "Stay Balanced for Better Strikes",
            summary: "Good balance throughout the swing leads to consistent contact.",
            body: "If you can't hold your finish for 3 seconds, you're swinging too hard or losing balance during the swing. Focus on feeling your weight centered on the balls of your feet at address — not on your toes or heels. During the swing, maintain your spine angle and resist the urge to lunge at the ball. A balanced swing at 80% effort will go farther and straighter than an unbalanced swing at 100%.",
            difficulty: .beginner,
            linkedIssueIDs: ["shanks"]
        ),
        Tip(
            id: "tip_weight_forward",
            title: "Keep Your Weight Forward When Chipping",
            summary: "Favoring your lead side prevents fat and thin chip shots.",
            body: "Set up with 60-70% of your weight on your lead foot, and keep it there throughout the chip. Position the ball back of center in your stance with your hands ahead of the ball. This setup naturally produces the slightly descending strike you need for crisp chips. The biggest mistake in chipping is trying to help the ball up — trust the loft of the club and make a descending blow.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping"]
        ),
        // MARK: - Power & Distance
        Tip(
            id: "tip_hip_rotation",
            title: "Unlock Power with Hip Rotation",
            summary: "Your hips are the engine of your golf swing — use them properly.",
            body: "Many amateurs use only their arms, leaving 30-40 yards on the table. In the backswing, turn your hips 45 degrees while your shoulders turn 90 degrees. This creates the 'X-factor' — the differential between hip and shoulder turn that stores power. In the downswing, fire your hips first. Feel your belt buckle race to face the target before your hands reach the ball. Your arms will follow and whip through with stored energy.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_lag",
            title: "Create Lag for Explosive Impact",
            summary: "Maintaining the angle between your wrists and club shaft adds serious speed.",
            body: "Lag is the angle formed between your lead forearm and the club shaft in the downswing. Tour pros maintain this angle deep into the downswing, releasing it at the last moment for maximum speed at impact. To feel lag, practice the 'pump drill': take the club to the top, start the downswing, stop halfway down (maintaining the wrist angle), then complete the swing. It should feel like you're pulling the grip end of the club, not pushing the clubhead.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_release_timing",
            title: "Time Your Release for Maximum Speed",
            summary: "Releasing the club at the right moment converts stored energy into ball speed.",
            body: "An early release (casting) spends your power before impact. A late release blocks the face open. The ideal release happens naturally when your body sequence is correct: hips, then torso, then arms, then hands. Don't try to consciously flip the club — instead, focus on getting your body rotation right. Feel like you're 'throwing' the clubhead through the ball with a relaxed grip. The whoosh of the club should happen at the ball, not before it.",
            difficulty: .advanced,
            linkedIssueIDs: ["hook", "lack_of_distance"]
        ),
        // MARK: - Consistency
        Tip(
            id: "tip_stay_down",
            title: "Stay Down Through Impact",
            summary: "Maintaining your posture through the hitting zone prevents thin and topped shots.",
            body: "Early extension — standing up through impact — is one of the most common amateur faults. It causes your hands to rise and the club to miss the bottom of the ball. The fix: feel like your chest stays over the ball through impact. Your head shouldn't rise until well after the ball is gone. A great thought is 'watch the ball leave the club face.' This keeps you down and through rather than up and out.",
            difficulty: .intermediate,
            linkedIssueIDs: ["topping", "fat_shots"]
        ),
        Tip(
            id: "tip_divot_pattern",
            title: "Read Your Divots",
            summary: "Your divot tells a story about your swing — learn to read it.",
            body: "A good divot starts at or just after the ball position and points at the target. If your divot is behind the ball: you're hitting it fat (weight back, or casting). If there's no divot with irons: you might be scooping. If it points left: your path is outside-in. If it points right: you're swinging too far inside-out. After each iron shot on the range, glance at your divot. It's free swing feedback.",
            difficulty: .beginner,
            linkedIssueIDs: ["fat_shots"]
        ),
        Tip(
            id: "tip_preshot_routine",
            title: "Build a Bulletproof Pre-Shot Routine",
            summary: "A consistent routine creates consistency under pressure.",
            body: "Every tour pro has a pre-shot routine they follow on every single shot. Yours should take 15-25 seconds and include: (1) Stand behind the ball and pick a specific target. (2) Pick an intermediate target 2-3 feet ahead of the ball on your target line. (3) Set up to the ball, aligning your clubface to the intermediate target. (4) Take one look at the target, one look at the ball, and swing. Never skip steps, even on the range. The routine trains your subconscious to take over when pressure hits.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),
        Tip(
            id: "tip_one_thought",
            title: "One Swing Thought Maximum",
            summary: "Paralysis by analysis is real — simplify your thinking over the ball.",
            body: "Your conscious mind can only handle one thought during a 1.5-second golf swing. Having multiple swing thoughts creates hesitation, tension, and inconsistency. Before each practice session, pick ONE thing to work on. Over the ball, your thought should be simple and positive: 'smooth tempo,' 'turn to the target,' or 'low and slow.' During a round, avoid mechanical thoughts entirely — use a feel or image instead. Save the mechanical work for the range.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),
        // MARK: - Short Game
        Tip(
            id: "tip_chipping_setup",
            title: "The Perfect Chipping Setup",
            summary: "Great chipping starts before you ever take the club back.",
            body: "Narrow your stance to about hip width. Open your stance slightly (lead foot pulled back). Play the ball back of center. Press your hands forward so the shaft leans toward the target. Put 60% of your weight on your lead foot. Keep your grip soft. Now make a simple pendulum motion with your shoulders — minimal wrist action. The club's loft does the work of getting the ball airborne. Your job is to make clean contact with a descending blow.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping"]
        ),
        Tip(
            id: "tip_club_selection_chips",
            title: "Pick the Right Club Around the Green",
            summary: "Not every chip needs a lob wedge — match the club to the situation.",
            body: "The golden rule of chipping: get the ball on the ground and rolling as soon as possible. If you have lots of green to work with, use a 7 or 8 iron for a bump-and-run. If you need to carry a little rough before the green, use a pitching wedge. Only reach for the sand or lob wedge when you need height to carry a bunker or stop quickly. Lower-lofted chips are far more forgiving and consistent. Tour pros chip with everything from 6-iron to lob wedge.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping"]
        ),
        // MARK: - Putting
        Tip(
            id: "tip_lag_putting",
            title: "Master Lag Putting to Eliminate Three-Putts",
            summary: "Getting your first putt close is more important than making it.",
            body: "On putts over 20 feet, your goal isn't to make it — it's to leave it within a 3-foot circle around the hole. Focus on distance control, not line. Look at the hole, look at the ball, and let your body sense the distance like you're tossing a ball underhand. Match your backstroke length to the putt distance: short backstroke for short putts, longer for long putts. Tempo should stay constant. Practice lag putting before every round — it's the fastest way to eliminate three-putts.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),
        Tip(
            id: "tip_green_reading",
            title: "Read Greens Like a Pro",
            summary: "Most amateurs under-read break by 50% or more.",
            body: "First, look at the overall slope of the green as you walk up to it — this gives you the big picture. Then, read from behind the ball looking toward the hole. Next, read from behind the hole looking back. Finally, check the low side of the putt. Most amateurs don't play enough break. When in doubt, play more break, not less. Also consider: grain direction (grass grows toward the setting sun and toward water), and that putts break more as they slow down near the hole.",
            difficulty: .intermediate,
            linkedIssueIDs: ["three_putting"]
        ),
        Tip(
            id: "tip_putting_tempo",
            title: "Find Your Putting Tempo",
            summary: "Consistent tempo is the secret to consistent distance control.",
            body: "Tour pros have a remarkably consistent putting tempo: the backstroke is roughly twice as long as the follow-through in duration. Try counting '1' on the backstroke and '2' at impact. The stroke should feel like a pendulum — same pace back and through. Never decelerate through the ball; that's the death of good putting. If you're having trouble, try a metronome app set to 76 BPM. Back on one beat, through on the next.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),
        Tip(
            id: "tip_short_putt_routine",
            title: "Never Miss Inside 5 Feet",
            summary: "Short putts require confidence and a dead-simple routine.",
            body: "For putts inside 5 feet: pick the line, set the putter face exactly where you want it, align your body to the putter (not the other way around), take one look at the hole, and stroke it. Don't over-read these putts — most short putts are straighter than you think. Keep your head still and listen for the ball to drop instead of looking up. Practice with a gate drill (two tees slightly wider than your putter) to build confidence in your stroke.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),
        // MARK: - Mental Game
        Tip(
            id: "tip_breathing",
            title: "Use Breathing to Control Nerves",
            summary: "A simple breathing technique can lower your heart rate in 30 seconds.",
            body: "When you feel nervous (first tee, pressure putt, over water), try box breathing: breathe in for 4 counts, hold for 4 counts, breathe out for 4 counts, hold empty for 4 counts. Do this twice before stepping up to the ball. This activates your parasympathetic nervous system and lowers your heart rate. Pair it with relaxing your hands — squeeze your grip tight then release to your playing pressure. Your body can't be tense and relaxed at the same time.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves"]
        ),
        Tip(
            id: "tip_acceptance",
            title: "Practice Radical Acceptance",
            summary: "Accepting bad shots is a superpower that keeps your round on track.",
            body: "Every golfer hits bad shots — even tour pros hit 3-4 truly bad shots per round. The difference is their response. After a bad shot, give yourself a 10-second window to be frustrated, then let it go completely. Your next shot doesn't know about the last one. Approach each shot fresh. The quickest way to turn a bogey into a double or triple is to let frustration affect your next swing. Play the shot you have, not the one you wish you had.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves"]
        ),
        // MARK: - Grip & Setup
        Tip(
            id: "tip_grip_pressure",
            title: "Dial In Your Grip Pressure",
            summary: "Holding the club with the right pressure unlocks speed and consistency.",
            body: "On a scale of 1 to 10 where 10 is a death grip, you should hold the club at about a 4. Too tight and you restrict wrist hinge, forearm rotation, and overall clubhead speed. Too light and you lose control at the top. A useful image: hold the club like you're holding a tube of toothpaste without the cap — firm enough that it doesn't fly out, soft enough that nothing squeezes out. Check your forearms at address — if you see tension lines, lighten up.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_stance_width",
            title: "Match Your Stance Width to the Club",
            summary: "The right stance width provides a stable base without restricting rotation.",
            body: "For a driver, your feet should be roughly shoulder-width apart, measured from the insides of your heels. For a mid-iron, narrow your stance by about two inches on each side. For short irons and wedges, bring your feet to just inside hip width. A stance that is too wide limits hip rotation and makes it hard to transfer your weight. A stance that is too narrow costs you stability and balance. Experiment on the range to find the width that lets you rotate freely while staying balanced through the finish.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),
        Tip(
            id: "tip_posture_setup",
            title: "Build Athletic Posture at Address",
            summary: "Good posture sets the stage for a powerful, repeatable swing.",
            body: "Stand tall, then hinge forward from your hip joints — not your waist — until your arms hang naturally below your shoulders. Add a slight flex in your knees, as though you're about to jump. Your weight should be on the balls of your feet, not your heels or toes. Your back should be relatively straight with a slight natural curve in the lower spine. Avoid the two common faults: the S-posture (too much arch) and the C-posture (too much rounding). Good posture allows your arms to swing freely and your body to rotate without restriction.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),
        Tip(
            id: "tip_spine_angle",
            title: "Maintain Your Spine Angle Throughout the Swing",
            summary: "Losing your spine angle mid-swing is one of the most destructive faults in golf.",
            body: "Your spine angle at address should remain constant from takeaway through impact. If you stand up during the backswing or downswing (called early extension), you change the radius of your swing arc and lose contact quality. A great drill is to set up with your backside touching a wall or chair and make slow swings while keeping contact throughout. You can also have a friend hold a club against your back at address and feel it stay connected during your backswing. Maintaining spine angle is a hallmark of elite ball-strikers.",
            difficulty: .intermediate,
            linkedIssueIDs: ["topping", "inconsistent_contact", "fat_shots"]
        ),
        Tip(
            id: "tip_hand_position_address",
            title: "Set Your Hands Correctly at Address",
            summary: "Where your hands sit at address influences your entire impact position.",
            body: "For irons, your hands should be slightly ahead of the ball at address — roughly over your lead thigh. This forward press position promotes a descending strike and ball-first contact. For the driver, your hands should be roughly even with the ball or just barely ahead, since you want to hit up on the ball with the driver. Avoid setting your hands behind the ball with any club, as this adds loft and encourages scooping. A good checkpoint: with an iron, the shaft should lean slightly toward the target when viewed from down the line.",
            difficulty: .beginner,
            linkedIssueIDs: ["fat_shots", "topping", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_tee_height_general",
            title: "Optimize Your Tee Height for Every Club",
            summary: "Tee height directly affects launch angle and contact point on the face.",
            body: "For a driver, tee the ball so that half the ball sits above the top edge of the clubface at address. For a 3-wood off a tee, the ball should sit just above the crown. For hybrids and long irons off a tee, use a short tee with the ball barely above the grass. For short irons on par threes, push the tee down so the ball is at grass level — this mimics a fairway lie and promotes a descending strike. Getting tee height wrong by even half an inch can shift your launch window and cost you distance or accuracy.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "topping"]
        ),
        Tip(
            id: "tip_foot_flare",
            title: "Use Foot Flare to Improve Rotation",
            summary: "Turning your toes out slightly can dramatically improve your hip turn.",
            body: "Flaring your lead foot 20-30 degrees open (toward the target) makes it easier to rotate your hips through impact and into a full finish. Flaring your trail foot 10-15 degrees helps you load into your trail hip during the backswing. If you struggle with a restricted backswing, try flaring the trail foot more. If you have trouble clearing your hips through impact, flare the lead foot more. Players with less flexibility benefit the most from added foot flare — it's a free range-of-motion boost that costs nothing.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_ball_position_wedges",
            title: "Ball Position for Wedge Shots",
            summary: "Placing the ball correctly for wedges sharpens your scoring shots.",
            body: "For full wedge shots, position the ball in the center of your stance or one ball-width ahead of center. This promotes the descending contact you need for spin and control. For partial wedge shots and finesse shots around the green, move the ball back to center or even slightly behind center. This delofts the club slightly and ensures you hit the ball before the turf. Never play wedges off your lead foot like a driver — you will add loft, lose distance control, and blade shots over the green.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "fat_shots"]
        ),
        Tip(
            id: "tip_ball_position_fairway_woods",
            title: "Ball Position for Fairway Woods",
            summary: "Fairway woods require a slightly different ball position than irons or driver.",
            body: "Position the ball about two inches inside your lead heel for fairway woods — roughly one ball-width back from your driver position. This lets you make contact at the very bottom of your swing arc or with a very slight descending blow, which is ideal for fairway woods off the deck. If you play the ball too far forward, you will catch it thin or top it as the club is already ascending. If you play it too far back, you will hit down too steeply and pop the ball up with excessive spin. Find the sweet spot where you sweep the ball cleanly off the turf.",
            difficulty: .intermediate,
            linkedIssueIDs: ["topping", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_setup_drill_alignment_sticks",
            title: "The Alignment Stick Setup Drill",
            summary: "Two alignment sticks can fix your setup in minutes on the range.",
            body: "Place one alignment stick on the ground pointing at your target, just outside the ball. Place the second stick parallel to the first, along your toe line. This creates the 'railroad track' visual that shows you exactly where your body and club are aimed. Now check your ball position relative to the sticks on every shot. After a few sessions, your setup becomes automatic. You can add a third stick perpendicular to the first to verify ball position. This simple drill is used by nearly every tour professional during practice.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_grip_in_fingers",
            title: "Hold the Club in Your Fingers, Not Your Palms",
            summary: "A finger grip allows proper wrist hinge and maximizes clubhead speed.",
            body: "The club should rest along the base of your fingers in your lead hand, running from the middle of your index finger to just below the heel pad. When you close your hand, the heel pad sits on top of the grip. In your trail hand, the club sits entirely in the fingers. A common mistake is letting the grip slide into the palms, which locks out your wrists and kills speed. To check, grip the club and see if you can freely hinge your wrists up and down. If it feels locked, the grip is too much in your palms.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_strong_vs_weak_grip",
            title: "Understand Strong vs. Weak Grip Adjustments",
            summary: "Small grip rotations can cure persistent shot shapes without changing your swing.",
            body: "If you consistently slice, try strengthening your grip: rotate both hands slightly away from the target (clockwise for a right-handed golfer) until you see three knuckles on your lead hand. If you consistently hook, weaken your grip by rotating both hands toward the target until you see only one knuckle. These are small adjustments — rotating even a quarter-inch can change your ball flight significantly. Make grip changes in small increments and hit 20-30 balls between each adjustment to see the true effect. A grip change is often the fastest fix for a persistent miss.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        // MARK: - Alignment & Aim
        Tip(
            id: "tip_target_selection",
            title: "Pick a Specific Target, Not a General Direction",
            summary: "Vague targets produce vague shots — specificity breeds accuracy.",
            body: "Never aim at 'the fairway' or 'the green.' Instead, pick the smallest target you can see: a specific tree, a yardage marker, a discolored patch of grass, or the top of the flagstick. The smaller your target, the smaller your misses. Tour pros pick targets the size of a basketball, even on a 300-yard drive. If you aim at a tiny spot and miss by five yards, you're still in great shape. If you aim at 'the middle of the fairway' and miss by the same five yards, you might be in trouble.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_intermediate_target",
            title: "Use an Intermediate Target to Align",
            summary: "A spot a few feet ahead of the ball makes alignment far more accurate.",
            body: "Stand behind the ball and draw an imaginary line from the ball to your target. Find a spot on that line just two to three feet in front of the ball — a divot, a discolored blade of grass, a leaf. Now align your clubface to that intermediate target. It is dramatically easier to aim at something three feet away than something 200 yards away. Jack Nicklaus used this technique on every single shot of his career. Once your clubface is set to the intermediate spot, build your stance around the clubface, not the other way around.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_alignment_stick_practice",
            title: "Train Alignment with Stick Drills on the Range",
            summary: "Practicing with alignment sticks grooves proper aim into your subconscious.",
            body: "Lay an alignment stick on the ground aimed at your target, parallel to and just outside your ball-to-target line. Lay a second stick along your toe line, parallel to the first. Hit 30-50 balls this way at the start of every range session. Over time, your body memorizes what correct alignment feels like. When you get to the course without sticks, you will naturally fall into the right position. The key mistake is practicing without any alignment aids and unknowingly grooving a faulty aim — then wondering why the ball keeps missing in one direction.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_visual_alignment_trick",
            title: "Step In from Behind for Better Visual Alignment",
            summary: "Approaching the ball from behind the target line gives a clearer aim picture.",
            body: "Instead of walking to the ball from the side and guessing your aim, stand directly behind the ball looking down the target line. Pick your intermediate target. Then walk into your setup from behind the ball, setting the clubface first, then building your stance around it. This approach gives your brain a clear picture of the target line before you commit to your stance. Many amateurs set up from the side and subconsciously aim their bodies at the target instead of parallel to the target line, which causes the club to cut across the ball.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_railroad_tracks",
            title: "Understand the Railroad Tracks Concept",
            summary: "Your body aims parallel left of the target, not directly at it.",
            body: "Imagine two railroad tracks running toward your target. The ball sits on the outer rail (the target line). Your feet, knees, hips, and shoulders align along the inner rail, which is parallel to the target line but left of it (for right-handed golfers). This means your body should never aim directly at the target — it should aim at a point the same distance left of the target as you are from the ball. This parallel alignment concept is one of the most misunderstood fundamentals in golf. Practicing with two sticks on the ground makes this crystal clear.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_body_alignment_check",
            title: "Check All Four Alignment Points",
            summary: "Feet alignment alone is not enough — shoulders matter most.",
            body: "Your body has four alignment lines: feet, knees, hips, and shoulders. All four must be parallel to the target line for a straight shot. The most important one is your shoulder line because your arms hang from your shoulders, and they dictate swing path. Many golfers have square feet but open shoulders, which produces an out-to-in path and a slice. During your next range session, ask a friend to hold a club across your shoulders at address. If it points left of target, your shoulders are open. Make adjustments until all four lines match.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_aim_dogleg",
            title: "Aiming Strategy on Dogleg Holes",
            summary: "Smart aim on doglegs can save strokes without requiring a big shot shape.",
            body: "On a dogleg left, aim at the right side of the fairway or even the right edge of the corner. Your natural shot shape will usually work the ball toward the middle, and even a straight ball ends up in good position. On a dogleg right, do the opposite. Avoid the temptation to cut the corner unless you have a reliable shot shape that matches the dogleg direction. The penalty for a failed attempt to cut a corner is usually far worse than the reward for pulling it off. Play to the wide side of the fairway and take your par.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_aim_compensation",
            title: "Aim for Your Miss, Not Your Best Shot",
            summary: "Smart course management means playing for your most likely shot, not your ideal one.",
            body: "If you consistently fade the ball 10 yards, aim 10 yards left of your target. Do not aim straight and hope it goes straight this time. Your natural shot shape is your friend when you account for it. The biggest alignment mistake amateurs make is aiming at the target and then being frustrated when their natural shape takes it offline. Tour pros set up their alignment expecting their stock shape. When you plan for the miss, your miss still finds the fairway, and your best shot ends up on target.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_eyes_alignment_illusion",
            title: "Beware the Optical Illusion at Address",
            summary: "Your eyes can deceive you when you look from the ball to the target.",
            body: "When you stand over the ball and turn your head to look at the target, your perception shifts. What looks like 'straight at the target' is often several degrees left because your eyes are inside the target line, not on it. This optical illusion causes many golfers to subconsciously pull their aim left. The fix is to trust your alignment process done from behind the ball rather than adjusting once you are standing over it. Set up, commit to your aim, and do not second-guess what your eyes tell you at address. Your behind-the-ball perspective is far more reliable.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_flag_vs_center_green",
            title: "Aim at the Center of the Green, Not the Flag",
            summary: "Firing at every pin is a high-handicapper's trap that costs strokes.",
            body: "Unless the pin is in the center of the green or you are inside 130 yards with a short iron, aim at the middle of the green. Missing the fat part of the green still leaves you with a straightforward chip or putt. Missing a tucked pin usually means bunkers, slopes, or short-sided disasters. Tour pros only attack pins when the risk-reward favors it. For most recreational golfers, hitting more greens in regulation — even 30 feet from the pin — will lower your scores faster than anything else. The center of the green is never a bad play.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),
        Tip(
            id: "tip_alignment_tee_box",
            title: "Use the Tee Box to Your Advantage",
            summary: "Where you tee the ball on the tee box changes your effective aim.",
            body: "Tee markers rarely aim perfectly down the fairway, and you can use the full width of the tee box to create a better angle. On a dogleg left, tee up on the far right side of the tee box so you can aim more comfortably down the left side. On a dogleg right, tee up on the far left side. If there is trouble on one side of a hole, tee up on the same side as the trouble and aim away from it — this opens up the maximum amount of fairway for your shot. This simple tee box strategy costs nothing and can save several strokes per round.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_alignment_practice_routine",
            title: "Build an Alignment Check into Every Practice Session",
            summary: "Checking your alignment regularly prevents slow, unconscious drift over time.",
            body: "Alignment faults creep in gradually — you rarely notice when your aim shifts a few degrees over weeks of play. Make it a habit to lay down alignment sticks for the first 10 minutes of every range session and verify your feet, hips, and shoulders are all parallel to the target line. Once verified, remove the sticks and hit 10 more balls, then put them back and check again. This builds a self-correcting loop that keeps your alignment honest. Tour pros check their alignment constantly because they know even a one-degree shift compounds over 200 yards into a significant miss.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        // MARK: - Swing Mechanics
        Tip(
            id: "tip_takeaway",
            title: "Start Your Swing with a One-Piece Takeaway",
            summary: "A smooth, connected takeaway sets the tone for the entire swing.",
            body: "In the first 18 inches of the backswing, your hands, arms, and shoulders should move together as a single unit. The clubhead stays low to the ground and moves straight back along the target line before beginning to arc inside. Avoid the two common takeaway faults: snatching the club inside with your hands, or pushing it too far outside with your arms. A great checkpoint: when the club is parallel to the ground in the takeaway, the clubhead should be directly over your hands and the toe of the club should point straight up.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_backswing_width",
            title: "Create Width in Your Backswing",
            summary: "A wide backswing arc stores more energy for a powerful downswing.",
            body: "Width means keeping your lead arm relatively straight (not rigid) and extending the clubhead away from your body during the backswing. Think of your lead arm as the radius of a circle — the longer the radius, the bigger the arc, and the more speed you can generate. A narrow, armsy backswing with bent elbows generates very little power. To feel width, practice making slow backswings and reaching the clubhead as far from your trail ear as possible at the top. You should feel a stretch in your lead side and lat muscle.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_backswing_top_position",
            title: "Find the Right Position at the Top",
            summary: "Where the club sits at the top of your backswing dictates your downswing path.",
            body: "At the top of a full backswing, the club shaft should be roughly parallel to the ground and parallel to the target line. Your lead wrist should be flat or slightly bowed, not cupped. If the shaft points left of the target (across the line), you will tend to come over the top. If it points right (laid off), you will tend to get stuck inside. A useful checkpoint: have someone film your swing from behind. The shaft at the top should point at or slightly left of the target. Small corrections at the top create big improvements at impact.",
            difficulty: .advanced,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_downswing_sequence",
            title: "Master the Kinetic Chain in the Downswing",
            summary: "The correct downswing sequence is the single biggest separator between pros and amateurs.",
            body: "The downswing should fire from the ground up: feet, then knees, then hips, then torso, then arms, then hands, then clubhead. This is the kinetic chain, and each segment accelerates the next like cracking a whip. Most amateurs start the downswing with their arms or shoulders, which destroys the chain and costs enormous speed. The key feel is that your lower body starts the downswing while your arms and club are still completing the backswing. This creates a momentary stretch across your torso that unleashes tremendous power when it unwinds.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_follow_through",
            title: "Commit to a Full Follow-Through",
            summary: "A complete follow-through is evidence that you swung through the ball, not at it.",
            body: "Your swing should not end at impact — the ball is simply in the way of your motion toward the target. In a proper finish, your belt buckle faces the target, your weight is fully on your lead foot, your trail shoulder is closer to the target than your lead shoulder, and you can hold the position for three seconds. If you cannot reach this position or hold it, something went wrong earlier in the swing. Practicing swinging to a full finish — even without a ball — trains your body to accelerate through impact rather than decelerating into it.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_extension_through_impact",
            title: "Extend Your Arms Through the Impact Zone",
            summary: "Full extension through the ball creates solid contact and maximum speed.",
            body: "Through the impact zone, both arms should straighten fully, creating a wide arc past the ball. This position, sometimes called the 'triangle' of your shoulders and hands, should be visible in the follow-through when the club reaches about hip height. If your arms collapse or chicken-wing after impact (lead elbow bending outward), you are decelerating and losing both speed and accuracy. A great drill is to hit punch shots where you stop at hip-height in the follow-through with both arms extended and the clubface pointing at the target.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_body_rotation",
            title: "Rotate Your Body, Don't Slide",
            summary: "Rotation creates power; lateral sliding creates inconsistency.",
            body: "Your body should rotate around a relatively stable spine during the swing. In the backswing, your trail hip should turn behind you, not slide away from the target. In the downswing, your lead hip should rotate open, not slide toward the target. A small lateral bump to start the downswing is acceptable, but excessive sliding shifts your low point and leads to fat and thin shots. Practice by placing a chair or alignment stick against your lead hip at address and rotating without pushing it sideways. Rotation keeps your center steady and your contact consistent.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_swing_plane",
            title: "Understand Swing Plane Basics",
            summary: "Swinging on the correct plane simplifies the path to consistent ball-striking.",
            body: "The swing plane is the angle at which the club travels around your body. Picture a tilted hula hoop resting on your shoulders and touching the ball — your club should travel roughly along that hoop. If you swing too upright (steep), you tend to come over the top and hit pulls or slices. If you swing too flat, you tend to get stuck and hit pushes or hooks. Your ideal plane is largely determined by your height, arm length, and posture. Video your swing from down the line and check that the club travels on a consistent plane back and through.",
            difficulty: .advanced,
            linkedIssueIDs: ["slice", "hook", "shanks"]
        ),
        Tip(
            id: "tip_tempo_and_rhythm",
            title: "Develop Consistent Tempo",
            summary: "Great tempo ties your entire swing together regardless of club or situation.",
            body: "Tour professionals swing with a remarkably consistent tempo: the ratio of backswing time to downswing time is roughly 3:1, whether they are hitting a driver or a wedge. This means the backswing takes about three times as long as the downswing. Many amateurs rush the backswing and then have nothing left to accelerate in the downswing. Try counting 'one-two-three' on the backswing and 'four' at impact. You can also use a metronome app set to about 72-76 BPM to train consistent tempo. Tempo is the glue that holds your mechanics together under pressure.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),
        Tip(
            id: "tip_smooth_transition",
            title: "Smooth the Transition from Backswing to Downswing",
            summary: "The transition is where most swings go wrong — a gentle shift makes all the difference.",
            body: "The transition is the moment between the backswing and downswing. Rushing it is the number one cause of over-the-top moves and casting. Feel a slight pause at the top — not a stop, just a gentle change of direction. Think of a pendulum at its highest point: it decelerates smoothly, pauses briefly, then accelerates in the new direction. Your lower body starts moving toward the target while your hands and club are still settling at the top. This creates lag naturally and ensures the downswing fires in the correct sequence.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_acceleration_through_ball",
            title: "Accelerate Through the Ball, Not To It",
            summary: "Maximum clubhead speed should occur at or just past the ball, never before it.",
            body: "Many amateurs reach peak speed well before impact because they cast the club early in the downswing. This means the club is actually decelerating at impact — costing distance and consistency. The proper feel is that you are speeding up through the hitting zone. Think of cracking a whip: the tip accelerates at the very end. A great drill is to swing and try to make the loudest 'whoosh' sound at the ball, not before it. If the whoosh happens behind you, you are releasing too early. Move the whoosh forward until it is at or past the ball.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_quiet_lower_body_backswing",
            title: "Keep Your Lower Body Quiet in the Backswing",
            summary: "Resisting with your lower body while turning your upper body creates a power coil.",
            body: "Your hips should turn about half as much as your shoulders during the backswing. This differential creates the X-factor stretch that stores elastic energy. If your hips spin the same amount as your shoulders, you lose the coil and have no power to unleash in the downswing. Feel like your trail knee maintains its flex and your trail hip stays back as your shoulders complete their turn. Your lower body provides a stable platform that your upper body winds against. The resulting tension is what creates effortless power on the downswing.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_wrist_hinge",
            title: "Hinge Your Wrists Correctly in the Backswing",
            summary: "Proper wrist hinge creates the lever that multiplies clubhead speed.",
            body: "Your wrists should begin hinging naturally as the club passes hip height in the backswing. By the time you reach the top, your lead wrist should be flat and there should be a 90-degree angle between your lead forearm and the club shaft. This angle is your speed lever. Do not consciously hold or force the hinge — it should happen naturally from the weight of the clubhead. If you struggle, try the 'set and turn' drill: hinge your wrists to set the club at 90 degrees first, then turn your body to complete the backswing. This isolates the hinge feeling.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_connection_drill",
            title: "Stay Connected with the Towel Drill",
            summary: "Keeping your arms connected to your body improves consistency and power.",
            body: "Tuck a small towel or glove under each armpit and make half to three-quarter swings without letting either one drop. This trains your arms to work in sync with your body rotation rather than swinging independently. When your arms disconnect from your body, you lose the leverage of your big muscles and rely on timing-dependent hand action. Connected players hit the ball more consistently because their club is always in a predictable position relative to their body. Start with short irons and small swings, then gradually work up to longer clubs.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "shanks"]
        ),
        Tip(
            id: "tip_head_steady",
            title: "Keep Your Head Steady, Not Still",
            summary: "A steady head is essential, but a locked head restricts your swing.",
            body: "Your head should remain relatively steady during the swing, but it does not need to be frozen. A small lateral movement away from the target in the backswing is perfectly acceptable — even desirable, as it helps you load your trail side. The key is that your head should not bob up and down or lunge forward. Excessive vertical or forward head movement changes your swing arc and causes inconsistent contact. Think of your head as the hub of a wheel: it stays centered while everything else rotates around it. On the downswing, let your head rotate with your body through impact.",
            difficulty: .beginner,
            linkedIssueIDs: ["topping", "fat_shots", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_swing_rehearsal",
            title: "Use Slow-Motion Rehearsals to Engrain Positions",
            summary: "Practicing in slow motion lets your body learn positions your fast swing cannot feel.",
            body: "Make five slow-motion swings for every ball you hit on the range. Move at about 25% speed and pause at key checkpoints: takeaway, top of the backswing, halfway down, impact, and follow-through. Feel where your weight is, where the club is, and where your body is pointing at each position. Your brain cannot process mechanical positions at full speed, but it can map them at slow speed and then transfer that motor pattern to the real swing. This is how elite athletes in every sport train complex movements. Slow is smooth, and smooth is fast.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "slice"]
        ),
        // MARK: - Driving & Tee Shots
        Tip(
            id: "tip_driver_setup",
            title: "Set Up for Success with the Driver",
            summary: "The driver setup is fundamentally different from an iron setup.",
            body: "With the driver, widen your stance to shoulder width, position the ball off your lead heel, and tilt your spine slightly away from the target so your trail shoulder is lower than your lead shoulder. Your hands should be roughly even with the ball or slightly behind it. This setup promotes the upward angle of attack that maximizes driver distance. Unlike irons where you want to hit down, the driver works best when you hit up on the ball. Feeling like you're behind the ball at address is the foundation of a powerful drive.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "slice"]
        ),
        Tip(
            id: "tip_tee_height_driver",
            title: "Find the Perfect Driver Tee Height",
            summary: "A precise tee height helps you catch the ball on the upswing for maximum distance.",
            body: "For the driver, tee the ball so that half the ball is visible above the top edge of the clubface when the driver sole rests on the ground. Teeing it too low promotes a steep, descending hit that adds spin and reduces distance. Teeing it too high can cause you to sky the ball or catch it on the top edge of the face. If you are consistently hitting the ball too high on the face (sky marks on the crown), lower your tee. If you are catching it low on the face, raise it. Fine-tuning tee height by even a quarter inch can add 10-15 yards.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "topping"]
        ),
        Tip(
            id: "tip_upward_angle_of_attack",
            title: "Hit Up on the Ball with Your Driver",
            summary: "An upward angle of attack with the driver maximizes carry distance and reduces spin.",
            body: "Launch monitor data shows that hitting up on the ball by 3-5 degrees with a driver can add 20-30 yards versus hitting down on it. To achieve this, make sure the ball is forward in your stance, your spine tilts slightly away from the target, and you feel like you are swinging up through the ball. A great drill is to place a tee two inches in front of the ball and try to clip the front tee after striking the ball. This trains an ascending blow. Avoid the instinct to chop down at the ball — that works for irons but kills driver distance.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_driver_vs_3wood_off_tee",
            title: "When to Choose 3-Wood Over Driver",
            summary: "The smartest club off the tee is not always the longest one.",
            body: "Use your 3-wood off the tee when the fairway narrows significantly, when there is out-of-bounds or a hazard in your driver landing zone, or when accuracy matters more than distance (such as a short par 4). A well-struck 3-wood that finds the fairway will always produce a better score than a driver in the rough or trees. Many holes are designed to tempt you into hitting driver when 3-wood to the right distance leaves the perfect approach. Think backward from the green: what distance do you want for your second shot, and which club off the tee gets you there?",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_fairway_finding",
            title: "Prioritize Fairway Finding Percentage",
            summary: "Hitting more fairways is the fastest path to lower scores for most golfers.",
            body: "Statistics show that hitting from the fairway versus the rough costs the average golfer roughly half a stroke per hole. Over 14 driving holes, that could mean a seven-stroke difference per round. To hit more fairways, first identify your most common miss (left or right), then aim to allow for it. Consider teeing off with a club you can control even if it means giving up 20 yards. A 230-yard drive in the fairway is far more valuable than a 260-yard drive in the trees. Track your fairways-hit percentage and set a goal to improve it by 10%.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_controlled_driver_swing",
            title: "Swing at 80% for More Control off the Tee",
            summary: "Throttling back your driver swing often produces both more distance and more accuracy.",
            body: "When you swing at 100%, tension creeps into your hands, arms, and shoulders. This tension shortens your backswing, disrupts your tempo, and often produces a slower clubhead speed than a smooth swing at 80% effort. Try this experiment on the range: hit five drivers at full effort and five at a controlled 80%. Measure or estimate the distances. Most golfers are shocked to find the 80% swings travel nearly as far — sometimes farther — with dramatically tighter dispersion. When the pressure is on and you need a fairway, dial it back and trust the smooth swing.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_tee_box_strategy",
            title: "Think Strategically About Tee Box Position",
            summary: "The side of the tee box you choose can change the difficulty of the hole.",
            body: "Always survey the hole from behind the tee markers before picking a spot. If there is trouble on the left, tee up on the left side and aim away from it — this gives you the entire fairway to work with. If the hole doglegs right, tee up on the left side to open up the angle. Also pay attention to the teeing ground itself: find a flat spot, avoid divots and worn patches, and make sure you have a comfortable stance. Many amateurs step up to the middle of the tee box without thinking. A few seconds of thought can save strokes.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_driver_ball_flight_shape",
            title: "Develop a Reliable Stock Drive Shape",
            summary: "A consistent, predictable shot shape off the tee is more valuable than a straight ball.",
            body: "Trying to hit the ball perfectly straight is extremely difficult because it requires the clubface and path to be precisely zero at impact. Instead, develop a stock shape — either a gentle fade or a gentle draw — and play for it on every tee shot. A predictable 10-yard fade means you can aim 10 yards left and know the ball will end up on target. This eliminates one side of the golf course and makes the game much simpler. Pick whichever shape is more natural for you and refine it. A reliable miss in one direction is far better than a random miss in either direction.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_driver_avoid_first_tee_disaster",
            title: "Survive the First Tee Shot",
            summary: "A solid strategy for the first tee eliminates nerves and starts your round right.",
            body: "The first tee shot of the day is often the most nerve-wracking. Your body is not fully warmed up and the pressure of hitting in front of others can be overwhelming. Combat this with a plan: use a club you are confident with (even if it is a 3-wood or hybrid), pick a wide target, make a smooth three-quarter swing, and focus only on making solid contact. A 200-yard shot in the fairway sets up a great second shot and calms your nerves for the rest of the round. Nobody remembers your first tee shot at the end of the day — but a blow-up start can ruin your entire round.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "slice"]
        ),
        Tip(
            id: "tip_driver_low_spin",
            title: "Reduce Driver Spin for More Distance",
            summary: "Excess backspin on drives robs you of roll and total distance.",
            body: "Most amateurs spin the driver between 3000-4000 RPM when the optimal range is 2000-2500 RPM. High spin causes the ball to balloon and fall out of the sky with no roll. To reduce spin, tee the ball higher, move it slightly forward in your stance, and focus on hitting up on the ball. You can also try a slightly stronger grip, which closes the face a touch and lowers launch spin. If you have access to a launch monitor, pay attention to your spin numbers. Dropping from 3500 to 2500 RPM can add 20 or more yards to your drives with the same swing speed.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance"]
        ),
        Tip(
            id: "tip_wind_tee_shots",
            title: "Adjust Your Tee Shots in the Wind",
            summary: "Playing smart in the wind separates good players from frustrated ones.",
            body: "Into a headwind, tee the ball slightly lower, move it back half an inch in your stance, and make a controlled three-quarter swing. This produces a lower, more penetrating ball flight that is less affected by the wind. Swinging harder into the wind actually makes things worse because it increases spin. With a tailwind, tee it higher and swing normally — the wind will carry the ball. For crosswinds, you have two options: aim into the wind and let it bring the ball back, or shape the ball into the wind to hold the line. The first option is safer for most golfers.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "slice", "hook"]
        ),
        Tip(
            id: "tip_driver_confidence_routine",
            title: "Build Driver Confidence with a Range Routine",
            summary: "Structured driver practice on the range translates to confidence on the course.",
            body: "Instead of mindlessly blasting drivers on the range, simulate on-course situations. Hit five drives to the left side of the range, then five to the right side, then five down the middle. Pick a specific target for each one. After every shot, step away from the ball and go through your full pre-shot routine before the next one. Track how many out of fifteen hit your target area. Over time, your confidence grows because you have evidence that you can put the ball where you want it. This purposeful practice is worth ten times more than hitting a bucket with no plan.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_driver_miss_management",
            title: "Manage Your Driver Misses",
            summary: "Knowing your typical miss pattern lets you plan around it instead of fighting it.",
            body: "Pay attention to your most common driver miss over 10-20 drives on the range. Is it a fade that occasionally becomes a slice? A draw that sometimes hooks? Once you know your pattern, you can manage it on the course. If your miss is a 30-yard slice, never aim down the left side at a target with trouble left — because your one-in-ten straight shot will find that trouble. Aim where both your good shot and your miss are acceptable. Course management is not about eliminating bad shots; it is about making bad shots less costly.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),
        Tip(
            id: "tip_hit_fairway_wedge_range",
            title: "Approach the Fairway Like a Wedge Shot",
            summary: "Thinking of a tee shot as a long wedge promotes smoothness and accuracy.",
            body: "When accuracy is paramount, adopt a fairway-finding mentality. Choke down an inch on the grip for added control. Make a three-quarter backswing with a focus on tempo and balance. Swing at 75-80% effort and focus on making center-face contact. This approach may cost you 10-15 yards but will dramatically tighten your dispersion. Think of it like a wedge shot — you would never swing a wedge at 100%. Apply the same control mindset to your driver when the situation demands accuracy over distance.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "slice"]
        ),
        Tip(
            id: "tip_driver_center_face_contact",
            title: "Find the Center of the Driver Face",
            summary: "Off-center hits cost more distance than swing speed deficits.",
            body: "A driver struck one inch off-center loses approximately 10-15 yards compared to a center-face hit at the same speed. Many amateurs focus obsessively on swing speed when center-face contact would yield bigger gains. To check your strike pattern, apply foot spray or face tape to your driver face and hit 10 balls. If you consistently miss toward the toe, stand slightly closer. If you miss toward the heel, stand slightly farther away. If you miss high or low, adjust your tee height. Optimizing your strike location is free distance that requires no physical change.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_tee_shot_par_three",
            title: "Tee Shot Strategy on Par Threes",
            summary: "Par threes demand precision over power — club selection and aim are everything.",
            body: "On par threes, always tee the ball up, even with an iron — there is no advantage to hitting off the ground when a tee is allowed. Use a tee height that places the ball just above ground level for irons or slightly higher for hybrids. Choose your club based on carry distance to the center of the green, not to the flag. Factor in wind, elevation change, and the trouble around the green. If the pin is tucked behind a bunker, aim at the safe side of the green and take your birdie putt from 25 feet rather than risking a bunker shot for a closer look.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),
        // MARK: - Iron Play
        Tip(
            id: "tip_iron_contact_priority",
            title: "Prioritize Contact Quality with Irons",
            summary: "Pure contact is the foundation of great iron play — it matters more than speed.",
            body: "The difference between a tour pro's 7-iron and an amateur's is not swing speed — it is contact quality. Striking the ball first with a slight descending blow compresses the ball against the face, producing a consistent launch, optimal spin, and reliable distance. Hitting even slightly behind the ball (fat) or catching the ball thin (on the upswing) causes dramatic distance loss and direction problems. Focus every iron practice session on making crisp, ball-first contact. A solidly struck 7-iron will travel farther than a poorly struck 6-iron every single time.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),
        Tip(
            id: "tip_ball_first_contact",
            title: "How to Achieve Ball-First Contact",
            summary: "Striking the ball before the turf is the hallmark of skilled iron play.",
            body: "Ball-first contact requires your swing's low point to be an inch or two in front of the ball. Three things create this: forward shaft lean at impact (hands ahead of the clubhead), weight on your lead side (about 70-80% at impact), and maintaining your posture through the hitting zone. Practice by placing a coin one inch behind the ball and focusing on missing the coin while striking the ball. If you hit the coin, your low point is too far back. Another excellent drill is to place a towel two inches behind the ball and make swings without touching the towel.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact", "topping"]
        ),
        Tip(
            id: "tip_taking_divots",
            title: "Take a Divot in the Right Place",
            summary: "A proper iron divot starts after the ball position, not before it.",
            body: "With mid and short irons, you should take a shallow divot that starts at the ball's position and extends a few inches in front of it. The divot should be the size of a dollar bill, not a steak. Deep divots mean you are too steep. No divot at all with irons usually means you are scooping. To practice, place a tee in the ground and try to clip the top off the tee with your iron. This trains the correct low point. Once you can consistently clip the tee, place a ball in front of it and make the same swing. The ball goes first, then the tee, then the turf.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "topping"]
        ),
        Tip(
            id: "tip_iron_distance_control",
            title: "Dial In Your Iron Distances",
            summary: "Knowing your exact carry distances is one of the biggest competitive advantages in golf.",
            body: "Spend a range session hitting 10 balls with each iron and noting the carry distance (not total distance) for each. Throw out the best two and worst two and average the middle six — that is your true carry distance. Most amateurs overestimate their iron distances by 10-15 yards. Knowing that your real 7-iron carries 145 instead of 160 changes your club selection on every approach shot. Write these numbers down and reference them on the course. If possible, use a launch monitor or GPS watch to get accurate data. Honest distance knowledge eliminates countless short-sided misses.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),
        Tip(
            id: "tip_club_selection",
            title: "Take More Club and Swing Easier",
            summary: "Most amateurs under-club on approach shots, leading to consistent misses short.",
            body: "Statistics show that recreational golfers miss the green short far more often than long. The reason is simple: they select the club that covers the distance only when struck perfectly, then make a less-than-perfect swing. The fix is to take one more club than you think you need and make an easy, controlled swing. A smooth 7-iron is far more consistent than a hard 8-iron. Your contact improves because you are not swinging at maximum effort, and you start hitting more greens. Pin-high misses and over-the-green misses are almost always better than short misses.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),
        Tip(
            id: "tip_long_irons_vs_hybrids",
            title: "Replace Long Irons with Hybrids",
            summary: "Hybrids are more forgiving and easier to launch than long irons for most golfers.",
            body: "Unless you are a low single-digit handicapper with high swing speed, you will almost certainly hit a hybrid more consistently than a 3 or 4 iron. Hybrids have a lower center of gravity and wider sole that makes them easier to get airborne and more forgiving on off-center hits. The distance difference is negligible, but the consistency difference is enormous. A 4-hybrid that you hit solidly eight out of ten times is vastly more useful than a 4-iron you hit well three out of ten times. Leave the ego in the bag and use the club that produces the best average result.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),
        Tip(
            id: "tip_punch_shot",
            title: "Master the Punch Shot for Wind and Trouble",
            summary: "A low punch shot is an essential tool for managing wind and tricky lies.",
            body: "To hit a punch shot, select one or two more clubs than normal, position the ball back of center, press your hands well forward, and make a three-quarter backswing. The follow-through should be abbreviated — finish with your hands at chest height, not over your shoulder. This produces a low, running shot with minimal spin that holds its line in the wind. The punch shot is also invaluable when you need to escape from under tree branches. Practice it on the range with a 6 or 7 iron first, then apply the same technique to other clubs.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),
        Tip(
            id: "tip_trajectory_control",
            title: "Control Your Trajectory with Ball Position and Finish",
            summary: "Moving the ball in your stance and adjusting your finish height controls trajectory.",
            body: "To hit the ball lower, move it back in your stance by one ball width, keep your hands ahead at impact, and finish with a shorter, lower follow-through. To hit it higher, move the ball forward by one ball width, allow a full release through impact, and finish high over your lead shoulder. These adjustments change the effective loft of the club without requiring you to change your swing. Practice both on the range: hit five low shots and five high shots with the same club. Being able to control trajectory adds an entire dimension to your iron play.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact"]
        ),
        Tip(
            id: "tip_iron_alignment_precision",
            title: "Align Your Irons with Precision on Approach Shots",
            summary: "Sloppy alignment on iron shots compounds as the target gets smaller.",
            body: "On tee shots, alignment errors of a few degrees may still find the fairway. On approach shots to a green that is 30 yards wide, a two-degree alignment error means missing the green entirely from 150 yards. Pay extra attention to your alignment when hitting irons into greens. Use the intermediate target technique: find a spot a few feet ahead of the ball on your target line and aim your clubface there. Align your body parallel to that line. This added precision on approach shots is the difference between hitting 8 greens per round and hitting 12.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),
        Tip(
            id: "tip_downhill_uphill_lies",
            title: "Adjust Your Iron Setup for Slopes",
            summary: "Sloping lies require setup changes to maintain solid contact.",
            body: "On an uphill lie, match your shoulders to the slope by putting more weight on your trail foot, play the ball slightly forward, and expect the ball to fly higher and shorter (take more club). On a downhill lie, match your shoulders to the slope the other direction, play the ball slightly back, and expect a lower, longer flight (take less club). On sidehill lies where the ball is above your feet, aim right (the ball will draw) and choke down on the grip. When the ball is below your feet, aim left (the ball will fade) and add a touch of knee flex. Always make a smooth, controlled swing on uneven lies.",
            difficulty: .advanced,
            linkedIssueIDs: ["fat_shots", "topping", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_half_swing_iron_drill",
            title: "Groove Contact with Half-Swing Iron Drills",
            summary: "Half swings teach you to find the center of the clubface consistently.",
            body: "Take a 7-iron and make half swings — hands going from hip height to hip height — focusing entirely on making crisp, ball-first contact. Hit 20-30 balls this way to start each practice session. Because the swing is shorter and simpler, you can feel exactly where the club strikes the ground and the ball. Gradually lengthen the swing to three-quarters, maintaining the same contact quality. If your contact deteriorates, shorten the swing again. This drill is used by tour pros and teaching professionals worldwide because it isolates the most important skill in iron play: clean contact.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),
        Tip(
            id: "tip_spin_control_irons",
            title: "Understand Spin and Why Your Irons Balloon",
            summary: "Controlling iron spin keeps your distances consistent and your trajectory penetrating.",
            body: "Iron shots that climb steeply and fall short are usually carrying too much backspin. This often happens from a steep angle of attack, a worn or wet groove, or a grassy lie that produces a flyer. To control spin, focus on a slightly shallower angle of attack while still hitting the ball first. Ensure your grooves are clean — dirt-filled grooves cannot grip the ball properly. In wet conditions, expect reduced spin and more run-out. Understanding spin helps you predict what the ball will do after it lands, which is essential for precision approach play.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),
        Tip(
            id: "tip_gap_between_clubs",
            title: "Know Your Distance Gaps Between Clubs",
            summary: "Consistent yardage gaps between clubs simplify club selection on the course.",
            body: "Ideally, each club in your bag should have a 10-15 yard gap from the next. If you have a 20-yard gap between two clubs, you have a hole in your set. If two clubs go the same distance, one of them is redundant. Map out your distances for every club and look for gaps or overlaps. You might discover that your 5-iron and 6-iron go the same distance (swap the 5-iron for a hybrid) or that there is a 25-yard gap between your pitching wedge and sand wedge (add a gap wedge). A well-spaced set gives you a club for every distance.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact"]
        ),
        Tip(
            id: "tip_iron_from_rough",
            title: "Adjust Your Iron Play from the Rough",
            summary: "The rough changes how the ball comes off the face — plan for it.",
            body: "From light rough, the ball will fly slightly farther than normal with less spin (a 'flyer'). From thick rough, the grass grabs the hosel and closes the face, producing a lower shot that runs more. In deep rough, take a more lofted club, play the ball back in your stance, grip the club firmly, and make a steeper swing to avoid the grass grabbing the clubhead before impact. Never try to hit a long iron from deep rough — the clubhead does not have enough loft or mass to get through the grass. A wedge back to the fairway is always smarter than a heroic attempt that stays in the rough.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),
        Tip(
            id: "tip_iron_pre_round_warmup",
            title: "Warm Up Your Irons Before a Round",
            summary: "A focused 15-minute iron warm-up sets the tone for crisp contact all day.",
            body: "Start with your most lofted wedge and hit five easy half-swing shots, focusing on contact. Move to your pitching wedge for five shots, then 8-iron, then 6-iron, each with five shots. Finish with five shots from your longest iron or hybrid. Do not try to fix anything during the warm-up — just find your tempo and feel for the day. If you are hitting it well, enjoy it. If contact is a bit off, accept it and plan your round accordingly. A warm-up is a diagnostic session, not a practice session. Knowing your tendencies before the first tee gives you a strategic edge.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),
        Tip(
            id: "tip_scoring_irons",
            title: "Treat Scoring Irons as Precision Instruments",
            summary: "Short irons and wedges should prioritize accuracy and distance control over maximum distance.",
            body: "From 150 yards and in, your primary goal shifts from distance to precision. With a 9-iron, pitching wedge, or gap wedge, you should be attacking a specific number — not swinging as hard as you can. Grip down half an inch for added control. Make a smooth, rhythmic swing and focus on consistent tempo. Know your exact carry distance with each wedge for full, three-quarter, and half swings. The scoring clubs are where rounds are made or broken. Developing a reliable, distance-controlled wedge game will drop more strokes from your handicap than any other improvement.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),
        Tip(
            id: "tip_iron_shaft_lean",
            title: "Maintain Forward Shaft Lean at Impact",
            summary: "Forward shaft lean compresses the ball and is the key to consistent iron strikes.",
            body: "At impact with an iron, your hands should be ahead of the clubhead, leaning the shaft toward the target. This delofts the club slightly, compresses the ball, and ensures you hit the ball before the turf. If your hands are behind the clubhead at impact (a flip or scoop), you add loft, lose compression, and strike the ground before the ball. A powerful drill is to place an impact bag or firm cushion a few inches in front of the ball and hit it with your hands leading. You should feel the shaft and your lead arm forming a straight line at impact, not a V-shape.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact", "lack_of_distance"]
        ),

        // MARK: - Short Game & Pitching
        Tip(id: "tip_basic_pitch_setup", title: "The Foundation of a Good Pitch Shot", summary: "A proper setup is the key to consistent pitch shots from 30-70 yards.", body: "Position the ball slightly back of center in your stance with your weight favoring your front foot about 60/40. Open your stance slightly by pulling your lead foot back an inch or two, which pre-clears your hips for a smooth rotation through impact. Keep your hands slightly ahead of the ball at address and maintain that relationship throughout the swing. This setup promotes a descending strike that produces clean contact and reliable distance control.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_pitch_distance_control", title: "Clock System for Pitch Distance Control", summary: "Use the clock system to dial in your pitching distances with three backswing lengths.", body: "Imagine your lead arm as the hand of a clock and practice three key positions: 9 o'clock for short pitches, 10:30 for medium pitches, and full for longer pitches. With your pitching wedge, hit ten balls at each position and record the average carry distance for each. This gives you three reliable yardages per wedge, and when you multiply across your wedge set, you can cover virtually every distance inside 120 yards. Commit these numbers to memory so you never have to manufacture an awkward in-between swing on the course.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_flop_shot_technique", title: "How to Hit a Reliable Flop Shot", summary: "The flop shot requires an open face and committed acceleration through the ball.", body: "Open your clubface significantly before taking your grip, then align your body well left of the target so the open face points at your landing spot. Play the ball forward in your stance, just inside your lead heel, and make a full, confident swing along your body line. The key mistake most amateurs make is decelerating through impact out of fear of hitting it too far, which causes fat and thin contacts. Trust the loft you have created and accelerate through the ball, letting the open face slide under it to produce a high, soft-landing shot.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_spin_control_pitching", title: "Controlling Spin on Your Pitch Shots", summary: "Spin is a product of clean contact, loft, and friction between the clubface and ball.", body: "To maximize spin, ensure your grooves are clean and your ball is a premium urethane-cover model, as surlyn balls generate significantly less spin. Strike the ball with a slightly descending blow, making ball-first contact without excessive divot depth. Wet grass, fluffy lies, and grass caught between the face and ball all reduce spin dramatically, so adjust your expectations based on the conditions. When you need the ball to check up, focus on a smooth, controlled swing rather than hitting harder, since clean strike matters far more than swing speed for short-game spin.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_lie_assessment_short_game", title: "Reading Your Lie Before Every Short Shot", summary: "The lie of the ball dictates which shots are possible and which are risky.", body: "Before choosing a club or shot type, crouch down behind the ball and assess how much grass is sitting underneath and around it. A clean lie on tight turf allows you to play any shot including low spinners and flop shots, while a ball sitting down in thick rough limits you to steeper, more lofted approaches. If the ball is sitting up on top of fluffy grass, be aware that the club can easily slide under the ball and produce a thin contact or a shot that comes up short. Always let the lie choose the shot for you rather than forcing a technique that the situation does not support.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "fat_shots", "topping"]),
        Tip(id: "tip_uphill_chip_technique", title: "Chipping From an Uphill Lie", summary: "Set your shoulders parallel to the slope to make clean contact on uphill chip shots.", body: "When the ball is on an uphill slope, tilt your spine so your shoulders match the angle of the ground, which effectively puts more weight on your trail foot. Use a less-lofted club than normal because the slope adds loft to whatever club you choose, so a pitching wedge on a steep uphill may fly like a lob wedge. Swing along the slope rather than trying to drive the club into the hill, and expect the ball to come out higher and land softer than usual. Factor in that the ball will release less on the green due to the added height and steeper descent angle.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_downhill_chip_technique", title: "Chipping From a Downhill Lie", summary: "Downhill chips require extra loft and careful balance to avoid skulling the ball.", body: "Tilt your shoulders to match the downhill slope so your spine is roughly perpendicular to the ground, which shifts weight onto your lead foot. Select a more lofted club than normal because the slope delofts your clubface, and play the ball back in your stance to promote a descending strike that follows the terrain. Keep your hands ahead of the clubhead through impact and chase the club down the slope in your follow-through rather than trying to scoop the ball into the air. Expect the ball to come out lower and run more than a flat-lie chip, so plan your landing spot accordingly.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "topping", "fat_shots"]),
        Tip(id: "tip_bump_and_run_basics", title: "The Bump and Run: Your Safest Greenside Option", summary: "A low bump-and-run shot minimizes risk and is the highest-percentage play around the green.", body: "Choose a 7, 8, or 9 iron and set up as if you are hitting a long putt, with a narrow stance, the ball back of center, and your weight slightly forward. Make a putting-style stroke with minimal wrist hinge, letting the natural loft of the iron get the ball just over the fringe before it rolls the rest of the way to the hole. This technique dramatically reduces the chance of fat and thin contacts because the swing is short and controlled. Anytime you have a clear path to the green with no obstacles to carry, the bump and run should be your default choice.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "fat_shots", "topping"]),
        Tip(id: "tip_bump_run_club_selection", title: "Choosing the Right Club for Bump and Run", summary: "Different clubs produce different roll-to-carry ratios for bump and run shots.", body: "As a general guide, a pitching wedge produces roughly equal carry and roll, a 9 iron rolls about twice as far as it carries, and an 8 iron rolls about three times its carry distance. Walk onto the green and identify your ideal landing spot, then work backward to determine which ratio best fits the shot. If the pin is close to your side of the green, use a more-lofted club for less roll; if the pin is deep, grab a less-lofted iron and let it run out. Practicing with three or four clubs on the same shot will teach you these ratios faster than any tip ever could.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_pitch_soft_landing", title: "How to Land Pitch Shots Softly", summary: "Soft-landing pitches require height, spin, or both to stop the ball quickly.", body: "Open the clubface slightly at address and make a swing that is longer than you might expect, because the open face reduces effective distance. Focus on maintaining the loft through impact by keeping the back of your lead wrist flat rather than flipping the club closed. Allow your body to rotate fully through the shot so the clubhead does not pass your hands before impact. The combination of open face, full rotation, and ball-first contact produces the height and spin needed to land the ball softly near your target.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_greenside_strategy_miss", title: "Always Plan Your Miss Around the Green", summary: "Smart greenside strategy means picking the shot that leaves the easiest next putt even on a poor execution.", body: "Before hitting any greenside shot, ask yourself where the ball will end up if you hit it slightly fat or slightly thin. If a thin shot would send the ball flying across the green into a hazard, that shot carries too much risk. Choose the technique and landing area that keeps even a mediocre result on the putting surface or in a straightforward recovery position. Tour players do not always aim at the pin from greenside; they aim where the worst outcome is still a manageable two-putt.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "three_putting"]),
        Tip(id: "tip_pitch_tempo_consistency", title: "Maintain Consistent Tempo on Pitch Shots", summary: "A smooth, rhythmic tempo is the single biggest factor in pitch shot consistency.", body: "Your pitching tempo should feel the same whether you are hitting a 30-yard or 70-yard pitch; the only thing that changes is the length of your backswing. Practice counting one on the backswing and two at impact to build a repeatable rhythm that you can trust under pressure. Many amateurs rush the transition from backswing to downswing on short shots because they feel they need to add speed, but this destroys the smooth acceleration that produces clean contact.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_low_spinner_pitch", title: "The Low Spinning Pitch Shot", summary: "A low pitch with spin is effective in wind and when you want maximum control.", body: "Play the ball slightly back of center with your hands well ahead at address, which delofts the club and promotes a steeper angle of attack. Use your gap wedge or pitching wedge rather than a lob wedge so the ball launches lower while still generating backspin from the descending strike. Make a compact, three-quarter swing with firm wrists through impact, ensuring the clubface does not flip closed or open. This shot flies under the wind, lands with a one or two hop, then checks up, making it a valuable weapon on firm, fast greens.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_rough_pitch_technique", title: "Pitching From Thick Rough", summary: "Thick rough grabs the hosel and closes the face, so adjustments are necessary.", body: "Open the clubface before gripping the club to compensate for the rough twisting it closed at impact. Use your most lofted wedge and play the ball in the middle of your stance with a steeper backswing created by hinging your wrists earlier. Commit to accelerating through the thick grass without flinching, because deceleration in heavy rough almost always results in the ball barely moving. Accept that distance control is inherently less precise from this lie and aim for the fat part of the green rather than attacking a tight pin.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "fat_shots", "inconsistent_contact"]),
        Tip(id: "tip_pitch_trajectory_control", title: "Controlling Trajectory With Ball Position", summary: "Moving the ball forward or back in your stance is the simplest way to change pitch trajectory.", body: "Ball position is your primary trajectory dial: moving it back in your stance produces a lower, running shot, while moving it forward creates a higher, softer flight. For a standard pitch, position the ball in the center of your stance; for a low runner, move it one ball-width back; for a higher pitch, move it one ball-width forward. Keep the rest of your setup and swing the same so the only variable is ball position, which makes the adjustment simple and repeatable.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_pitch_wrist_hinge", title: "Proper Wrist Hinge for Pitch Shots", summary: "A controlled wrist hinge creates the angle of attack needed for crisp pitch shots.", body: "Allow your wrists to hinge naturally during the backswing so the club sets at roughly a 90-degree angle to your lead forearm by the time your hands reach hip height. This wrist set creates the downward angle of attack necessary for ball-first contact. Avoid excessive hinge, which makes the swing too steep and leads to fat shots, and avoid zero hinge, which makes the swing too shallow and causes thin contacts.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "fat_shots", "topping"]),
        Tip(id: "tip_lob_wedge_pitching", title: "When to Use Your Lob Wedge for Pitching", summary: "The lob wedge is a specialty tool best reserved for specific situations around the green.", body: "Reserve your 58 or 60 degree lob wedge for situations where you must carry an obstacle and stop the ball quickly on a small landing area with little green to work with. On a tight lie, the lob wedge is the hardest club to hit cleanly because its bounce angle does not interact well with firm turf. From fluffy or average lies, the lob wedge performs much better because the grass provides a cushion for the bounce to work against. If you can achieve the desired result with a sand wedge or gap wedge, those clubs will always be the more consistent choice.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "fat_shots", "topping"]),
        Tip(id: "tip_pitch_practice_ladder", title: "The Ladder Drill for Pitch Distance Control", summary: "The ladder drill trains your feel for distance by forcing you to land each ball past the previous one.", body: "Set up at the practice area and hit your first pitch to 20 yards, then try to land each subsequent ball exactly 5 yards beyond the previous one, building a ladder out to your maximum pitching distance. This drill teaches you to make precise adjustments in backswing length and tempo rather than relying on one stock distance. Once you can consistently build the ladder going out, reverse it and work back toward you in 5-yard increments.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_sidehill_lie_chipping", title: "Chipping From Sidehill Lies", summary: "Sidehill lies around the green change the effective aim and require setup adjustments.", body: "When the ball is above your feet, it will tend to go left for a right-handed player, so aim right of your target and choke down on the club. When the ball is below your feet, expect the ball to drift right, so aim left and flex your knees deeper to reach down to the ball. In both cases, make a compact, controlled swing because sidehill lies punish any excess movement or weight shift.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_greenside_visualization", title: "Visualize the Landing Spot, Not the Hole", summary: "Great chippers and pitchers focus their eyes and mind on the landing spot rather than the flag.", body: "Walk onto the green and pick a specific spot where you want the ball to first bounce, taking into account the slope and speed of the green. Stand behind the ball and visualize the entire shot in your mind, seeing the trajectory, the landing, and the ball rolling to the hole. During the actual stroke, let your eyes focus on the ball but keep the image of that landing spot vivid in your mind.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "three_putting"]),
        // MARK: - Bunker Play
        Tip(id: "tip_greenside_bunker_basics", title: "The Fundamentals of a Greenside Bunker Shot", summary: "In a greenside bunker, you hit the sand, not the ball, and the sand carries the ball out.", body: "Open the clubface of your sand wedge before taking your grip, then aim your body and swing path left of the target. Dig your feet into the sand for stability and focus on entering the sand about two inches behind the ball. Swing along your body line with full commitment and acceleration, and the cushion of sand between the clubface and ball will launch it out on a soft, high trajectory. The biggest mistake amateurs make is trying to help the ball up by scooping, when instead they should trust the loft and bounce of the club.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_bunker_bounce_explained", title: "Understanding Bounce in the Bunker", summary: "The bounce angle on your wedge is designed to prevent the club from digging too deep in sand.", body: "Bounce is the angle between the leading edge and the lowest point of the sole, and it acts like a rudder that skids through the sand rather than digging into it. Wedges with higher bounce, typically 12 to 14 degrees, are more forgiving in soft, fluffy sand. Lower bounce wedges, around 8 to 10 degrees, perform better in firm, wet, or compacted sand. Understanding your wedge's bounce and matching it to the sand conditions is a fundamental skill that most amateurs overlook.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_fairway_bunker_strategy", title: "Fairway Bunker Strategy and Execution", summary: "Fairway bunker shots prioritize clean contact and clearing the lip over maximum distance.", body: "Select one or two more clubs than your normal distance to compensate for the controlled swing, and always verify that your chosen club has enough loft to clear the bunker lip. Grip down half an inch for control, position the ball slightly back of center, and focus on picking the ball cleanly off the sand with minimal sand contact. Keep your lower body quieter than a normal full swing to prevent your feet from slipping. Prioritize making solid contact and clearing the lip.", difficulty: .intermediate, linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]),
        Tip(id: "tip_bunker_distance_control", title: "Controlling Distance From Greenside Bunkers", summary: "Vary your bunker shot distance by adjusting the length of your follow-through, not your backswing.", body: "For a short bunker shot to a close pin, make your normal backswing but shorten your follow-through so your hands finish around waist height. For a medium-length bunker shot, swing through to chest height, and for a long bunker shot, make a full follow-through to a high finish. Keeping the backswing consistent while varying the follow-through length is easier to repeat under pressure.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_fried_egg_bunker", title: "Escaping the Fried Egg Lie in a Bunker", summary: "A fried egg lie requires a closed face and steep angle of attack to dig the ball out.", body: "When the ball is half-buried with a ring of sand around it like a fried egg, square or even slightly close the clubface instead of opening it. Position the ball in the center of your stance and make a steep, V-shaped swing by hinging your wrists sharply on the backswing and driving the club down into the sand directly behind the ball. Expect the ball to come out with very little spin and run significantly more than a standard bunker shot.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_plugged_lie_bunker", title: "How to Play a Plugged Lie in a Bunker", summary: "A fully plugged ball demands an aggressive, digging swing to extract it from deep sand.", body: "Close the clubface at address so the leading edge can knife down into the sand, and play the ball back of center in your stance. Make a steep, aggressive downswing and drive the club into the sand about an inch behind the ball with maximum force, because you are literally digging the ball out of its hole. Do not expect much follow-through; the sand will stop the club naturally. Plan for significant roll by picking a landing spot well short of the hole.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_bunker_soft_sand", title: "Playing From Soft, Fluffy Sand", summary: "Soft sand requires more speed and a wider entry to prevent the club from burying too deep.", body: "In soft, powdery sand, open the clubface more than usual to maximize the bounce and prevent the club from digging excessively. Take a slightly wider entry point, hitting about two and a half to three inches behind the ball, and increase your swing speed to compensate for the extra sand you are moving. Use your highest-bounce wedge in these conditions because it will skim through the fluffy sand rather than submarining beneath the ball.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "fat_shots"]),
        Tip(id: "tip_bunker_wet_sand", title: "Playing From Wet, Compacted Sand", summary: "Wet sand is firm and requires less bounce and a shallower entry than normal bunker shots.", body: "When the sand is wet and compacted, use a wedge with less bounce or square the clubface slightly to reduce the effective bounce angle. Enter the sand closer to the ball, about one to one and a half inches behind it, because the firm surface will not allow the club to slide as deeply. Reduce your swing speed compared to a normal bunker shot since the ball will come out faster and hotter off the firm surface.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_uphill_bunker_shot", title: "Uphill Bunker Shots: Adjusting for the Slope", summary: "An uphill bunker shot adds loft and height, requiring club and aim adjustments.", body: "Set your shoulders parallel to the uphill slope and position your weight primarily on your lower foot to maintain balance. Select a less-lofted wedge like a gap wedge instead of your sand wedge because the slope will add significant loft to the shot. Swing along the slope rather than into it, allowing the club to travel up the hill through impact.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_downhill_bunker_shot", title: "Downhill Bunker Shots: The Toughest Sand Shot", summary: "Downhill bunker shots reduce effective loft, making it hard to get the ball up and stopped.", body: "Align your shoulders with the downhill slope, which places most of your weight on your lead foot, and open the clubface significantly to counteract the loft-reducing effect of the slope. Play the ball slightly back of center and commit to chasing the club down the slope through impact rather than trying to scoop the ball up. This is one of the most difficult shots in golf, so accept that the ball will come out lower and run more than you would like.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "fat_shots", "topping"]),
        Tip(id: "tip_bunker_line_drill", title: "The Line in the Sand Drill for Bunker Practice", summary: "Draw a line in the sand and practice entering the club consistently on that line.", body: "Draw a straight line in the sand perpendicular to your target and practice hitting bunker shots without a ball, focusing on having the club enter the sand right on the line. Once you can consistently splash sand from the line, place a ball two inches in front of the line and repeat the same swing without changing anything. This drill teaches you to trust a consistent entry point rather than steering the club into the sand differently every time.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_bunker_commitment", title: "Commit to Every Bunker Shot", summary: "Deceleration is the number one cause of leaving the ball in the bunker.", body: "The most common bunker mistake amateurs make is slowing the club down through impact because they are afraid of hitting the ball too far. A decelerating club digs into the sand and either leaves the ball in the bunker or produces a weak, unpredictable result. Commit to swinging through to a full finish on every greenside bunker shot, even when the target is close.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "first_tee_nerves"]),
        Tip(id: "tip_bunker_open_stance", title: "Why You Open Your Stance in the Bunker", summary: "An open stance pre-sets the out-to-in swing path needed for a standard bunker explosion.", body: "Opening your stance means pulling your lead foot back from the target line so your body aims left of the flag for a right-handed golfer. This alignment naturally creates an out-to-in swing path that cuts across the ball, which when combined with an open clubface produces the high, spinning flight you need. Think of it as your body controlling the direction of your swing while the clubface controls the direction of the ball.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping"]),
        Tip(id: "tip_bunker_lip_assessment", title: "Assessing the Bunker Lip Before You Swing", summary: "Always check the height and distance of the lip to ensure your shot can clear it.", body: "Before planning any bunker shot, walk to the edge and look at the lip from the side to judge its actual height, which is often taller than it appears from inside the bunker. Estimate the launch angle your planned shot will produce and verify that it clears the lip with room to spare. If there is any doubt, use a more lofted club or aim toward a section of the bunker wall that is lower.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_bunker_explosion_depth", title: "Controlling the Depth of Your Sand Divot", summary: "The depth of your sand divot directly determines how far the ball travels from a bunker.", body: "A shallow divot that takes a thin layer of sand produces a longer, lower shot with more spin, while a deeper divot that excavates more sand produces a shorter, higher shot with less spin. Think of the sand divot as being roughly the size and shape of a dollar bill for a standard bunker shot. Practice controlling this depth by varying how much you flex your knees during setup.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_long_bunker_shot", title: "The Long Greenside Bunker Shot (20-30 Yards)", summary: "The 20-30 yard bunker shot is one of the hardest in golf and requires a specific approach.", body: "For long bunker shots, square the clubface instead of opening it and use your gap wedge or pitching wedge rather than your sand wedge. Enter the sand slightly closer to the ball, about one inch behind it, and make a longer, more sweeping swing rather than the steep chop used for short bunker shots. The goal is to take less sand so more energy transfers to the ball.", difficulty: .advanced, linkedIssueIDs: ["poor_chipping", "lack_of_distance"]),
        Tip(id: "tip_bunker_mental_approach", title: "Building Confidence in Bunker Play", summary: "A positive mental approach in the bunker comes from preparation and understanding the technique.", body: "Most amateurs dread bunkers because they have never practiced from them properly, which creates a cycle of fear and poor execution. Dedicate fifteen minutes per practice session to bunker play, starting with the basic explosion shot until you can get out every time. Once you realize that the greenside bunker shot is actually one of the most forgiving in golf because you do not even have to contact the ball, your anxiety will decrease significantly.", difficulty: .beginner, linkedIssueIDs: ["first_tee_nerves", "poor_chipping"]),
        Tip(id: "tip_bunker_different_clubs", title: "Using Different Clubs From Bunkers", summary: "Your sand wedge is not the only option in a bunker; different clubs create different results.", body: "While the sand wedge is your go-to for standard greenside bunkers, experiment with your lob wedge for short-sided shots where you need maximum height and spin, and your gap wedge for longer bunker shots. From fairway bunkers, use any iron in your bag based on the distance required, provided it has enough loft to clear the lip. Expanding your bunker club selection gives you far more options and creative solutions.", difficulty: .intermediate, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        Tip(id: "tip_bunker_practice_no_ball", title: "Practice Bunker Swings Without a Ball", summary: "Making practice swings in the sand without a ball builds feel for the correct entry and depth.", body: "Spend the first five minutes of every bunker practice session making swings without a ball, focusing on entering the sand at a consistent point and taking a uniform divot each time. Listen to the sound the club makes as it splashes through the sand; a good bunker shot produces a heavy thump, not a sharp crack. This no-ball practice removes the anxiety of the outcome and lets you focus purely on developing the correct motion.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "first_tee_nerves"]),
        Tip(id: "tip_bunker_foot_work", title: "Proper Footwork and Stability in Sand", summary: "Digging your feet into the sand provides stability but also changes your effective swing height.", body: "Wiggle your feet into the sand about an inch to create a stable platform and prevent slipping during the swing. Remember that burying your feet effectively lowers your body relative to the ball, which moves the low point of your swing arc downward and helps you enter the sand behind the ball. Keep your lower body relatively quiet during the bunker swing, as excessive lateral movement on the unstable sand surface leads to inconsistent contact.", difficulty: .beginner, linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]),
        // MARK: - Advanced Putting
        Tip(id: "tip_speed_control_putting", title: "Speed Control Is More Important Than Line", summary: "Tour professionals agree that speed control accounts for roughly 80% of putting success.", body: "On any putt outside three feet, there is a range of lines that will work as long as the speed is correct, but only a narrow speed window makes any particular line work. Practice your speed control by putting to the fringe of the practice green from various distances without aiming at a hole. This drill isolates speed from line and trains your subconscious to produce the right amount of force for any distance.", difficulty: .beginner, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_putting_stroke_mechanics", title: "Building a Repeatable Putting Stroke", summary: "A mechanically sound putting stroke uses the shoulders as the engine with quiet hands and wrists.", body: "Set up with your eyes directly over the ball, your forearms parallel to the target line, and the putter face square to your intended start line. Rock your shoulders like a pendulum to move the putter back and through, keeping your wrists firm and passive throughout the stroke. The putter should accelerate slightly through impact rather than decelerating.", difficulty: .beginner, linkedIssueIDs: ["three_putting", "inconsistent_contact"]),
        Tip(id: "tip_green_reading_advanced", title: "Advanced Green Reading: Seeing the Full Picture", summary: "Read the overall terrain and drainage patterns before focusing on the specific slope near your ball.", body: "Begin your green reading process as you walk up to the green by observing the overall terrain: where are the mountains, where is the nearest body of water, and which direction does the course drain. These macro features influence the general slope of every green on the course. Next, walk around the hole and view your putt from at least two angles, behind the ball and behind the hole, to confirm the break direction.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_uphill_putt_strategy", title: "Attacking Uphill Putts With Confidence", summary: "Uphill putts are the easiest putts in golf because the back of the hole is effectively higher.", body: "On an uphill putt, the effective size of the hole is larger because the ball approaches at an uphill angle. Be aggressive with your speed on uphill putts, aiming to roll the ball 12 to 18 inches past the hole if it misses. Uphill putts also break less than they appear because the faster speed needed to reach the hole reduces the time gravity has to pull the ball sideways.", difficulty: .beginner, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_downhill_putt_control", title: "Taming Treacherous Downhill Putts", summary: "Downhill putts demand a shorter backswing and exquisite touch to prevent the ball from racing past.", body: "On a steep downhill putt, shorten your backswing and let gravity do the work of getting the ball to the hole rather than adding force through the stroke. Pick a spot short of the hole as your speed target, imagining the hole is actually a few feet closer than it really is. Downhill putts break more than they appear because the ball is traveling slowly and gravity has more time to influence its path.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_breaking_putt_start_line", title: "Committing to the Start Line on Breaking Putts", summary: "The most common mistake on breaking putts is not starting the ball far enough above the hole.", body: "Once you have determined the break, pick a specific spot on your start line and commit to rolling the ball directly over that spot. Most amateurs under-read break and then compound the error by subconsciously steering the putter face toward the hole at impact. Trust your read and stroke the putt straight at your start point, letting gravity curve the ball toward the hole.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_aimpoint_basics", title: "Introduction to AimPoint Green Reading", summary: "AimPoint is a system that uses your feet to feel slope and your fingers to determine the aim point.", body: "Stand on the midpoint of your putt line, straddle the line with your feet, and feel which foot has more pressure on it, which tells you the direction of the slope. Rate the severity of the slope on a scale of one to five using your feet. Then stand behind your ball, hold up the corresponding number of fingers at arm's length centered on the hole, and the edge of your finger grouping becomes your aim point.", difficulty: .advanced, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_lag_putting_drill", title: "The 30-40-50 Foot Lag Putting Drill", summary: "Lag putting from long range is the fastest way to eliminate three-putts from your game.", body: "Place three tees at 30, 40, and 50 feet from the hole and hit three putts from each distance, scoring one point for each ball that finishes within a three-foot circle of the hole. Your goal is to score seven out of nine points consistently. This drill trains the large muscles of your shoulders to produce the right amount of force for long putts. Spend 70% of your putting practice time on lag putts outside 20 feet.", difficulty: .beginner, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_adv_putting_gate_drill", title: "The Gate Drill for Putter Face Control", summary: "Placing two tees just wider than your putter head trains a square face at impact.", body: "Set two tees in the ground about half an inch wider than your putter head, roughly three inches in front of the ball on your target line. Stroke putts through the gate, and if the ball rolls straight through without touching either tee, your face is square at impact. Start with three-foot putts through the gate and gradually extend the distance as your consistency improves.", difficulty: .beginner, linkedIssueIDs: ["three_putting", "inconsistent_contact"]),
        Tip(id: "tip_putting_eye_position", title: "Correct Eye Position Over the Ball", summary: "Your eye position relative to the ball influences your perception of the target line.", body: "Position your eyes directly over the ball or very slightly inside the target line at address. If your eyes are outside the line, you will tend to see a start line that is too far left. Check your eye position by setting up to a putt, then dropping a ball from the bridge of your nose; it should land on or just inside the ball you are putting.", difficulty: .beginner, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_grain_reading_putting", title: "Reading Grain on Bermuda Greens", summary: "Bermuda grass grain significantly affects ball speed and break direction.", body: "Bermuda grass grows in a specific direction, and putting with the grain makes the putt faster while putting against the grain makes it slower. Look at the hole itself: the side where the grass is growing over the edge appears brown and ragged, and the grain runs from the clean side toward the ragged side. Putts rolling with the grain will be faster and break more, while putts against the grain will be slower and break less.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_putting_routine_consistency", title: "Develop a Consistent Pre-Putt Routine", summary: "A consistent routine eliminates variables and builds confidence over every putt.", body: "Design a routine that includes reading the green from behind the ball, taking one or two practice strokes while looking at the hole to calibrate distance, setting the putter face square to your start line, then pulling the trigger without delay. The entire routine should take the same amount of time on every putt. Avoid standing over the ball too long after completing your practice strokes, as static time breeds doubt.", difficulty: .beginner, linkedIssueIDs: ["three_putting", "first_tee_nerves"]),
        Tip(id: "tip_double_break_putts", title: "Reading Double-Breaking Putts", summary: "Putts that break in two directions require you to identify the transition point and treat them as two separate putts.", body: "Walk the entire length of the putt and identify the point where the slope changes direction, which becomes your intermediate target. Read the first section of the putt from the ball to the transition point and determine what speed and line will deliver the ball to that spot. Then read the second section from the transition point to the hole. These putts are among the hardest in golf.", difficulty: .advanced, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_putting_practice_games", title: "Competitive Putting Games for Practice", summary: "Turning putting practice into a game builds pressure tolerance and engagement.", body: "Play the 21 game: start at three feet and make three in a row, then move to six feet and make two, then nine feet and make one, totaling 21 points for a perfect score, and start over from scratch if you miss. These games simulate pressure because there is something at stake, and they train the clutch putting muscles that mindless practice does not engage.", difficulty: .beginner, linkedIssueIDs: ["three_putting", "first_tee_nerves"]),
        Tip(id: "tip_yips_recovery", title: "Recovering From the Putting Yips", summary: "The yips are an involuntary muscle spasm during the stroke, often triggered by anxiety over short putts.", body: "If you are experiencing the yips, start by changing something physical: try a different grip such as the claw, left-hand-low, or arm-lock method to break the neurological pattern that triggers the spasm. Practice making short putts with your eyes closed, which removes the visual trigger. Consider using a heavier putter, as the extra weight makes it harder for small involuntary movements to disrupt the stroke.", difficulty: .advanced, linkedIssueIDs: ["three_putting", "first_tee_nerves"]),
        Tip(id: "tip_plumb_bob_reading", title: "Plumb Bobbing to Confirm Break Direction", summary: "Plumb bobbing is a quick visual check to confirm which way a putt breaks.", body: "Stand directly behind your ball on an extension of the ball-to-hole line and hold your putter at arm's length by the grip with two fingers so it hangs freely like a plumb line. Close your dominant eye and align the hanging shaft with the center of the ball. If the shaft appears to hang to the left of the hole, the putt breaks left to right, and vice versa. Plumb bobbing is best used as a confirmation of what you already see.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_pace_putting_feel", title: "Developing Touch by Putting to Distances, Not Holes", summary: "Putting to distance targets instead of holes removes outcome anxiety and builds pure feel.", body: "Lay three clubs on the practice green at 15, 25, and 35 feet from your starting position and putt sets of five balls to each distance, trying to stop the ball as close to the club as possible without hitting it. Because there is no hole to make or miss, your brain focuses entirely on pace and feel. This drill builds the subconscious distance calibration that elite putters rely on.", difficulty: .beginner, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_putt_read_lowest_point", title: "Always Read the Putt From the Low Side", summary: "The most accurate perspective for reading break comes from the lowest point of the putt.", body: "Walk to the low side of your putt, the side the ball will break toward, and crouch down to read the slope from this angle. From the low side, you can see the true height the ball needs to climb and then fall. Reading from the high side or from behind the ball only can be deceiving because the slope can appear flatter than it actually is.", difficulty: .intermediate, linkedIssueIDs: ["three_putting"]),
        Tip(id: "tip_short_putt_confidence", title: "Building Unshakeable Confidence on Short Putts", summary: "Short putt confidence comes from a firm, decisive stroke aimed at the back of the cup.", body: "On putts inside four feet, pick a specific entry point on the hole, such as the center of the back edge, and hit the putt firmly enough to go 12 inches past if it misses. A firm putt takes some of the break out of the equation because the ball is traveling fast enough to hold its line longer. End every practice session by making 20 consecutive three-footers, and if you miss one, start over.", difficulty: .beginner, linkedIssueIDs: ["three_putting", "first_tee_nerves"]),
        Tip(id: "tip_putting_grip_pressure", title: "Grip Pressure for a Smooth Putting Stroke", summary: "Light, consistent grip pressure throughout the stroke promotes a smooth, pendulum-like motion.", body: "Hold the putter with a grip pressure of about three out of ten, just firm enough to control the club without any tension creeping into your forearms. Maintain this exact pressure from setup through the entire stroke, because any increase in grip tightness during the stroke introduces a jerk that pulls the putter offline. Light grip pressure is especially critical under pressure, when the natural tendency is to squeeze tighter.", difficulty: .intermediate, linkedIssueIDs: ["three_putting", "first_tee_nerves"]),
        // MARK: - Power & Distance Techniques
        Tip(id: "tip_swing_speed_training_intro", title: "Introduction to Swing Speed Training", summary: "Overspeed training with lightweight clubs can increase your swing speed by 5-8% in eight weeks.", body: "Purchase or create a set of speed training sticks in three weights: one lighter than your driver, one approximately the same weight, and one slightly heavier. Perform three sets of five max-effort swings with each stick three times per week with rest days between sessions. Expect to see measurable speed gains within four to six weeks.", difficulty: .intermediate, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_ground_force_reaction", title: "Using Ground Force to Generate Power", summary: "Elite golfers push into the ground to generate upward force that accelerates the downswing.", body: "During the transition from backswing to downswing, push hard into the ground with your lead foot as if you are trying to jump. This vertical ground force creates a chain reaction through your legs, hips, and torso that accelerates the club far more effectively than swinging your arms harder. The ground is your most powerful energy source, and learning to use it separates 100 mph swingers from 115 mph swingers.", difficulty: .advanced, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_wrist_mechanics_speed", title: "Wrist Mechanics for Maximum Clubhead Speed", summary: "Proper wrist hinge and release timing are responsible for a significant portion of clubhead speed.", body: "Maintain a full wrist hinge as deep into the downswing as possible, resisting the urge to release the angles early. The longer you retain your wrist hinge, the more speed you store for release right before impact. Focus on keeping your lead wrist flat or slightly bowed at impact while your trail wrist remains bent.", difficulty: .advanced, linkedIssueIDs: ["lack_of_distance", "slice"]),
        Tip(id: "tip_driver_optimization_loft", title: "Optimizing Your Driver Loft for Maximum Distance", summary: "Most amateurs use too little driver loft, costing them significant carry distance.", body: "Get on a launch monitor and test your driver at multiple loft settings, increasing by one degree each time, and track carry distance rather than total distance. Many amateurs with swing speeds between 85 and 100 mph gain significant yardage by moving from 9 or 10 degrees of loft to 11 or even 12 degrees. The ideal launch conditions for most amateurs are a launch angle of 12 to 15 degrees with a spin rate between 2000 and 2800 rpm.", difficulty: .beginner, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_launch_angle_optimization", title: "Finding Your Optimal Launch Angle", summary: "Launch angle works together with spin rate to determine how far your drives carry.", body: "Launch angle is determined primarily by your angle of attack and the loft of the club at impact. To increase launch angle, tee the ball higher and position it forward in your stance, off your lead heel, to encourage a slightly upward angle of attack. An upward attack angle of 3 to 5 degrees combined with the right loft creates a powerful, penetrating ball flight that maximizes carry.", difficulty: .intermediate, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_spin_rate_driver", title: "Understanding and Managing Driver Spin Rate", summary: "Too much spin on your driver makes the ball balloon and lose distance; too little makes it fall out of the sky.", body: "Your optimal driver spin rate depends on your swing speed: slower swingers around 85 mph need more spin, roughly 2500-3000 rpm, while faster swingers above 105 mph can get away with lower spin around 1800-2200 rpm. If you hit high, floating drives that nosedive quickly, your spin rate may be off. A session on a launch monitor can diagnose and fix spin-rate issues.", difficulty: .intermediate, linkedIssueIDs: ["lack_of_distance", "slice"]),
        Tip(id: "tip_hip_rotation_power", title: "Hip Rotation Speed for Explosive Power", summary: "Fast hip rotation creates a separation between your lower and upper body that multiplies clubhead speed.", body: "During the downswing, your hips should begin rotating toward the target while your shoulders are still facing away from it, creating a stretch in your core muscles that stores elastic energy. This separation, often called the X-factor stretch, is one of the strongest predictors of swing speed. Practice by placing a club across your hips, making your backswing, then snapping your hips open toward the target as fast as possible.", difficulty: .intermediate, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_flexibility_for_swing", title: "Key Flexibility Areas for a Bigger Swing", summary: "Flexibility in your hips, thoracic spine, and shoulders directly impacts your ability to make a full backswing.", body: "Tight hips restrict your rotation and prevent you from creating the X-factor that generates power, so incorporate hip flexor stretches and 90/90 hip mobility drills into your daily routine. Your thoracic spine is responsible for the bulk of your rotational range of motion, so foam rolling and seated rotation stretches should be daily habits. Committing to just 15 minutes of targeted stretching daily can add several degrees of rotation to your backswing within a month.", difficulty: .beginner, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_fitness_for_distance", title: "Strength Training for Golf Distance", summary: "A targeted strength program builds the muscle groups that generate rotational power in the golf swing.", body: "Focus on three categories of exercises: rotational power moves like medicine ball throws, lower body strength builders like squats and deadlifts, and core stability exercises like planks. Train three times per week during the off-season and twice weekly during the playing season. A study found that golfers who followed a structured strength program for 12 weeks gained an average of 5 mph in swing speed.", difficulty: .beginner, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_speed_through_relaxation", title: "Relaxation Creates Speed: Tension Is the Enemy", summary: "Muscle tension in the arms and hands actively reduces swing speed by restricting free motion.", body: "Before every drive, consciously soften your grip pressure to a four out of ten and let your arms hang relaxed from your shoulders with no tension in your forearms. Take a deep breath and exhale before you start your swing to release any residual tightness. Tension in the golf swing acts like a brake: tight muscles contract slowly and restrict the free-flowing motion needed for maximum clubhead speed.", difficulty: .beginner, linkedIssueIDs: ["lack_of_distance", "first_tee_nerves"]),
        Tip(id: "tip_attack_angle_driver", title: "Hitting Up on the Driver for Extra Yards", summary: "A positive angle of attack with the driver adds distance by launching the ball higher with less spin.", body: "To hit up on the driver, position the ball forward in your stance off your lead heel and tilt your spine slightly away from the target so your lead shoulder is higher than your trail shoulder at address. Feel as if you are swinging up through the ball at impact. A change from a negative 2-degree attack angle to a positive 3-degree attack angle can add 20 or more yards to your drives at the same swing speed.", difficulty: .intermediate, linkedIssueIDs: ["lack_of_distance"]),
        Tip(id: "tip_kinematic_sequence_power", title: "The Kinematic Sequence: Power From the Ground Up", summary: "Maximum power comes from firing your body segments in the correct sequence from ground to clubhead.", body: "The ideal downswing sequence is hips first, then torso, then arms, and finally the club, each segment accelerating and then decelerating to transfer energy to the next link in the chain. Think of it like cracking a whip: the handle moves first and each subsequent section moves faster. If your arms fire before your hips or your hands release before your arms have decelerated, energy is lost.", difficulty: .advanced, linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]),

        // MARK: - Course Management

        Tip(
            id: "tip_course_mgmt_know_distances",
            title: "Know Your Real Distances",
            summary: "Play with your actual carry distances, not your best-ever shots.",
            body: "Most amateurs overestimate how far they hit each club by 10-15 yards. Spend time on a launch monitor or use GPS data to learn your true average carry distance for every club. When selecting a club on the course, use your average distance, not the one time you flushed it perfectly. This single adjustment eliminates countless short-sided misses and improves your proximity to the hole dramatically.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_course_mgmt_play_to_strengths",
            title: "Play to Your Shot Shape",
            summary: "Stop fighting your natural ball flight and use it strategically.",
            body: "If you naturally hit a fade, aim down the left side and let the ball work back to the center. Trying to hit a draw when your default is a fade introduces unnecessary risk and tension. Build your course strategy around your most reliable shot shape, and you will find more fairways and greens. The best players in the world pick a shot shape and commit to it rather than constantly switching.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_course_mgmt_risk_reward",
            title: "Assess Risk vs. Reward Honestly",
            summary: "Before going for a hero shot, weigh the realistic upside against the downside.",
            body: "Ask yourself what happens if you execute the aggressive play versus what happens if you miss. If a failed attempt leads to a penalty stroke or an impossible recovery, the conservative play is almost always smarter. A good rule of thumb is that you should only attempt a risky shot if you can pull it off at least seven out of ten times on the range. Playing smart golf does not mean playing scared; it means maximizing your scoring opportunities over eighteen holes.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_course_mgmt_par5_strategy",
            title: "Par 5 Strategy for Scoring",
            summary: "Par 5s are your best birdie opportunities when you manage them wisely.",
            body: "Instead of blindly hitting driver and then your longest club, plan backward from the green. Identify your favorite wedge yardage and work out which combination of shots gets you there. Many times a 3-wood off the tee followed by a comfortable layup to 100 yards yields better results than driver into trouble. Par 5s should be the easiest holes on the course when you take penalty strokes out of play.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_par3_club_selection",
            title: "Par 3 Club Selection",
            summary: "On par 3s, always take enough club to reach the middle of the green.",
            body: "The most common miss on par 3s is short, because golfers pick a club based on the front edge distance rather than the pin. Always select your club based on the center of the green, and if the pin is in the back, consider adding one more club. Missing long is almost always a better outcome than missing short into bunkers or water. A two-putt from 30 feet above the hole beats a difficult pitch from a front bunker every time.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_short_par4",
            title: "Attack Short Par 4s Wisely",
            summary: "Short par 4s tempt you to hit driver, but precision often wins.",
            body: "On drivable or short par 4s, the fairway often narrows and trouble lurks near the green. Consider hitting a long iron or hybrid to your favorite approach distance instead of driver. Placing the ball in the fairway at 100 yards gives you a realistic birdie look with minimal bogey risk. The scoreboard rewards birdies and pars, not how far you hit your drive.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_long_par4",
            title: "Managing Long Par 4s",
            summary: "On tough long par 4s, accept that par is a great score.",
            body: "Long par 4s over 430 yards are some of the hardest holes in golf, and trying to force a birdie often leads to big numbers. Focus on hitting the fairway first, then getting your approach somewhere on or near the green. If you are between clubs on the approach, favor the center of the green rather than attacking a tucked pin. Making par on the hardest holes and capitalizing on the easier ones is how good scores are built.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_pin_positions",
            title: "Reading Pin Positions",
            summary: "Adjust your target based on where the pin is tucked, not just where it sits.",
            body: "When the pin is cut tight to a bunker or edge, your target should be the fat part of the green, not the flag. Only attack pins that are accessible, meaning there is room between the pin and any hazard for your ball to land and stop. A general rule is to be aggressive with center pins and conservative with pins near edges. Over eighteen holes, this discipline prevents the blow-up holes that destroy rounds.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_wind_into",
            title: "Playing Into the Wind",
            summary: "Club up and swing easy when hitting into a headwind.",
            body: "A common mistake is swinging harder into the wind, which adds spin and makes the ball balloon even higher. Instead, take one or two extra clubs and make a smooth, controlled swing. A knockdown-style shot with a longer club keeps the ball lower and penetrates through the wind more effectively. Remember that a 15 mph headwind can add 10-15 yards of effective distance to your shot, so always overestimate its effect.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_wind_crosswind",
            title: "Handling Crosswinds",
            summary: "Aim to use the crosswind rather than fight it.",
            body: "When the wind blows from left to right, aim further left and let the wind bring the ball back toward your target. Fighting a crosswind by trying to curve the ball into it requires precise execution and dramatically increases your miss potential. If the wind matches your natural shot shape, ride it for extra distance and accuracy. If it opposes your natural shot shape, aim even further to allow for the wind holding the ball up on its line.",
            difficulty: .advanced,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_course_mgmt_elevation_uphill",
            title: "Adjusting for Uphill Shots",
            summary: "Uphill shots play longer than the measured distance.",
            body: "A general guideline is to add one club for every 10-15 feet of elevation gain between you and the green. An uphill shot also tends to fly higher and land softer, so factor that into your club selection. Use a rangefinder that accounts for slope, or learn to eyeball elevation changes by looking at the terrain between your ball and the target. Underclubbing on uphill shots is one of the most common mistakes recreational golfers make.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_elevation_downhill",
            title: "Adjusting for Downhill Shots",
            summary: "Downhill shots play shorter and roll out more on landing.",
            body: "Subtract roughly one club for every 10-15 feet of downhill elevation change. Downhill shots tend to launch lower and run out more upon landing, so aim for the front portion of the green when possible. Be cautious of going long, as the ball carries extra momentum and will roll further than usual. Wind effects are also amplified on downhill shots because the ball stays in the air longer.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_course_mgmt_play_away_from_trouble",
            title: "Aim Away from Trouble",
            summary: "When danger lurks on one side, shift your target to the safe side.",
            body: "If there is water down the left side, tee up on the left side of the tee box and aim toward the right half of the fairway. This geometry gives you the maximum angle away from the hazard. Even if you hit your worst shot, it is more likely to end up in a playable position rather than in the hazard. This simple alignment strategy can save two or three penalty strokes per round without changing your swing at all.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_course_mgmt_smart_miss",
            title: "Plan Your Smart Miss",
            summary: "Before every shot, decide where the acceptable miss is.",
            body: "Tour professionals plan where they want to miss before every shot, and you should too. Identify the side of the fairway or green where a miss will leave you with the easiest recovery. For example, if a bunker guards the front-right of the green, your smart miss is left-center or long. Committing to a smart miss target actually frees you up to swing with more confidence because you have already accepted a range of outcomes.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_course_mgmt_layup_yardage",
            title: "Layup to Your Favorite Yardage",
            summary: "When laying up, pick a specific distance that suits your wedge game.",
            body: "Rather than hitting as far as you can on a layup, choose a distance where you are most comfortable and accurate with your wedges. For most golfers, this is somewhere between 80 and 110 yards. Practice this specific yardage on the range so you have full confidence when you reach it on the course. A well-executed wedge from your favorite distance creates far more birdie chances than a mediocre shot from an awkward in-between yardage.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_course_mgmt_manage_bad_hole",
            title: "Damage Control on Bad Holes",
            summary: "When a hole goes wrong, shift your goal to limiting the damage.",
            body: "After a bad tee shot or a penalty, your new goal should be to make bogey at worst, not to recover the lost stroke immediately. Trying to make up for a mistake by hitting a hero shot from trouble usually compounds the problem. Take your medicine, get the ball back in play, and give yourself a chance to salvage a bogey or even a par. The difference between a bogey and a triple bogey is often just one overly aggressive recovery attempt.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_course_mgmt_tee_box_strategy",
            title: "Use the Entire Tee Box",
            summary: "Where you tee your ball within the tee box can change the shape of the hole.",
            body: "Most golfers tee up in the center of the tee box without thinking, but moving to either side can open up angles and improve your line. Teeing on the far right side allows you to aim more toward the left side of the fairway and vice versa. On dogleg holes, tee up on the side closest to the trouble so your target line moves away from it. This small positioning adjustment costs nothing but can make a meaningful difference in your scoring.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_course_mgmt_avoid_sucker_pins",
            title: "Recognize Sucker Pin Positions",
            summary: "Some pin positions are designed to lure you into trouble.",
            body: "A sucker pin is one that looks attackable but is surrounded by severe trouble with very little margin for error. Pins tucked behind bunkers, placed on narrow shelves, or positioned near water edges are classic examples. The smartest play is to aim for the center of the green and take your two-putt par. Course designers want you to be seduced by these pins, so recognizing the trap is your first defense against big numbers.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_bogey_golfer_strategy",
            title: "Strategy for Higher Handicappers",
            summary: "If you shoot over 90, focus on avoiding double bogeys, not making birdies.",
            body: "The fastest way to lower your scores is to eliminate the big numbers, not to chase more birdies. Play to the widest part of every fairway and the center of every green, regardless of the pin position. A string of bogeys is a far better score than alternating pars with triples and doubles. Once you consistently break 90 with this conservative approach, you can start selectively attacking certain holes.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_course_mgmt_when_to_be_aggressive",
            title: "When to Be Aggressive",
            summary: "Certain situations on the course actually reward aggressive play.",
            body: "Be aggressive when the penalty for missing is low, such as a wide-open green with no hazards or a short hole with trouble only on one side that does not affect your shot shape. Also consider being aggressive when you are behind in a match and need to make up strokes. The key is that aggressive golf should be a deliberate, calculated choice rather than an emotional reaction. Pick your spots wisely and you can gain strokes without taking on undue risk.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_course_mgmt_first_hole_strategy",
            title: "First Hole Game Plan",
            summary: "Start your round with a conservative, confidence-building strategy.",
            body: "The first tee shot sets the tone for your entire round, so prioritize getting the ball in play over hitting it as far as possible. Consider using a club you are most confident with off the tee, even if it is a 3-wood or hybrid. A fairway hit on the first hole builds momentum and calms your nerves. Save the aggressive driver swings for later holes when your body is warmed up and your tempo is established.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_closing_holes",
            title: "Strategy for Closing Holes",
            summary: "Protect your score on the final three holes by sticking to your game plan.",
            body: "The last few holes of a round are where many golfers let a good score slip away by changing their approach. If your strategy has been working all day, do not suddenly become more aggressive or more conservative because you are counting your score. Maintain the same decision-making framework you have been using and trust your process. Finishing strong is about discipline, and the golfers who close well are the ones who do not let the scorecard influence their shot selection.",
            difficulty: .advanced,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_course_mgmt_playing_in_rain",
            title: "Course Management in the Rain",
            summary: "Wet conditions change how far the ball flies and rolls.",
            body: "Rain reduces both carry distance and rollout, so add at least one extra club on every approach shot. Greens will hold more, meaning you can be more aggressive with your landing spot, but the ball will not release as much toward the pin. Keep your grips dry with a towel and keep spare gloves in a zip-lock bag in your golf bag. Accepting that scores will be higher in the rain takes pressure off and helps you stay patient.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_course_mgmt_dogleg_strategy",
            title: "Playing Dogleg Holes",
            summary: "On dogleg holes, position is far more important than distance.",
            body: "The goal on a dogleg is to reach the corner so you have a clear line to the green, not to cut the corner and risk the trees or hazards. Use a club that reliably reaches the turning point while staying in the fairway. On a dogleg left, aim toward the right side of the fairway to open up the angle for your approach, and do the opposite on a dogleg right. Cutting the corner only pays off if you can carry the trouble by a safe margin, and most of the time the risk outweighs the reward.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_course_mgmt_warmup_range_session",
            title: "Pre-Round Warm Up Strategy",
            summary: "Your warm up session should identify your tendencies for the day, not fix your swing.",
            body: "Arrive at the course with enough time to hit 20-30 balls before your round, starting with wedges and working up to driver. Pay attention to your predominant ball flight that day rather than trying to fix anything. If you are fading the ball on the range, plan to play a fade on the course. Use the putting green to gauge green speed, and hit a few chips to calibrate your touch. A focused 20-minute warm up is far more valuable than a rushed first tee shot with no preparation.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        // MARK: - Trouble Shots & Recovery

        Tip(
            id: "tip_trouble_deep_rough_technique",
            title: "Escaping Deep Rough",
            summary: "In thick rough, open the clubface and swing steeply to get the ball out.",
            body: "When your ball settles deep in thick rough, the grass will grab the hosel and close the clubface at impact. To counteract this, open the clubface slightly at address and grip it firmly with your left hand. Swing steeper than normal by hinging your wrists earlier in the backswing, and commit to accelerating through the grass. Your primary goal should be to advance the ball back to the fairway, not to reach the green, so take enough loft to ensure escape.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_light_rough_approach",
            title: "Approach Shots from Light Rough",
            summary: "From light rough, expect a flyer lie that launches lower with less spin.",
            body: "When the ball sits up in light rough, grass gets between the clubface and the ball at impact, reducing backspin and creating a flyer. The ball will come out lower than normal and roll significantly more after landing. Take one less club than the measured distance and aim for the front edge of the green to account for the extra rollout. Be especially cautious when there is trouble behind the green, as flyers can easily sail 10-15 yards past your intended target.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_trouble_hardpan_lie",
            title: "Playing from Hardpan",
            summary: "On hardpan lies, use a sweeping motion and avoid trying to dig.",
            body: "Hardpan lies with bare, compacted dirt require precise contact because there is zero margin for hitting behind the ball. Use a less-lofted club than you normally would and position the ball slightly back in your stance. Focus on making a shallow, sweeping contact where the leading edge strikes the ball cleanly. Avoid using high-lofted wedges with a lot of bounce, as the sole will skip off the hard surface and blade the ball across the green.",
            difficulty: .advanced,
            linkedIssueIDs: ["fat_shots", "topping"]
        ),

        Tip(
            id: "tip_trouble_uphill_lie",
            title: "Hitting from an Uphill Lie",
            summary: "On uphill lies, match your shoulders to the slope and expect a higher shot.",
            body: "When the ground slopes upward toward your target, tilt your shoulders to match the hillside so your left shoulder is higher than your right. Play the ball slightly forward in your stance and take one or two extra clubs because the uphill slope adds effective loft to whatever club you are holding. Swing along the slope rather than into it, allowing the club to follow the terrain through impact. The ball will fly higher than normal and tend to draw, so aim slightly right of your target.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_trouble_downhill_lie",
            title: "Hitting from a Downhill Lie",
            summary: "On downhill lies, keep your weight on your front foot and chase the ball down the slope.",
            body: "Downhill lies are among the most challenging in golf because they reduce the effective loft of the club and make it easy to top the ball. Set up with most of your weight on your lead foot and position the ball back in your stance. Take one less club because the delofted face will produce a lower, hotter ball flight. The key move is to chase the clubhead down the slope through impact rather than trying to scoop the ball into the air, and accept that the ball will fly lower and run more.",
            difficulty: .advanced,
            linkedIssueIDs: ["topping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_ball_above_feet",
            title: "Ball Above Your Feet",
            summary: "When the ball is above your feet, it will tend to hook, so aim right.",
            body: "A sidehill lie with the ball above your feet effectively flattens your swing plane, promoting a draw or hook. Grip down on the club to compensate for being closer to the ball and aim to the right of your target to allow for the leftward curve. Stand slightly more upright than normal and make a controlled, three-quarter swing to maintain balance. The more severe the slope, the more you need to aim right, so gauge the degree of the hill before committing to your line.",
            difficulty: .intermediate,
            linkedIssueIDs: ["hook", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_ball_below_feet",
            title: "Ball Below Your Feet",
            summary: "When the ball is below your feet, it will tend to slice, so aim left.",
            body: "A lie with the ball below your feet steepens your swing plane and opens the clubface, producing a fade or slice. Bend more from your knees and hips to reach the ball, and grip the club at its full length. Aim left of your target to account for the rightward curve and focus on maintaining your spine angle throughout the swing. Balance is critical on this lie, so take a wider stance and make a smooth, controlled swing rather than a full aggressive pass.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_punch_under_trees",
            title: "Punch Shot Under Trees",
            summary: "Use a low punch shot to advance the ball under tree branches and back to safety.",
            body: "Select a mid-iron like a 5 or 6 iron and play the ball back in your stance with your hands pressed well forward. Make a three-quarter backswing and abbreviate your follow-through so your hands finish around chest height. This combination delofts the club and produces a low, boring flight that stays under tree limbs. Resist the temptation to look up early to see the result; keep your head down and trust the setup to produce the low trajectory you need.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "slice"]
        ),

        Tip(
            id: "tip_trouble_playing_from_divot",
            title: "Playing from a Divot",
            summary: "Finding your ball in a divot is frustrating, but the technique is straightforward.",
            body: "Position the ball slightly back of center in your stance and place a bit more weight on your lead foot. The goal is to hit the ball with a slightly descending blow, compressing it against the bottom of the divot before the club moves through. Use one more club than normal because the ball will launch lower with slightly less spin. Keep your expectations realistic; a solid contact from a divot that advances the ball to a good position is a successful shot.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_fairway_bunker",
            title: "Fairway Bunker Fundamentals",
            summary: "In a fairway bunker, clean contact is everything.",
            body: "The key to fairway bunker shots is hitting the ball before the sand, which is the opposite of a greenside bunker. Dig your feet slightly into the sand for stability, then grip down on the club the same amount your feet sank in. Position the ball in the center of your stance and focus your eyes on the top of the ball. Take one more club than the distance calls for, make a smooth three-quarter swing, and prioritize balance over power. If the lip of the bunker is high, take enough loft to clear it even if that means you cannot reach the green.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_pine_straw",
            title: "Playing from Pine Straw",
            summary: "Pine straw lies require a clean pick to avoid disturbing the ball at address.",
            body: "When your ball rests on pine straw, be extremely careful at address because the ball can shift and cost you a penalty stroke. Hover the club above the ground rather than grounding it behind the ball. Play the ball slightly back in your stance and make a steep, descending strike to pick the ball cleanly. Pine straw lies often produce flyer-type results with less spin, so plan for extra rollout when the ball lands. Take a smooth swing and prioritize clean contact above all else.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_trouble_leaves_lie",
            title: "Playing from a Bed of Leaves",
            summary: "Leaves create an unpredictable cushion under the ball that demands careful technique.",
            body: "Similar to pine straw, do not ground your club when your ball sits on leaves, as any movement could cause the ball to shift. Take a wider stance for stability and focus on sweeping the ball off the top of the leaves with a slightly shallower swing. Accept that controlling spin and distance is nearly impossible from this lie, and aim for the safest area near your target. If the leaves are wet, expect even less control, and prioritize simply advancing the ball to a clean lie.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_trouble_water_hazard_strategy",
            title: "Smart Play Around Water Hazards",
            summary: "Water hazards demand respect, so always give yourself a margin of safety.",
            body: "When water guards one side of a hole, pick a target that gives you at least 10-15 yards of buffer from the hazard edge. If water runs along the entire left side, aim well right of center and accept that a slightly pushed shot is a perfectly fine outcome. On approach shots over water, always take enough club to carry the hazard comfortably, even if that means going long. One of the biggest scoring killers in amateur golf is choosing a club that only carries the water on a perfect strike.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_trouble_penalty_drop_strategy",
            title: "Strategic Penalty Drops",
            summary: "When taking a penalty drop, choose the option that gives you the best next shot.",
            body: "After hitting into a penalty area, you typically have multiple relief options, and picking the right one can save you a stroke. Walk forward and evaluate each option before deciding: sometimes going back to where you played from is better than dropping near the hazard. Consider the lie you will get from each drop zone and which angle gives you the clearest path to the green. A thoughtful drop that leads to a good bogey is far better than a hasty decision that compounds the mistake into a double or worse.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_trouble_buried_bunker_lie",
            title: "Dealing with a Buried Bunker Lie",
            summary: "A fried egg or buried lie in a bunker requires a more aggressive technique.",
            body: "Close the clubface slightly rather than opening it, which may seem counterintuitive for a bunker shot. Position the ball in the middle of your stance and swing steeply down into the sand about an inch behind the ball. The closed face digs into the sand and pops the ball out with minimal spin, so expect the ball to run significantly after landing. Do not try to be cute with this shot; your goal is simply to get the ball out of the bunker and onto the green, regardless of where the pin is.",
            difficulty: .advanced,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_recovery_shot_selection",
            title: "Choosing the Right Recovery Shot",
            summary: "The best recovery shot is the one that guarantees your next shot is from a good lie.",
            body: "When you are in trouble, resist the urge to go for the green if there is any significant risk of staying in trouble or making your situation worse. Ask yourself what the highest-percentage play is that gets you back into a scoring position. Sometimes that means chipping sideways to the fairway, and there is no shame in that. The mental discipline to take one shot to recover rather than gambling on a miracle saves multiple strokes over the course of a round.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_trouble_high_lob_over_obstacle",
            title: "The High Lob Over an Obstacle",
            summary: "When you need maximum height quickly, open your lob wedge and slide under the ball.",
            body: "Open your 58 or 60 degree wedge so the face points almost straight up at the sky, and widen your stance slightly. Play the ball forward in your stance, just inside your lead heel, and make a full, committed swing along your foot line. The club will slide under the ball and pop it nearly straight up with a soft landing. This shot requires confidence and practice because any deceleration will result in a chunked or skulled disaster. Spend time on the practice green perfecting this technique before you need it on the course.",
            difficulty: .advanced,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_hook_around_tree",
            title: "Curving the Ball Around a Tree",
            summary: "Intentional hooks and slices can save you a stroke when a tree blocks your line.",
            body: "To hit a deliberate hook around a tree, close the clubface at address and aim your body line to the right of the obstacle. Swing along your body line and the closed face will impart right-to-left spin, curving the ball around the tree. For a deliberate slice, do the opposite: open the face and aim your body left. Keep in mind that a hook will fly lower and run more, while a slice will fly higher and stop quicker. Practice these shaped shots on the range so they are available when you need them.",
            difficulty: .advanced,
            linkedIssueIDs: ["hook", "slice"]
        ),

        Tip(
            id: "tip_trouble_wet_lie_technique",
            title: "Playing from Wet or Muddy Lies",
            summary: "Wet lies reduce friction and produce unpredictable ball flights.",
            body: "Water or mud between the clubface and ball dramatically reduces backspin, creating a flyer effect where the ball travels further and rolls more. Take one less club and aim for the front of the green to account for the extra distance and reduced stopping power. Play the ball slightly back in your stance to promote a cleaner strike and reduce the amount of water that intervenes at impact. If there is standing water around the ball, check if you are entitled to free relief before playing the shot.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_steep_uphill_chip",
            title: "Chipping from a Steep Uphill Lie",
            summary: "On steep uphill chip shots, lean with the slope and use a less-lofted club.",
            body: "The uphill slope adds significant loft to any club you choose, so consider using a pitching wedge or even a 9 iron instead of your usual chipping wedge. Set your shoulders parallel to the slope and play the ball in the middle of your stance. Make your normal chipping stroke but swing along the slope, letting the club follow the terrain through impact. The ball will pop up quickly and land softly, so account for less rollout than you would expect from the club you selected.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_tight_lie_around_green",
            title: "Tight Lies Around the Green",
            summary: "Tight lies around the green require a precise, shallow chip technique.",
            body: "When the ball sits on a closely mown or bare lie near the green, the margin for error on your chip is extremely thin. Use a club with less bounce, such as a gap wedge, and position the ball back in your stance with your weight favoring your lead foot. Make a putting-style stroke with just enough hinge to brush the grass, letting the leading edge catch the ball cleanly. Keep your hands ahead of the clubhead through impact and resist any temptation to help the ball into the air.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "shanks"]
        ),

        Tip(
            id: "tip_trouble_long_bunker_shot",
            title: "The Long Bunker Shot (30-50 yards)",
            summary: "Medium-length bunker shots are among the hardest in golf but follow a simple formula.",
            body: "For bunker shots between 30 and 50 yards, the classic explosion technique does not generate enough distance, and a normal pitch swing risks catching it thin. Use your gap wedge or pitching wedge with a slightly open face, and take less sand than a standard greenside bunker shot. Focus on entering the sand about half an inch behind the ball rather than the usual two inches. Make a full swing and let the club slide through the sand, producing a shot that carries further than a typical splash shot while still maintaining some control.",
            difficulty: .advanced,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_trouble_provisional_ball",
            title: "When to Hit a Provisional Ball",
            summary: "Save time and potential penalty by hitting a provisional when your ball might be lost.",
            body: "If there is any doubt about whether you can find your tee shot or whether it crossed into a penalty area, announce and hit a provisional ball immediately. This saves you the walk of shame back to the tee if your original ball is lost or out of bounds. Hit the provisional with a smart, conservative club choice that puts the ball safely in play. A provisional ball in the fairway that leads to a bogey is far better than the stroke-and-distance penalty of returning to the tee after a five-minute search.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        // MARK: - Mental Game & Performance

        Tip(
            id: "tip_mental_visualization",
            title: "Visualize Every Shot Before You Swing",
            summary: "See the shot in your mind before you step up to the ball.",
            body: "Stand behind the ball and create a vivid mental image of the shot you want to hit, including the trajectory, curve, and landing spot. Picture the ball flying through the air exactly as you intend, landing softly, and finishing near your target. This pre-shot visualization engages your motor cortex and primes your muscles for the movement you want to make. The more detailed your mental image, the more effectively your body can reproduce it. Top professionals never hit a shot without first seeing it in their mind.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_mental_preshot_routine",
            title: "Develop a Consistent Pre-Shot Routine",
            summary: "A repeatable pre-shot routine anchors your focus and builds consistency.",
            body: "Design a routine that you perform before every shot, and keep it under 30 seconds. It might include one practice swing, a deep breath, a visualization step, and then stepping into your address position. The routine serves as a mental trigger that tells your brain it is time to perform, blocking out distractions and calming your nerves. The key is consistency; your routine should feel identical whether you are on the first tee or the 72nd hole of a tournament. Practice your routine on the range so it becomes automatic.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_confidence_building",
            title: "Build Confidence Through Preparation",
            summary: "True confidence comes from knowing you have put in the work.",
            body: "Confidence is not a feeling you can simply will into existence; it is built through deliberate practice and preparation. When you have practiced a specific shot hundreds of times on the range, you carry genuine belief that you can execute it under pressure. Keep a practice log to track your sessions, and before a round, remind yourself of the work you have done. Confidence also comes from having a game plan, so walk to the first tee knowing exactly how you intend to play each hole.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_manage_expectations",
            title: "Set Realistic Expectations",
            summary: "Unrealistic expectations create frustration that ruins your round.",
            body: "If you are a 20-handicap golfer, expecting to hit every green in regulation will leave you angry and defeated. Instead, set process goals like hitting a specific number of fairways or completing your pre-shot routine on every shot. Accept that even tour professionals miss greens, hit bad shots, and make bogeys. When you align your expectations with your actual skill level, you play with more freedom and enjoy the game more. Paradoxically, lowering your expectations often leads to lower scores.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_mental_playing_in_zone",
            title: "Accessing the Zone",
            summary: "The zone is a state of effortless focus that you can cultivate with the right habits.",
            body: "Playing in the zone means your conscious mind steps aside and your trained instincts take over. You can increase your chances of entering this state by staying fully present on each shot rather than thinking about your score or past mistakes. Focus on one shot at a time and commit completely to your target and club selection before swinging. Deep, rhythmic breathing between shots keeps your nervous system calm and your mind clear. The zone cannot be forced, but it can be invited through trust, presence, and a quiet mind.",
            difficulty: .advanced,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_handling_pressure",
            title: "Handling Pressure Situations",
            summary: "Pressure is not your enemy; your response to it determines the outcome.",
            body: "When you feel pressure building, recognize it as a sign that you care about the outcome, which is a positive thing. Channel the adrenaline by taking an extra deep breath and slowing your routine down slightly, not speeding it up. Focus on the process of making a good swing rather than the result, because you can control your preparation and commitment but not where the ball ends up. Many golfers perform poorly under pressure because they speed up; the simple act of slowing down can be transformative.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_mental_bounce_back",
            title: "Bouncing Back from a Bad Hole",
            summary: "How you respond to a bad hole matters more than the bad hole itself.",
            body: "After a blow-up hole, give yourself the walk to the next tee to process the frustration, then deliberately let it go. Remind yourself that one bad hole does not define your round; there are plenty of holes remaining to recover. Take an extra moment on the next tee to reset your routine and commit fully to a smart, conservative game plan. Many great rounds include one or two bad holes followed by a strong recovery stretch. The golfers who crumble after a bad hole are the ones who carry the frustration forward instead of releasing it.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_positive_self_talk",
            title: "Practice Positive Self-Talk",
            summary: "The words you say to yourself directly influence your performance.",
            body: "Pay attention to your internal dialogue on the course. If you catch yourself saying things like 'don't hit it in the water,' your brain fixates on the water because it cannot process a negative command. Instead, frame your self-talk positively: 'hit it to the center of the green' or 'make a smooth, committed swing.' Replace criticism after bad shots with constructive observations like 'next time I will commit more to my target.' Over time, positive self-talk builds a mental environment where good performance can flourish.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_course_mgmt_mindset",
            title: "Think Like a Course Manager",
            summary: "Approach each hole as a strategic puzzle rather than a test of your ball-striking.",
            body: "Before teeing off on each hole, take a moment to identify the safest route to a good score. Consider where the trouble is, where the bailout areas are, and which part of the green gives you the best chance to two-putt. This strategic mindset shifts your focus from swing mechanics to shot planning, which is where the real scoring happens. When you think like a course manager, bad swings become less costly because your strategy has already accounted for imperfect execution.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_mental_tournament_preparation",
            title: "Preparing for Tournament Play",
            summary: "Tournament preparation starts days before the first tee shot.",
            body: "Play a practice round focused entirely on strategy: note pin positions, identify bailout areas, and determine which clubs you will hit off each tee. Prepare your equipment the night before, including extra balls, gloves, tees, and a rain suit. Get adequate sleep and eat a balanced meal before the round to ensure your energy levels are stable. Arrive early enough to warm up without rushing, and use the practice green to calibrate your speed for the day. The more prepared you feel, the more your nerves will be replaced by quiet confidence.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_first_tee_confidence",
            title: "Conquering First Tee Jitters",
            summary: "First tee nerves are normal, even for professionals, but manageable techniques exist.",
            body: "Accept that feeling nervous on the first tee is a universal experience and does not mean something is wrong. Use a club you trust most off the tee, even if it means sacrificing distance, because the goal is to get the ball in play and settle into your round. Take three slow, deep breaths before stepping into your setup, inhaling for four counts and exhaling for six. Focus all your attention on a small, specific target in the fairway rather than thinking about the people watching or your score. Once you have hit one solid shot, the nerves typically dissipate quickly.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_managing_anger",
            title: "Managing Anger on the Course",
            summary: "Anger after a bad shot is natural, but letting it linger costs you strokes.",
            body: "Give yourself a ten-second window to feel the frustration after a bad shot, then actively choose to let it go. Physical tension from anger tightens your muscles and ruins the smooth tempo you need for good golf. Develop a release ritual, such as taking a deep breath and physically relaxing your shoulders and hands before walking to your next shot. Remember that every shot you hit while angry is statistically more likely to be another bad shot, so managing your emotions is not just about feeling better; it is a genuine scoring strategy.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_patience",
            title: "The Power of Patience",
            summary: "Golf rewards patience more than almost any other sport.",
            body: "A round of golf takes four or more hours, and your actual swing time is only about two minutes of that. The rest is walking, waiting, and thinking, which means patience is not optional; it is a core skill. When you are having a bad stretch, trust that the round has enough holes for you to turn it around. Avoid trying to get all your strokes back on a single hole, as that impatience leads to compounding errors. The patient golfer who grinds through tough stretches and capitalizes on good breaks will always outscore the emotional golfer with equal physical talent.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_mental_process_over_results",
            title: "Focus on Process, Not Results",
            summary: "Shift your attention from outcomes to the quality of your decisions and execution.",
            body: "You cannot control whether a perfectly struck putt lips out or whether a gust of wind pushes your approach into a bunker. What you can control is your preparation, your commitment to each shot, and the quality of your decision-making. After each round, evaluate yourself on whether you stuck to your routine, picked smart targets, and committed to your shots, rather than fixating on the score. Over time, a consistent, high-quality process will produce the results you want. Ironically, the less you focus on score, the lower your scores tend to become.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_breathing_technique",
            title: "Breathing for Better Performance",
            summary: "Controlled breathing is the fastest way to regulate your nervous system on the course.",
            body: "Before any shot where you feel tension or pressure, practice box breathing: inhale for four counts, hold for four counts, exhale for four counts, and hold for four counts. This technique activates your parasympathetic nervous system, slowing your heart rate and reducing the cortisol that causes tight muscles and rushed swings. Make breathing part of your pre-shot routine so it becomes automatic. Between holes, walk at a comfortable pace and breathe naturally through your nose to maintain a calm baseline state throughout the round.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_mental_commitment_to_shot",
            title: "Full Commitment to Every Shot",
            summary: "A fully committed swing with the wrong club beats a tentative swing with the right club.",
            body: "Indecision is the enemy of good golf. Once you have chosen your club and target, eliminate all doubt and commit completely to the shot. If you stand over the ball and feel uncertain, step away, reassess, and start your routine over. A tentative, half-hearted swing produces poor contact and unpredictable results regardless of how good your mechanics are. Trust your preparation, trust your decision, and swing with conviction every single time.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_mental_acceptance",
            title: "Practice Radical Acceptance",
            summary: "Accept every outcome immediately and move on to the next shot with a clear mind.",
            body: "The ball does not know what you intended, and once it leaves the clubface, you have zero control over the outcome. Practice accepting the result of every shot instantly, whether it is a perfect draw or a shank into the trees. Radical acceptance does not mean you do not care; it means you refuse to let past shots contaminate future ones. When you watch top professionals, notice how quickly they shift their attention from the result to their next play. That rapid acceptance is a trained skill that you can develop with consistent practice.",
            difficulty: .advanced,
            linkedIssueIDs: ["first_tee_nerves", "shanks"]
        ),

        Tip(
            id: "tip_mental_one_shot_at_a_time",
            title: "One Shot at a Time",
            summary: "The only shot that matters is the one you are about to hit right now.",
            body: "It sounds simple, but truly focusing on one shot at a time is one of the hardest things in golf. Your mind naturally wanders to what just happened or what lies ahead, and both of those thought patterns pull you away from the present moment. Develop a mental trigger that brings you back to the current shot, such as focusing on the feel of the grip in your hands or the texture of the grass beneath your feet. Train this present-moment awareness on the practice green where the stakes are low. Over time, the ability to stay in the present becomes your greatest competitive advantage.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_post_round_review",
            title: "Productive Post-Round Reviews",
            summary: "Review your round constructively to identify patterns and improve decision-making.",
            body: "After every round, spend five minutes reviewing your key decisions rather than dwelling on bad shots. Ask yourself where you made smart choices that led to good outcomes and where you made decisions you would change. Note any recurring patterns, such as consistently underclubbing on approach shots or losing focus on back-nine par 3s. Write these observations down so you can address them in practice. A short, honest review after each round accelerates your improvement more than hours of mindless range time.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_mental_playing_with_better_golfers",
            title: "Learning from Better Players",
            summary: "Playing with golfers who are better than you is one of the fastest ways to improve.",
            body: "When you play with skilled golfers, observe their course management, their tempo, and their decision-making rather than just their ball-striking. Notice how they pick targets, how they handle bad shots, and how they manage their energy over eighteen holes. Do not try to keep up with their distance; instead, play your own game while absorbing their strategic approach. Ask questions between holes about why they chose a particular club or target. Most good golfers are happy to share their thinking, and their insights can reshape how you approach the game.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_mental_enjoyment_factor",
            title: "Remember to Enjoy the Game",
            summary: "Golf is supposed to be fun, and enjoying yourself actually helps you play better.",
            body: "When you are having fun, your muscles are relaxed, your mind is clear, and your swing flows naturally. Many golfers become so consumed with score and technique that they forget why they started playing in the first place. Make a conscious effort to appreciate the course, the company, and the challenge rather than treating every round as a test. Smile more, laugh at your bad shots, and celebrate your good ones. Research shows that athletes who enjoy their sport perform better under pressure, so having fun is not a luxury; it is a competitive advantage.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_staying_present_between_shots",
            title: "Staying Present Between Shots",
            summary: "What you think about between shots is just as important as what you think during them.",
            body: "Most of your time on the course is spent walking between shots, and this is where your mental state is either built up or torn down. Rather than replaying your last shot or worrying about the next one, engage with your surroundings: notice the trees, the birds, the sky, the conversation with your playing partners. Save your focused, analytical thinking for the 30-second window of your pre-shot routine. This rhythm of engagement and relaxation keeps your mental energy fresh throughout the round and prevents the cumulative fatigue that leads to poor decisions on the closing holes.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_dealing_with_slow_play",
            title: "Maintaining Focus During Slow Play",
            summary: "Slow play is frustrating, but losing your rhythm costs you more than the wait.",
            body: "When the pace of play slows down, the biggest danger is losing your routine and mental sharpness. Use the extra time to fully assess your next shot, check the wind, and plan your strategy rather than stewing about the delay. Take some practice swings or stretch to keep your muscles loose during long waits. Avoid the common trap of rushing your shot when it is finally your turn just because you feel you have held people up. Stay committed to your normal tempo and routine regardless of how long you have been waiting, because a rushed swing after a long wait is a recipe for a bad shot.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_mental_swing_thought_simplicity",
            title: "Keep Swing Thoughts Simple",
            summary: "On the course, limit yourself to one simple swing thought at most.",
            body: "The range is for working on mechanics with multiple checkpoints, but the course demands simplicity. Choose one feel-based swing thought that encapsulates your current focus, such as 'smooth tempo' or 'finish balanced.' If you stand over the ball thinking about grip pressure, shoulder turn, hip rotation, and wrist angles simultaneously, your brain will freeze and your body will produce a tense, disjointed swing. Trust that the work you have done in practice is stored in your muscle memory, and give your body the freedom to execute with a quiet, uncluttered mind.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        // MARK: - Practice & Training

        Tip(
            id: "tip_structured_range_session",
            title: "Structure Your Range Sessions",
            summary: "A planned practice session is far more productive than mindlessly hitting balls.",
            body: "Divide your range bucket into three sections: warm-up, technique work, and on-course simulation. Spend the first 15 balls loosening up with short irons, then dedicate the middle portion to a specific skill you want to improve. Finish by playing imaginary holes, switching clubs and targets with every shot. This structure turns a casual bucket of balls into a purposeful training session that transfers to the course.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_quality_over_quantity",
            title: "Quality Over Quantity at the Range",
            summary: "Fifty focused shots beat two hundred careless ones every time.",
            body: "Slow down between shots and commit to a full pre-shot routine for every ball you hit. Pick a specific target for each shot rather than just aiming at the open field. Take at least 15 seconds between swings to reset mentally and physically. You will build better habits with a small bucket and full focus than with a jumbo bucket you rush through.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_block_practice_basics",
            title: "Block Practice for New Skills",
            summary: "Repetitive block practice helps engrain a new movement pattern quickly.",
            body: "When learning a new technique, hit 20 to 30 balls in a row with the same club to the same target. This repetition gives your body enough feedback loops to start recognizing the correct motion. Keep a single swing thought in mind and avoid changing your focus mid-set. Block practice is ideal early in the learning process before transitioning to more random practice formats.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_random_practice_transfer",
            title: "Random Practice for Course Transfer",
            summary: "Switching clubs and targets every shot mimics real golf and builds adaptability.",
            body: "After you have grooved a technique with block practice, shift to random practice where you never hit the same shot twice in a row. Pull a different club, pick a new target, and go through your full pre-shot routine each time. This approach forces your brain to solve a new problem with every swing, just like on the course. Research shows random practice leads to better long-term retention even though it feels harder in the moment.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_practice_games_scoring",
            title: "Play Practice Games to Stay Engaged",
            summary: "Adding scoring and consequences to practice makes it more fun and effective.",
            body: "Create simple challenges like hitting 7 out of 10 shots inside a target area or playing a closest-to-the-pin contest against yourself. Keep score and try to beat your personal best each session. Games add pressure that simulates on-course conditions and prevent the mindless repetition that leads to sloppy habits. Write your scores down so you can track improvement over weeks and months.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_range_session_plan",
            title: "Create a Weekly Practice Plan",
            summary: "Planning your week of practice ensures you address all areas of your game.",
            body: "Dedicate different days to different parts of your game: full swing one day, short game the next, and putting on a third day. Within each session, identify one or two specific goals rather than trying to fix everything at once. Write your plan down before arriving at the facility so you avoid falling into the trap of only hitting driver. A balanced weekly plan accelerates improvement far faster than random, unfocused visits.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_skill_testing_routine",
            title: "Test Your Skills Regularly",
            summary: "Periodic skill tests give you objective data on where your game stands.",
            body: "Set up standardized tests for different parts of your game, such as hitting 20 approach shots and counting how many land on the green. For putting, try the classic 3-foot circle drill where you place four balls around the hole and must make all four before moving back. Record your results and retest every two to four weeks. Objective numbers cut through the guesswork and show you exactly where to focus your limited practice time.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_track_practice_progress",
            title: "Keep a Practice Journal",
            summary: "Writing down what you practiced and learned accelerates your improvement curve.",
            body: "After each session, jot down what you worked on, what felt good, and what still needs attention. Note the specific drills you used and any breakthroughs or struggles. Review your journal before the next session so you pick up exactly where you left off. Over time, your journal becomes a personalized roadmap that reveals patterns and keeps you accountable to your goals.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_practice_with_purpose",
            title: "Define Your Purpose Before Every Session",
            summary: "Knowing exactly why you are practicing prevents wasted time and energy.",
            body: "Before you hit a single ball, ask yourself what specific outcome you want from this session. It might be improving your ball-first contact with irons, or landing more chips within six feet. Having a clear purpose helps you select the right drills and measure whether the session was successful. Leave the range when you have achieved your goal or your focus fades, even if you have balls left.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_indoor_practice_putting",
            title: "Maximize Indoor Putting Practice",
            summary: "A simple putting mat at home can transform your stroke in just minutes a day.",
            body: "Set up a putting mat and practice making 10 putts in a row from three feet to build your stroke confidence. Focus on starting the ball on your intended line rather than worrying about read or speed. Practice your setup alignment by placing a club on the ground parallel to your target line. Even 10 minutes of focused indoor putting three times a week will lower your scores more than an extra hour on the range.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),

        Tip(
            id: "tip_mirror_drill_posture",
            title: "Use a Mirror to Check Your Setup",
            summary: "A full-length mirror provides instant visual feedback on your address position.",
            body: "Stand facing a mirror and check that your spine tilt, knee flex, and arm hang look athletic and balanced. Then turn sideways to verify your ball position, stance width, and forward shaft lean. Compare what you see to photos of tour players in similar positions. Performing this drill a few times a week keeps your fundamentals sharp without needing to hit a single ball.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots", "topping"]
        ),

        Tip(
            id: "tip_mirror_drill_backswing",
            title: "Mirror Check Your Backswing Positions",
            summary: "Rehearsing key backswing positions in a mirror builds muscle memory at home.",
            body: "Using a mirror, slowly take the club to the top of your backswing and pause. Check that your lead arm is relatively straight, the club shaft is on or near the target line, and your shoulders have turned more than your hips. Make small adjustments and repeat the motion until the correct position feels natural. This deliberate slow-motion rehearsal trains your body to find the right slot without the distraction of hitting a ball.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_alignment_stick_target_line",
            title: "Alignment Sticks for Target Line Practice",
            summary: "Alignment sticks remove guesswork and ensure you are aimed correctly every shot.",
            body: "Place one alignment stick on the ground pointing at your target and a second stick parallel to it along your toe line. This simple setup reveals whether you are aimed where you think you are, which is a surprisingly common issue even among skilled players. Practice hitting shots while periodically stepping back to verify your body lines match the sticks. Building this habit at the range trains your eyes to align properly when the sticks are not there on the course.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_alignment_stick_swing_plane",
            title: "Alignment Stick Plane Drill",
            summary: "An angled alignment stick can guide your club onto a better swing plane.",
            body: "Stick an alignment rod into the ground at roughly the angle of your shaft at address, positioned just outside your trail hip. Make slow swings ensuring your club travels below the stick on the backswing and downswing without hitting it. If you strike the stick, your swing is likely too steep or too far outside. This drill provides immediate tactile feedback and is one of the most effective ways to shallow your downswing path.",
            difficulty: .advanced,
            linkedIssueIDs: ["slice", "fat_shots"]
        ),

        Tip(
            id: "tip_impact_bag_drill",
            title: "Use an Impact Bag for Proper Impact Feel",
            summary: "An impact bag teaches your hands and body what a solid strike position feels like.",
            body: "Set up an impact bag or a stack of old towels and make slow swings into it, stopping at the moment of contact. Focus on having your hands ahead of the clubhead, your weight shifted to your lead foot, and your hips slightly open. The resistance of the bag lets you freeze at impact and check these positions without worrying about ball flight. Practicing this drill 20 times before a range session primes your body to find the correct impact position with a real ball.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots", "topping"]
        ),

        Tip(
            id: "tip_slow_motion_swing_drill",
            title: "Practice in Slow Motion",
            summary: "Swinging at half speed helps your brain and body learn new movement patterns.",
            body: "Take your normal stance and make a full swing at roughly 50 percent speed, paying close attention to each phase of the motion. Feel the sequence of your takeaway, the coil at the top, the transition, and the release through impact. Slow-motion swings expose flaws that are invisible at full speed and give you time to make in-swing corrections. Alternate between five slow swings and two full-speed swings to transfer the improved pattern to your normal tempo.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "slice", "hook"]
        ),

        Tip(
            id: "tip_video_self_analysis_basics",
            title: "Film Your Swing for Self-Analysis",
            summary: "A smartphone video reveals swing faults you cannot feel on your own.",
            body: "Set your phone on a tripod at hand height, directly down your target line or facing you from the front. Record several swings and then review them in slow motion, looking for key checkpoints like takeaway path, top-of-backswing position, and impact. Compare your positions to a tour player with a similar body type. Film yourself at least once a month to track changes and ensure the feelings you have match what is actually happening in your swing.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_video_face_on_angle",
            title: "Use the Face-On Camera Angle Effectively",
            summary: "The face-on view reveals weight shift, sway, and low point control issues.",
            body: "Position your camera directly facing you at hip height with the lens aimed at your belt buckle. From this angle you can see whether your head drifts laterally, whether your weight moves correctly toward the target in the downswing, and where the club bottoms out relative to the ball. Draw a vertical line on the screen at your belt buckle position at address and see if your center moves toward the target by impact. This is one of the most diagnostic angles for fixing fat and thin shots.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "topping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_chipping_practice_game",
            title: "The Up-and-Down Challenge",
            summary: "Gamifying your chipping practice builds pressure-proof short game skills.",
            body: "Drop 10 balls around the practice green in different lies and positions, then try to get up and down on as many as possible. Keep a running score and try to beat it next session. This format forces you to adapt to different shots and adds just enough pressure to simulate real course situations. Aim for getting up and down at least 5 out of 10 times as an intermediate goal, and 7 out of 10 as an advanced target.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_putting_gate_drill",
            title: "The Gate Drill for Putter Face Control",
            summary: "Two tees forming a gate train your putter to start the ball on line consistently.",
            body: "Place two tees in the ground just wider than your putter head about six inches in front of the ball on a straight putt. Your goal is to roll the ball through the gate without touching either tee. Start with three-foot putts and work back to six feet as your accuracy improves. This drill provides instant feedback on your face angle at impact, which is the primary factor in whether a putt starts on line.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),

        Tip(
            id: "tip_range_warm_up_sequence",
            title: "Start Every Range Session with Wedges",
            summary: "Beginning with short swings warms your body and grooves solid contact.",
            body: "Hit your first 10 to 15 balls with a sand wedge or pitching wedge using half swings focused on clean contact. Gradually increase the length of your swing and move to longer clubs as your body loosens up. Starting with full driver swings on a cold body is a recipe for poor mechanics and potential injury. The wedge warm-up also sets a tempo baseline that carries through the rest of your session.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_one_club_challenge",
            title: "The One-Club Challenge",
            summary: "Playing practice rounds with a single club teaches creativity and shot shaping.",
            body: "Take only a 7-iron to the course and play nine holes using it for every shot including putting. You will be forced to manufacture high shots, low runners, chips, and creative recoveries. This exercise develops feel and adaptability that you can draw on when you have your full set. Many professionals credit this type of practice with developing their ability to control trajectory and work the ball in different situations.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_pressure_putting_practice",
            title: "Add Pressure to Putting Practice",
            summary: "Practicing putts with consequences prepares you for high-stakes moments on the course.",
            body: "Set up a drill where you must make five three-foot putts in a row, and if you miss you start over from zero. This creates real nerves because as you get to the fourth or fifth putt, the pressure mounts. You can also compete against a friend for added stakes. Learning to perform your putting stroke under self-imposed pressure directly translates to making clutch putts during your round.",
            difficulty: .intermediate,
            linkedIssueIDs: ["three_putting", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_distance_control_ladder",
            title: "The Ladder Drill for Wedge Distances",
            summary: "A simple ladder drill dials in your wedge yardages with precision.",
            body: "Using your most lofted wedge, hit balls to targets at 30, 40, 50, 60, and 70 yards, spending five balls at each distance. Focus on controlling distance through the length of your backswing rather than decelerating through impact. Note the backswing length that produces each distance and commit it to memory. Owning your wedge distances is one of the fastest paths to lower scores because it directly increases your number of birdie and par opportunities.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        // MARK: - Warm Up & Fitness

        Tip(
            id: "tip_pre_round_warm_up_routine",
            title: "Build a Reliable Pre-Round Warm-Up",
            summary: "A consistent warm-up routine prepares your body and mind for the first tee.",
            body: "Arrive at the course at least 30 minutes before your tee time to allow for a proper warm-up. Spend 5 minutes on dynamic stretches, 10 minutes hitting balls starting with wedges and working up to driver, 10 minutes chipping and putting, and 5 minutes on the practice green reading greens. Following the same routine every round removes decision fatigue and builds a sense of familiarity that calms first-tee nerves.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_dynamic_stretching_routine",
            title: "Dynamic Stretches Before You Play",
            summary: "Dynamic stretching warms your muscles and increases range of motion for golf.",
            body: "Perform arm circles, torso rotations, hip circles, and leg swings for about five minutes before picking up a club. These movements raise your core temperature and increase blood flow to the muscles you will use most during your swing. Avoid static stretching before your round, as holding long stretches on cold muscles can actually reduce power output. Save the static stretches for after your round when your muscles are warm.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_flexibility_for_full_turn",
            title: "Improve Flexibility for a Fuller Turn",
            summary: "Greater flexibility allows a bigger shoulder turn, which generates more clubhead speed.",
            body: "Spend 10 minutes each evening stretching your thoracic spine, shoulders, and hips with targeted yoga or mobility exercises. A seated torso rotation stretch and a kneeling hip flexor stretch are particularly beneficial for golfers. Improved flexibility lets you coil more in the backswing without swaying, storing more energy to release through impact. Within a few weeks of consistent stretching, most golfers notice an increase in both swing speed and comfort.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_core_exercises_for_golf",
            title: "Strengthen Your Core for Stability and Power",
            summary: "A strong core is the engine of a powerful, consistent golf swing.",
            body: "Incorporate planks, Russian twists, dead bugs, and bird dogs into your fitness routine three times per week. These exercises build the rotational stability that keeps your swing on plane and the power transfer from your lower body to the club. A weak core forces your arms to compensate, leading to inconsistency and loss of distance. You do not need heavy gym equipment; bodyweight core exercises performed consistently produce significant results for golf.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_shoulder_mobility_drills",
            title: "Shoulder Mobility for Pain-Free Swings",
            summary: "Mobile shoulders allow a full backswing and reduce the risk of injury.",
            body: "Use a resistance band or towel to perform pass-through stretches where you bring the band from in front of your body to behind it with straight arms. Add wall slides where you press your forearms against a wall and slide them up and down to open your chest. Tight shoulders restrict your backswing and often cause compensations like lifting the club with your arms instead of turning your body. Just five minutes of shoulder mobility work before each round pays dividends in both performance and longevity.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_hip_mobility_for_rotation",
            title: "Unlock Your Hips for Better Rotation",
            summary: "Hip mobility is critical for generating power and maintaining posture throughout the swing.",
            body: "Practice the 90-90 hip stretch where you sit on the ground with both legs bent at 90 degrees and rotate from one side to the other. Add deep squats and hip circles to your daily routine. Tight hips prevent you from rotating properly in the downswing, which robs you of power and often leads to early extension where your hips thrust toward the ball. Golfers with mobile hips can maintain their posture through impact and compress the ball more effectively.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_grip_strength_training",
            title: "Build Grip Strength for Club Control",
            summary: "Adequate grip strength helps you control the club without over-squeezing.",
            body: "Use a hand gripper or squeeze a tennis ball for sets of 15 repetitions several times a day. Strong hands and forearms let you hold the club securely with lighter grip pressure, which promotes a freer release through impact. Weak grip strength forces you to squeeze too tightly, creating tension in your arms and shoulders that restricts your swing. As a bonus, improved grip endurance means your hands will not fatigue on the back nine when scores often slip.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_golf_specific_fitness",
            title: "Train Movements, Not Just Muscles",
            summary: "Golf-specific exercises that mimic the swing pattern improve on-course performance.",
            body: "Incorporate medicine ball rotational throws, cable woodchops, and single-leg balance exercises into your workout. These movements train the rotational power, deceleration ability, and balance that directly translate to your golf swing. Generic bodybuilding exercises have less carryover because golf demands power through rotation on a stable base. Train two to three times per week with moderate weight and focus on speed of movement rather than maximum load.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_injury_prevention_golf",
            title: "Prevent Common Golf Injuries",
            summary: "Smart training and warm-up habits keep you playing pain-free season after season.",
            body: "The most common golf injuries affect the lower back, elbows, and wrists. Protect your back by strengthening your glutes and core, which reduces the rotational stress on your spine. Address elbow issues by warming up gradually and avoiding hitting off hard mats repeatedly. If you experience persistent pain, reduce your practice volume and consult a sports physiotherapist before the issue becomes chronic. Taking a few days off is always better than being sidelined for months.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_hydration_on_course",
            title: "Stay Hydrated Throughout Your Round",
            summary: "Even mild dehydration impairs focus, coordination, and decision-making on the course.",
            body: "Drink water before you feel thirsty, aiming for at least a few sips at every tee box. On hot days, bring an electrolyte drink in addition to water to replace the sodium and potassium you lose through sweat. Dehydration as low as two percent of body weight has been shown to reduce concentration and fine motor skills, both of which are essential for putting. Start hydrating the evening before your round and bring more water than you think you will need.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_nutrition_during_round",
            title: "Fuel Your Body During the Round",
            summary: "Smart snacking prevents the energy crash that ruins back-nine performance.",
            body: "Pack easily digestible snacks like bananas, trail mix, granola bars, or a peanut butter sandwich to eat every few holes. Avoid heavy meals or sugary foods that cause energy spikes followed by crashes. Your brain burns significant glucose during four hours of decision-making and focus, and low blood sugar leads to poor club selection and sloppy swings. Eating small amounts frequently keeps your energy steady from the first hole through the eighteenth.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_walking_vs_riding",
            title: "Consider Walking Instead of Riding",
            summary: "Walking the course burns calories, improves rhythm, and gives you time to strategize.",
            body: "Walking provides gentle cardiovascular exercise that keeps your muscles warm and engaged between shots. The natural pace of walking gives you time to assess your next shot, check the wind, and calm any frustration from a bad hole. Riding in a cart can leave your muscles cold and often rushes you to your ball before you have mentally prepared. If the course and your fitness level allow it, walking is both healthier and often leads to better scoring.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        Tip(
            id: "tip_cool_down_after_round",
            title: "Cool Down After Your Round",
            summary: "A simple post-round stretching routine reduces soreness and speeds recovery.",
            body: "Spend five to ten minutes after your round doing gentle static stretches targeting your hamstrings, hip flexors, shoulders, and lower back. Hold each stretch for 20 to 30 seconds and breathe deeply. This is the ideal time for static stretching because your muscles are fully warm and pliable. Cooling down properly reduces next-day stiffness and helps you recover faster if you plan to play again soon.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_glute_activation_pre_round",
            title: "Activate Your Glutes Before Teeing Off",
            summary: "Waking up your glute muscles before your round provides a stable base for every swing.",
            body: "Perform two sets of 10 glute bridges and 10 clamshells on each side before heading to the first tee. Many golfers sit at desks all day, which causes their glutes to become inhibited and fail to fire properly during the swing. When your glutes are not engaged, your lower back and hamstrings take over, reducing power and increasing injury risk. This two-minute activation routine is one of the highest-value warm-up additions you can make.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_wrist_hinge_strength",
            title: "Strengthen Your Wrists for Better Lag",
            summary: "Strong wrists help maintain lag in the downswing and protect against injury.",
            body: "Use a light dumbbell to perform wrist curls, reverse wrist curls, and radial and ulnar deviations three times per week. These exercises strengthen the muscles that control clubface angle and help you maintain the wrist hinge deep into the downswing. Stronger wrists also absorb the shock of impact more effectively, reducing the risk of golfers elbow and wrist tendonitis. Start with a two-pound weight and gradually progress to avoid overloading these small muscle groups.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_single_leg_balance",
            title: "Train Single-Leg Balance for a Stable Finish",
            summary: "Good balance throughout the swing leads to cleaner contact and better accuracy.",
            body: "Practice standing on one leg for 30 seconds at a time, first with eyes open and then with eyes closed for an added challenge. Progress to performing small single-leg squats and single-leg deadlifts. The golf swing finishes with almost all your weight on your lead foot, so single-leg stability directly impacts your ability to hold a balanced finish. If you cannot hold your finish for three seconds after every swing, balance training should be a priority.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_thoracic_spine_rotation",
            title: "Improve Thoracic Spine Rotation",
            summary: "Thoracic mobility is the key to separating your upper and lower body in the swing.",
            body: "Perform the open book stretch by lying on your side with knees bent and rotating your top arm and torso to the opposite side. Add the thread-the-needle stretch on all fours where you reach one arm under your body and then rotate it toward the ceiling. Limited thoracic rotation forces you to sway or lift in the backswing rather than coil. Even five minutes of daily thoracic mobility work can add noticeable degrees to your shoulder turn within a month.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "slice"]
        ),

        Tip(
            id: "tip_rotational_power_med_ball",
            title: "Build Rotational Power with Medicine Ball Throws",
            summary: "Medicine ball throws develop the explosive rotation that translates to clubhead speed.",
            body: "Stand perpendicular to a wall and throw a medicine ball into it using a motion that mimics your golf swing. Start with a light ball of four to six pounds and focus on speed rather than muscle. Perform three sets of eight throws from each side, resting 60 seconds between sets. This exercise trains the fast-twitch muscle fibers responsible for generating clubhead speed and is used by many tour professionals in their fitness programs.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_foam_rolling_recovery",
            title: "Foam Roll for Faster Recovery",
            summary: "Foam rolling after a round releases tight muscles and reduces next-day soreness.",
            body: "Spend five minutes rolling your IT band, quads, glutes, upper back, and calves after each round or practice session. Apply moderate pressure and pause on any spots that feel particularly tight or tender. Foam rolling increases blood flow to the tissue and helps break up adhesions that limit your range of motion over time. Making this a consistent habit keeps your body supple and ready for your next round.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_cardio_endurance_golf",
            title: "Build Cardiovascular Endurance for 18 Holes",
            summary: "Better cardio fitness keeps your concentration sharp through the final holes.",
            body: "Include two to three sessions of moderate cardiovascular exercise per week, such as brisk walking, cycling, or swimming. A round of golf takes four to five hours and covers several miles on foot, so your body needs the aerobic base to sustain focus and physical performance. Fatigue on the back nine is one of the biggest score killers for amateur golfers. Even adding 20-minute walks on non-golf days will improve your stamina and mental clarity through the closing stretch.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        // MARK: - Weather & Conditions

        Tip(
            id: "tip_wind_into_strategy",
            title: "Playing Into a Headwind",
            summary: "A headwind magnifies side spin, so club up and swing smoothly rather than harder.",
            body: "Take one to three extra clubs depending on the wind strength and make a smooth, controlled swing at about 80 percent effort. A harder swing puts more backspin on the ball, which causes it to balloon upward and lose distance in a headwind. Position the ball slightly farther back in your stance to promote a lower, more penetrating flight. Remember that a headwind also exaggerates curves, so a slight fade in calm conditions becomes a big slice in a headwind.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "slice"]
        ),

        Tip(
            id: "tip_wind_downwind_play",
            title: "Taking Advantage of a Tailwind",
            summary: "A tailwind reduces backspin, so expect more roll and plan your landing spot accordingly.",
            body: "With the wind behind you, the ball will fly farther and roll more after landing because the wind reduces effective backspin. Club down one or two clubs and aim to land the ball short of your target to allow for the extra roll. On approach shots, a downwind ball will not check up as quickly on the green, so consider landing it on the front edge. Use the tailwind to your advantage on par fives and long par fours where the extra distance can set up shorter approach shots.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_crosswind_alignment",
            title: "Handling a Crosswind",
            summary: "Aim into the crosswind and let it bring the ball back to your target rather than fighting it.",
            body: "When a strong wind blows across your line, the simplest strategy is to aim upwind and let the wind push the ball back toward the target. If the wind is left to right, aim left of the target and play a straight shot. Trying to curve the ball into a crosswind requires precise execution and often leads to double the trouble if you miss. The amount you aim off depends on wind strength, but starting with 10 to 20 yards of allowance in a moderate crosswind is a good baseline.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_rain_play_adjustments",
            title: "Adjustments for Playing in the Rain",
            summary: "Wet conditions demand extra preparation and smarter club selection.",
            body: "Keep multiple dry towels in a plastic bag inside your golf bag and dry your grips and hands before every shot. Water between the clubface and ball reduces spin dramatically, so expect flier lies from the fairway and less check on approach shots. Club down slightly because the reduced spin often makes the ball fly a similar distance despite the wet conditions. Wear a rain glove or use an all-weather glove for better grip, and keep your spare gloves dry in a sealed bag.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_cold_weather_golf",
            title: "Scoring in Cold Weather",
            summary: "Cold air is denser, which reduces ball flight distance, so plan accordingly.",
            body: "Expect to lose 5 to 10 yards with each club in temperatures below 50 degrees Fahrenheit because cold air is denser and the ball compresses less efficiently. Dress in layers that allow full range of motion and keep hand warmers in your pockets between shots. Use a lower compression ball in cold weather as it will compress more easily off the clubface. Keep your expectations realistic; a cold-weather score a few strokes higher than your warm-weather average is perfectly acceptable.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_hot_weather_tips",
            title: "Stay Sharp in the Heat",
            summary: "High temperatures can sap your energy and concentration if you are not prepared.",
            body: "Start hydrating the night before and drink water at every hole, supplementing with electrolytes after the front nine. Wear light-colored, moisture-wicking clothing and a wide-brimmed hat to protect yourself from the sun. Apply sunscreen before your round and reapply at the turn. Heat exhaustion sneaks up quickly and manifests as poor decision-making and loss of fine motor control before you realize you are overheating. Use an umbrella for shade between shots and take advantage of any shade while waiting on the tee.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_wet_course_conditions",
            title: "Navigating a Wet Course",
            summary: "A soggy course plays longer and rewards aerial approaches over ground game shots.",
            body: "When the fairways are saturated, expect minimal roll on tee shots, effectively making the course play one to two clubs longer. Aim to fly the ball all the way to your target on approach shots because the soft greens will hold better but the ball will plug if it lands in soft turf short. In the rough, wet grass grabs the hosel and closes the face, so grip more firmly and aim slightly right. Adjust your club selection up and commit to cleaner contact, as fat shots are more penalizing in wet conditions.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "lack_of_distance"]
        ),

        Tip(
            id: "tip_firm_fast_conditions",
            title: "Playing Firm and Fast Conditions",
            summary: "Hard fairways and fast greens reward creativity and a ground-game approach.",
            body: "When the course is dried out, take advantage of firm fairways by playing lower trajectory tee shots that bounce and roll for extra distance. On approach shots, land the ball well short of the pin and let it release onto the green rather than flying it to the flag. Use the contours of the green to feed the ball toward the hole. Putting on fast greens requires a shorter stroke with a focus on letting gravity do the work. Embrace the links-style challenge and think creatively about each shot.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_altitude_effects",
            title: "How Altitude Affects Your Distances",
            summary: "Higher elevation means thinner air, which adds significant distance to every club.",
            body: "At 5,000 feet above sea level, expect your ball to travel roughly 10 percent farther than at sea level due to reduced air resistance. At mile-high courses like those in Denver or mountain resorts, a 150-yard shot at sea level may fly 165 yards. Adjust every club in your bag by this percentage and recalibrate your approach shot distances. The effect is less pronounced on shots with less backspin like putts and chips, but full swings and especially high-lofted wedges see the biggest distance gains.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance"]
        ),

        Tip(
            id: "tip_morning_dew_play",
            title: "Dealing with Morning Dew",
            summary: "Dew on the grass affects ball roll, spin, and club-ball interaction in the early hours.",
            body: "Morning dew creates a thin layer of water between the club and ball, producing flier conditions that reduce spin and increase distance on full shots. Expect less check on approach shots and plan to land the ball shorter accordingly. On the greens, dew slows putts significantly, so stroke the ball more firmly than the slope suggests. Dew also makes the rough play heavier because wet grass clings to the clubface more aggressively. These conditions typically burn off by mid-morning, so adjust your strategy as the course dries.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_afternoon_firm_greens",
            title: "Handling Afternoon Firm Greens",
            summary: "Greens that dry out in the afternoon sun require adjusted landing zones and touch.",
            body: "As greens firm up through the afternoon, balls that would have checked at the flag in the morning will bounce and release through the green. Move your target to the front portion of the green and let the ball feed back toward center pins. Use less lofted clubs for bump-and-run approaches when possible rather than relying on high spinning wedge shots. On putts, these firmer surfaces roll faster, so lighten your stroke and pay extra attention to speed control on downhill and sidehill putts.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_wind_club_selection",
            title: "Precise Club Selection in Wind",
            summary: "The right club choice in wind matters more than the perfect swing.",
            body: "As a general rule, add one club for every 10 miles per hour of headwind and subtract one club for every 10 miles per hour of tailwind. For crosswinds, the adjustment depends on whether you are fighting the wind or riding it. Check the tree tops and the flag, not just what you feel at ground level, because wind is almost always stronger at the height your ball flies. Committing fully to the correct club choice and making a smooth swing is far more effective than taking your normal club and trying to muscle it through the wind.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_punch_shot_wind",
            title: "Master the Punch Shot for Windy Days",
            summary: "A low punch shot keeps the ball under the wind for better distance control.",
            body: "Play the ball slightly back of center in your stance, lean the shaft forward, and make a three-quarter backswing with a firm abbreviated follow-through that finishes around chest height. Use one or two more clubs than normal to compensate for the lower trajectory. Keep your hands ahead of the clubhead through impact and resist the urge to flip at the ball. This shot is one of the most valuable weapons in a skilled golfer's arsenal and becomes essential on links-style courses where wind is a constant factor.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_rain_mental_approach",
            title: "Mental Approach in Bad Weather",
            summary: "Accepting that scores will be higher in bad weather frees you to play your best.",
            body: "Before your round in tough conditions, add three to five strokes to your target score to set realistic expectations. Everyone in the field is dealing with the same weather, so the golfer who stays patient and avoids compounding mistakes gains an edge. Focus on keeping the ball in play rather than attacking pins, and remember that bogeys are acceptable scores on difficult days. The players who win in bad weather are rarely the most talented; they are the most disciplined and mentally resilient.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves"]
        ),

        Tip(
            id: "tip_foggy_conditions",
            title: "Playing in Fog and Low Visibility",
            summary: "Reduced visibility demands trust in your yardages and a conservative strategy.",
            body: "When you cannot see the target, rely completely on your GPS device or rangefinder for distances and trust the number. Play to the center of greens rather than at pins you cannot see, and use course markers like 150-yard posts for reference. Hit one extra club on approach shots because the uncertainty of not seeing the landing area tends to make golfers decelerate. Stay patient because fog usually lifts as the morning progresses, and the holes you play after it clears may offer scoring opportunities to make up for the conservative start.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "first_tee_nerves"]
        ),

        // MARK: - Equipment & Fitting

        Tip(
            id: "tip_club_fitting_basics",
            title: "Why Club Fitting Matters",
            summary: "Clubs built for your body and swing produce straighter, more consistent shots.",
            body: "A professional club fitting measures your swing speed, attack angle, ball flight tendencies, and physical dimensions to recommend the optimal shaft, lie angle, loft, and grip size for each club. Off-the-rack clubs are built for an average golfer who may not match your height, hand size, or swing characteristics. Even a single degree of lie angle adjustment can straighten out a persistent push or pull. Invest in a fitting when you are purchasing new clubs, and consider a fitting check every two years as your swing evolves.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_grip_size_matters",
            title: "Get the Right Grip Size",
            summary: "Grip size directly affects your ability to release the club and control the face.",
            body: "A grip that is too large restricts your hand action and tends to leave the face open, promoting a fade or slice. A grip that is too small allows too much hand action and can cause the face to close too quickly, promoting a hook. The correct grip size allows the fingers of your top hand to just barely touch the pad of your palm. Most pro shops can measure your hand and recommend the right size, and regripping is one of the most affordable equipment changes you can make.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_shaft_flex_importance",
            title: "Shaft Flex Affects Your Ball Flight",
            summary: "The right shaft flex matches your swing speed and delivers the clubhead squarely at impact.",
            body: "A shaft that is too stiff for your swing speed will feel dead and tend to produce low shots that miss right because you cannot load the shaft properly. A shaft that is too flexible will feel whippy and tend to produce high shots that spray in both directions. General guidelines suggest regular flex for swing speeds of 80 to 95 miles per hour and stiff flex for 95 to 110 miles per hour. However, tempo and transition force also influence the ideal flex, so a launch monitor fitting provides the most accurate recommendation.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "lack_of_distance"]
        ),

        Tip(
            id: "tip_loft_lie_adjustments",
            title: "Check Your Loft and Lie Angles",
            summary: "Even small loft and lie deviations cause significant distance gaps and directional errors.",
            body: "Over time, repeated use can bend your club's lie angle, and manufacturing tolerances mean your irons may not have arrived with perfectly consistent loft gaps. A lie angle that is two degrees too upright will send the ball left, while two degrees too flat sends it right. Have a clubfitter check your lie angles by putting impact tape on the sole and observing where the mark appears after hitting off a lie board. Getting your lofts and lies standardized is an inexpensive adjustment that often solves mysterious distance gap problems between clubs.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "hook", "slice"]
        ),

        Tip(
            id: "tip_ball_selection_guide",
            title: "Choose the Right Golf Ball",
            summary: "The ball you play has a measurable impact on distance, spin, and feel around the greens.",
            body: "Higher-compression, multi-layer tour balls like the Pro V1 offer more spin control on approach shots and better feel on short game shots, but they require sufficient swing speed to compress properly. Lower-compression two-piece balls maximize distance for slower swing speeds and are more forgiving on off-center hits. Test two or three ball models on the putting green and in the short game area first, as this is where you will notice the biggest performance differences. The best ball for you is the one that fits your swing speed and short game preferences, not necessarily the most expensive option.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "poor_chipping"]
        ),

        Tip(
            id: "tip_wedge_bounce_explained",
            title: "Understanding Wedge Bounce",
            summary: "Bounce angle determines how your wedge interacts with the turf and is critical for clean contact.",
            body: "Bounce is the angle between the leading edge and the lowest point of the sole, and it prevents the club from digging too deeply into the ground. Higher bounce wedges of 12 to 14 degrees are ideal for soft conditions and fluffy sand because they glide through the surface. Lower bounce wedges of 4 to 8 degrees work better on firm turf and tight lies where you need the leading edge closer to the ground. Match your bounce to your typical course conditions and your swing type: steep swingers benefit from more bounce, while shallow swingers can use less.",
            difficulty: .advanced,
            linkedIssueIDs: ["fat_shots", "poor_chipping", "shanks"]
        ),

        Tip(
            id: "tip_putter_fitting_matters",
            title: "Get Your Putter Fitted",
            summary: "A putter that matches your stroke type and setup improves aim and consistency.",
            body: "Putter fitting considers length, lie angle, loft, head design, and balance type to match your natural putting stroke. A face-balanced putter suits a straight-back-straight-through stroke, while a toe-hang putter works better with an arcing stroke. Putter length affects your posture and eye position over the ball, which directly impacts your ability to aim accurately. Since putting accounts for roughly 40 percent of your strokes, investing in a proper putter fitting delivers one of the best returns of any equipment decision.",
            difficulty: .intermediate,
            linkedIssueIDs: ["three_putting"]
        ),

        Tip(
            id: "tip_when_to_upgrade_clubs",
            title: "When to Upgrade Your Clubs",
            summary: "New clubs are worth the investment when your current set limits your improvement.",
            body: "Consider upgrading when your clubs are more than eight to ten years old, when your swing speed has changed significantly, or when you have never been fitted and are playing off-the-rack clubs. Technology improvements in forgiveness, launch conditions, and adjustability are meaningful across a decade of club design. However, buying the newest model every year provides negligible benefit compared to proper fitting and lessons. Spend your budget on a fitting and slightly older model-year clubs rather than the latest release at full price without fitting.",
            difficulty: .beginner,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_club_maintenance_basics",
            title: "Basic Club Maintenance",
            summary: "Clean, well-maintained clubs perform better and last longer.",
            body: "After each round, wipe down your clubheads and shafts with a damp towel to remove dirt and grass. Check your grips monthly for wear, hardening, or slickness and replace them at least once a year if you play regularly. Inspect your grooves for wear and make sure they are clean before every shot. Store your clubs in a cool, dry place and avoid leaving them in a hot car trunk where extreme heat can loosen ferrules and degrade grips. Simple maintenance extends the life of your equipment and ensures consistent performance.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_groove_cleaning_importance",
            title: "Keep Your Grooves Clean",
            summary: "Dirty grooves cannot grip the ball properly, leading to unpredictable spin and distance.",
            body: "Use a groove brush or a pointed tee to clean packed dirt and grass out of your clubface grooves before every shot. Clean grooves channel water and debris away from the contact point, allowing the face to grip the ball and impart the intended spin. This is especially critical on wedge shots where spin control determines whether the ball checks near the hole or rolls through the green. Carry a small groove brush in your bag and make cleaning your face a part of your pre-shot routine.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_check_equipment_regularly",
            title: "Audit Your Equipment Annually",
            summary: "A yearly equipment check catches issues before they cost you strokes.",
            body: "Once a year, take your full set to a club repair shop and have the lofts, lies, shaft conditions, and grips inspected. Check that your driver face has not developed stress fractures and that your wedge grooves still meet legal specifications. Verify that your iron loft gaps are consistent, typically three to four degrees between each club. This annual checkup catches slow deterioration that you might not notice day to day but that quietly adds strokes to your score over time.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_driver_loft_selection",
            title: "Optimize Your Driver Loft",
            summary: "The right driver loft maximizes carry distance based on your swing speed and angle of attack.",
            body: "Many amateurs play too little driver loft, costing themselves distance. If your swing speed is under 95 miles per hour, a driver loft of 10.5 to 12 degrees typically produces the best combination of carry and total distance. Higher lofts reduce sidespin, which means a more forgiving ball flight in addition to more distance. Use a launch monitor fitting to find the loft that produces a launch angle near 12 to 15 degrees with spin rates between 2,000 and 2,500 RPM for optimal results.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "slice"]
        ),

        Tip(
            id: "tip_hybrid_vs_long_iron",
            title: "Replace Long Irons with Hybrids",
            summary: "Hybrids are easier to hit than long irons for the vast majority of golfers.",
            body: "If you struggle with your 3-iron, 4-iron, or even 5-iron, replacing them with equivalent hybrids can immediately improve your consistency and distance on long approach shots. Hybrids have a lower center of gravity and wider sole that help launch the ball higher and are more forgiving on off-center strikes. The higher trajectory also means the ball lands more softly on greens, giving you more stopping power on long approaches. There is no shame in carrying hybrids; many touring professionals have made the switch for clubs they hit infrequently.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance", "topping"]
        ),

        Tip(
            id: "tip_wedge_gap_check",
            title: "Mind Your Wedge Distance Gaps",
            summary: "Evenly spaced wedge lofts prevent distance gaps in the scoring zone.",
            body: "Check that the loft gaps between your wedges are consistent, typically four to five degrees apart. A common setup is pitching wedge at 46 degrees, gap wedge at 50, sand wedge at 54, and lob wedge at 58. If you have a 10-degree gap between your pitching wedge and sand wedge, you are missing an entire club's worth of distance coverage in the most critical scoring range. Map your wedge distances on a launch monitor and adjust your set composition to eliminate any gaps larger than 15 yards between clubs.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        // MARK: - Scoring & Strategy

        Tip(
            id: "tip_scrambling_fundamentals",
            title: "Scrambling Saves Your Score",
            summary: "Getting up and down from off the green is the fastest way to lower scores.",
            body: "Scrambling means saving par even when you miss the green in regulation. Focus on getting your chip or pitch within six feet of the hole, then converting the putt. Practice your short game twice as much as your full swing to see immediate scoring improvements. Tour players scramble successfully over 60% of the time, while most amateurs are below 30%. Dedicating just 20 minutes per practice session to chipping and putting can dramatically close that gap.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_up_and_down_percentage",
            title: "Track Your Up-and-Down Percentage",
            summary: "Knowing your up-and-down stats reveals where to focus your practice time.",
            body: "Start recording whether you successfully get up and down each time you miss a green. Break it down by location: are you worse from bunkers, rough, or tight lies? Most amateurs discover they have a glaring weakness from one specific spot. Once you identify your weakest area, devote focused practice to that shot until your conversion rate improves by at least 10%. This targeted approach is far more effective than general short game practice.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_gir_strategy",
            title: "Greens in Regulation Strategy",
            summary: "Aim for the fat part of the green instead of firing at every pin.",
            body: "Hitting more greens in regulation is the single biggest statistical predictor of lower scores. Instead of aiming at tucked pins, target the center of the green on approach shots. A ball on the middle of the green leaves a manageable two-putt, while a miss toward a tight pin often leads to a bogey or worse. When the pin is accessible with a comfortable yardage, go ahead and attack, but default to center-green on difficult hole locations. This conservative approach can add two or three more greens per round.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_driving_accuracy_focus",
            title: "Fairways Over Distance",
            summary: "Prioritizing driving accuracy leads to lower scores faster than chasing extra yards.",
            body: "Hitting the fairway gives you a clean lie, a clear line to the green, and full control over your approach shot. From the rough, you lose spin control and often cannot reach the green with the club you want. Pick a specific target on each tee shot such as the left edge of the fairway rather than just aiming down the middle. If your driver is unreliable, consider teeing off with a 3-wood or hybrid to keep the ball in play. You will almost always score better from 170 yards in the fairway than 140 yards in deep rough.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook", "lack_of_distance"]
        ),

        Tip(
            id: "tip_scoring_zones",
            title: "Master Your Scoring Zones",
            summary: "Dialing in your wedge distances from 50 to 125 yards is the key to making more birdies.",
            body: "The scoring zone is the range from which you should realistically hit the green and give yourself a birdie look. Map out your exact carry distances for each wedge at full, three-quarter, and half swings. Write these numbers on a card and keep it in your bag so you never have to guess. On the course, commit fully to the club and swing length that matches your number. Eliminating guesswork in these yardages transforms approach shots from stressful moments into confident scoring opportunities.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_approach_shot_strategy",
            title: "Smart Approach Shot Planning",
            summary: "Favor the side of the green that gives you the easiest miss.",
            body: "Before every approach shot, identify where the trouble is around the green. Bunkers, water, thick rough, and steep slopes should be avoided at all costs. Aim your shot so that even a slight miss drifts toward the safe side of the green or a friendly collection area. Factor in your natural ball flight tendency when choosing your aim point. A disciplined approach that misses on the correct side will save you strokes compared to aggressive plays that bring hazards into play.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_when_to_go_for_birdie",
            title: "When to Attack the Pin",
            summary: "Go for birdie when the risk-reward ratio is clearly in your favor.",
            body: "The best time to fire at a pin is when you have a comfortable yardage, the pin is in a central or accessible position, and there is no severe trouble short or behind the green. Par fives you can reach in two and short par fours are natural birdie holes where you should be more aggressive. On harder holes with tucked pins or guarded greens, make par your target and let birdies come as a bonus. Playing this way creates a consistent floor for your score while still allowing you to capitalize on genuine opportunities.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_bogey_avoidance",
            title: "Bogey Avoidance Mindset",
            summary: "Eliminating big numbers matters more than making birdies for most golfers.",
            body: "A double bogey erases a birdie and then some, so keeping big numbers off your card is the fastest route to lower scores. When you are in trouble, take your medicine and pitch back to the fairway rather than attempting a hero shot through the trees. Always think about your next shot position and what leaves you the easiest path to the green. Accept bogey as a good result from a bad situation instead of compounding the problem. This damage-control mindset is what separates single-digit handicaps from the rest.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "shanks"]
        ),

        Tip(
            id: "tip_playing_the_percentages",
            title: "Play the Percentages",
            summary: "Choose the shot you can pull off eight out of ten times, not the one you hit once in a while.",
            body: "Before selecting a club or target, honestly ask yourself how often you execute this exact shot in practice. If the answer is less than half the time, choose a safer alternative. Laying up to your favorite wedge distance is almost always smarter than trying to carry a bunker 220 yards away. Keep a mental inventory of your most reliable clubs and shots and lean on them under pressure. Over 18 holes, consistently choosing high-percentage plays compounds into significantly lower scores.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_handicap_reduction_plan",
            title: "Create a Handicap Reduction Plan",
            summary: "A structured plan targeting your weakest stats accelerates improvement.",
            body: "Review your last ten rounds and identify the stat that costs you the most strokes, whether that is fairways hit, greens in regulation, or putts per round. Devote 60% of your practice time to that one area for a full month before reassessing. Set a specific and measurable goal such as reducing your putts per round from 36 to 33. Track your progress after each round and adjust your plan as weaknesses shift. Golfers who follow a targeted practice plan improve two to three times faster than those who simply hit balls at the range.",
            difficulty: .intermediate,
            linkedIssueIDs: ["three_putting", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_breaking_100",
            title: "Breaking 100 Blueprint",
            summary: "Consistent contact and avoiding penalty strokes are the keys to breaking 100.",
            body: "To break 100, you need to average a bogey on every hole with a few pars mixed in. Focus on making solid contact rather than hitting the ball far, because topped or fat shots waste strokes quickly. Use a club you trust off the tee, even if it is a 7-iron, to keep the ball in play and avoid out-of-bounds penalties. On approach shots, pick a club that reaches the front edge of the green rather than trying to carry it to the pin. Eliminate the blow-up holes and 100 will fall.",
            difficulty: .beginner,
            linkedIssueIDs: ["topping", "fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_breaking_90",
            title: "Breaking 90 Blueprint",
            summary: "Improved short game and smart course management push you into the 80s.",
            body: "Breaking 90 requires averaging bogey golf with at least a few pars per round. At this stage, your full swing is decent enough to advance the ball, so the scoring gains come from within 100 yards. Spend serious time practicing pitch shots from 30 to 80 yards and work on two-putting from 30 feet and beyond. On the course, avoid three-putts by lagging long putts close and take one club more on approaches to ensure you reach the green. Consistent pars on the easier holes will carry your scorecard.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_breaking_80",
            title: "Breaking 80 Blueprint",
            summary: "Precision iron play and clutch putting separate the 70s from the 80s.",
            body: "To shoot in the 70s you need to hit at least eight or nine greens in regulation and convert a handful of birdie putts. Work on controlling your iron distances to within a five-yard window so your approach shots consistently find the putting surface. Your short game must be sharp enough to get up and down at least half the time when you do miss a green. On the greens, develop a reliable lag putting stroke that eliminates three-putts entirely. Breaking 80 is as much about eliminating mistakes as it is about making great shots.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_tournament_preparation",
            title: "Prepare for Tournament Play",
            summary: "A solid pre-tournament routine reduces nerves and sets you up to perform.",
            body: "Play a practice round before tournament day to learn pin positions, green speeds, and trouble spots. Develop a written game plan for each hole noting your target off the tee and your preferred miss on approaches. Arrive at the course at least an hour early to warm up your full swing, short game, and putting in that order. Stick with the shots you have been practicing rather than trying something new under pressure. A well-prepared golfer handles tournament nerves far better than one who wings it.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_match_play_strategy",
            title: "Match Play Strategy",
            summary: "Match play rewards aggression in the right moments and patience everywhere else.",
            body: "In match play you only need to beat your opponent on each hole, not post a low total score. If your opponent is in trouble, play conservatively and let them make the mistake. When you are behind, look for opportunities to apply pressure by attacking pins your opponent will struggle to match. Never give away holes with careless mistakes because conceding easy holes shifts momentum. Remember that the match is not over until someone is up by more holes than remain, so stay patient and competitive.",
            difficulty: .intermediate,
            linkedIssueIDs: ["first_tee_nerves", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_scramble_format_tips",
            title: "Best Ball and Scramble Strategy",
            summary: "In team formats, coordinate strategy so at least one player is always in a safe position.",
            body: "In a scramble, the first player should hit a safe, conservative tee shot to guarantee the team has a playable ball in the fairway. Once a safe shot is secured, the remaining players can take more aggressive lines to maximize distance or attack tucked pins. On putts, have the first putter aim for the center of the hole to read the break for teammates. Assign roles based on each player's strengths, letting your best putter go last and your longest hitter swing freely. Communication and a clear strategy turn an average team into a competitive one.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "three_putting"]
        ),

        Tip(
            id: "tip_par_five_scoring",
            title: "Turn Par Fives Into Scoring Holes",
            summary: "Smart layup positioning on par fives creates more birdie opportunities than going for the green in two.",
            body: "Unless you can comfortably reach a par five green in two shots with a clean lie and no trouble guarding the front, lay up to your best wedge distance. Most golfers score better from a perfect 80-yard wedge shot than from a 230-yard fairway wood that brings hazards into play. Pick a specific target for your layup rather than just knocking it down there somewhere. A well-positioned third shot gives you a realistic birdie putt, while a poor second shot gamble often leads to bogey or worse. Make par fives your most reliable scoring holes by playing them smart.",
            difficulty: .intermediate,
            linkedIssueIDs: ["lack_of_distance", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_par_three_consistency",
            title: "Par Three Consistency",
            summary: "On par threes, making par consistently is more valuable than occasional birdies followed by big numbers.",
            body: "The biggest mistake on par threes is club selection based on ego rather than reality. Take enough club to reach the center of the green, not the number that only gets there with a perfect strike. Favor the safe side of the green away from bunkers and water, and accept a longer putt over a short-sided position next to trouble. On longer par threes, treat a bogey as an acceptable result rather than forcing a risky shot at the pin. Consistent par-three play often separates low handicappers from mid handicappers.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_first_hole_strategy",
            title: "First Hole Strategy",
            summary: "A smart, conservative first-hole plan calms your nerves and sets the tone for the round.",
            body: "The first tee shot creates more anxiety than any other shot in golf, so simplify your plan. Hit the club you are most confident with off the tee, even if it leaves a longer approach. Aim for the widest part of the fairway and focus only on making smooth contact. On your approach, target the middle of the green and accept a two-putt par as a great start. A calm, controlled opening hole builds momentum that carries through the front nine.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves", "slice"]
        ),

        Tip(
            id: "tip_finishing_strong",
            title: "Finish Your Round Strong",
            summary: "Maintaining focus on the closing holes prevents wasted strokes at the end of a round.",
            body: "Many golfers lose concentration on the final three or four holes and give back strokes they worked hard to earn. Stay hydrated and eat a light snack around the 13th or 14th hole to maintain energy and focus. Stick to your game plan and resist the temptation to take unnecessary risks to post a lower number. If you are playing well, trust the process that got you there rather than changing strategy. A strong finish builds confidence that carries into your next round.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "three_putting"]
        ),

        Tip(
            id: "tip_course_management_wind",
            title: "Scoring in the Wind",
            summary: "Adjusting your strategy on windy days prevents inflated scores.",
            body: "Wind amplifies every mistake, so club down and swing easier to keep the ball under control. Into the wind, take two extra clubs and make a smooth three-quarter swing rather than swinging harder with your normal club. Downwind, use less club and let the breeze carry the ball, but account for reduced spin and more rollout on the green. On crosswind holes, aim to use the wind rather than fight it, starting the ball on the upwind side and letting it drift to your target. Accepting that windy rounds will produce higher scores keeps your mindset positive.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        // MARK: - Rules & Etiquette

        Tip(
            id: "tip_out_of_bounds_rules",
            title: "Understanding Out of Bounds",
            summary: "Knowing your options when a ball goes out of bounds saves time and confusion.",
            body: "Out of bounds is marked by white stakes or white lines and means your ball is no longer in play. The penalty is stroke and distance, meaning you must replay the shot from where you last played and add one penalty stroke. Under the local rule adopted by many courses, you may instead drop in the fairway nearest to where the ball crossed the OB line for a two-stroke penalty. Always check the scorecard to see if this local rule is in effect at your course. Hitting a provisional ball when you suspect OB will save time and keep pace of play moving.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_lateral_hazard_procedures",
            title: "Lateral Hazard Relief Options",
            summary: "Red-staked penalty areas give you multiple options for dropping your ball.",
            body: "When your ball enters a red penalty area, you have three main options. You can play the ball as it lies if you can find it and a shot is possible. You can take stroke-and-distance relief by replaying from the previous spot with a one-stroke penalty. Or you can drop within two club lengths of where the ball last crossed the edge of the penalty area, no closer to the hole, for one penalty stroke. There is also a back-on-the-line option where you drop anywhere on the line between the hole and where the ball crossed. Understanding all your options helps you choose the one that gives you the best next shot.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_provisional_ball",
            title: "When to Hit a Provisional Ball",
            summary: "A provisional ball saves time and keeps play moving when your shot might be lost or out of bounds.",
            body: "Whenever you think your ball may be lost outside a penalty area or out of bounds, announce that you are hitting a provisional ball before making the stroke. Use the phrase 'I am playing a provisional' clearly so your playing partners hear it. If you find your original ball in bounds, you must abandon the provisional and play the original. If the original is lost or out of bounds, your provisional becomes the ball in play with a stroke-and-distance penalty. Failing to announce a provisional means your second ball automatically becomes the ball in play.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_free_drop_situations",
            title: "Know When You Get Free Relief",
            summary: "Several common situations on the course entitle you to a free drop without penalty.",
            body: "You receive free relief from immovable obstructions like cart paths, sprinkler heads, and permanent stakes. You also get free relief from ground under repair marked by white lines or GUR signs. To take relief, find your nearest point of complete relief that is not closer to the hole, then drop within one club length of that point. Abnormal course conditions such as temporary standing water after rain also qualify for free relief. Learning to recognize these situations prevents you from taking unnecessary penalty strokes or playing from unfavorable lies.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_cart_path_relief",
            title: "Taking Cart Path Relief",
            summary: "Proper cart path relief requires dropping on the correct side and within one club length.",
            body: "When your ball rests on a cart path or the path interferes with your stance or swing, you are entitled to free relief. Find the nearest point of complete relief where the path no longer affects your lie, stance, or swing area, and that point must not be closer to the hole. Drop within one club length of that nearest point, and the ball must come to rest within that one club-length area. Be aware that the nearest point of relief might be on the side you do not prefer, such as in bushes or thick rough. You must take relief from the nearest point even if the other side of the path seems more appealing.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact"]
        ),

        Tip(
            id: "tip_unplayable_lie_options",
            title: "Unplayable Lie Options",
            summary: "Declaring your ball unplayable gives you three relief options for a one-stroke penalty.",
            body: "You can declare your ball unplayable anywhere on the course except in a penalty area. Your first option is stroke-and-distance relief, replaying from where you last played. Your second option is to drop within two club lengths of where the ball lies, no closer to the hole. Your third option is back-on-the-line relief, dropping anywhere on the line between the hole and the ball's position. Choose the option that gives you the most favorable next shot, which is not always the one closest to the green. In a bunker, two of the three options require you to drop within the bunker unless you take a two-stroke penalty to drop outside.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "fat_shots"]
        ),

        Tip(
            id: "tip_pace_of_play",
            title: "Maintaining Good Pace of Play",
            summary: "Playing at a reasonable pace makes the round enjoyable for everyone on the course.",
            body: "Good pace of play means keeping up with the group ahead of you, not just staying ahead of the group behind. Start preparing for your shot while others are playing by selecting your club, reading the wind, and visualizing the shot. Limit your pre-shot routine to no more than 30 seconds once it is your turn. If you fall behind, pick up the pace by walking faster between shots and being ready to hit as soon as it is safe. A four-hour round is achievable for most groups when everyone stays focused and efficient.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves"]
        ),

        Tip(
            id: "tip_ready_golf",
            title: "Play Ready Golf",
            summary: "Hitting when ready rather than strictly by order speeds up play for everyone.",
            body: "Ready golf means the player who is prepared to hit goes first, regardless of who is farthest from the hole. If your playing partner is searching for a ball or waiting for a group ahead to clear, and you have a safe shot available, go ahead and play. On the tee, if the player with honors is not ready, step up and hit your drive. This approach can easily save 15 to 20 minutes per round without any loss of etiquette. Just make sure the player you are hitting ahead of is aware and that your shot will not endanger anyone.",
            difficulty: .beginner,
            linkedIssueIDs: ["first_tee_nerves"]
        ),

        Tip(
            id: "tip_repair_pitch_marks",
            title: "Always Repair Your Pitch Marks",
            summary: "Fixing ball marks on the green keeps the putting surfaces smooth for everyone.",
            body: "Every approach shot that lands on the green leaves an indentation called a pitch mark or ball mark. Use a divot repair tool to push the edges of the mark toward the center, then smooth it flat with your putter. A properly repaired pitch mark heals in one to two days, while an unrepaired one takes weeks and creates a bumpy surface. Make it a habit to fix your mark plus one extra whenever you walk onto a green. This small act of stewardship keeps greens in top condition and earns respect from every golfer who follows you.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),

        Tip(
            id: "tip_raking_bunkers",
            title: "Raking Bunkers Properly",
            summary: "Leaving a bunker smooth and raked ensures a fair lie for the next player.",
            body: "After playing your bunker shot, enter and exit the bunker from the low side nearest your ball to minimize footprints. Rake the area where you played your shot first, then work your way out raking your footprints as you go. Pull the rake in smooth, even strokes toward the center of the bunker rather than pushing sand to the edges. Leave the rake outside the bunker with the handle parallel to the line of play, or inside the bunker if that is the course's preference. A well-raked bunker shows respect for the course and your fellow golfers.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping"]
        ),

        Tip(
            id: "tip_marking_your_ball",
            title: "Marking Your Ball on the Green",
            summary: "Properly marking and lifting your ball on the green prevents penalties and confusion.",
            body: "Place your ball marker, typically a small coin or flat disc, directly behind your ball before lifting it. Behind means on the side of the ball farthest from the hole. If your marker is in another player's putting line, offer to move it one or two putter head lengths to the side, and remember to move it back before replacing your ball. When replacing your ball, set it down directly in front of the marker and then pick up the marker. Use a distinctive marker so you can easily identify it as yours on a crowded green.",
            difficulty: .beginner,
            linkedIssueIDs: ["three_putting"]
        ),

        Tip(
            id: "tip_embedded_ball_rule",
            title: "Embedded Ball Relief",
            summary: "A ball plugged in its own pitch mark in the general area qualifies for a free drop.",
            body: "Under the Rules of Golf, if your ball is embedded in its own pitch mark in the general area, which includes the fairway and rough but not bunkers, you get free relief. Mark the ball's position, lift it, and drop it within one club length of the spot directly behind where the ball was embedded, no closer to the hole. The ball must be embedded in the general area and must be in its own pitch mark, not just sitting in a depression. This rule does not apply in a penalty area or a bunker unless a local rule states otherwise. Knowing this rule prevents you from playing a nearly impossible shot from a plugged lie.",
            difficulty: .intermediate,
            linkedIssueIDs: ["fat_shots", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_lost_ball_procedure",
            title: "Lost Ball Procedure",
            summary: "You have three minutes to search for a lost ball before it is officially declared lost.",
            body: "Under the current Rules of Golf, you have a three-minute search period starting when you or your caddie begins searching for the ball. If the ball is not found within three minutes, it is lost and you must proceed under stroke and distance, returning to where you last played with a one-stroke penalty. This is why hitting a provisional ball when your shot might be lost is so important. Start your search promptly and ask playing partners to help, but be honest when the time is up. Carrying a visible ball marker color and marking your ball with a unique identification mark helps speed up the process.",
            difficulty: .beginner,
            linkedIssueIDs: ["slice", "hook"]
        ),

        Tip(
            id: "tip_water_hazard_yellow_stakes",
            title: "Yellow Penalty Area Procedures",
            summary: "Yellow-staked penalty areas offer two relief options plus the choice to play the ball as it lies.",
            body: "When your ball enters a yellow penalty area, typically a water hazard crossing the fairway, you can play it as it lies without penalty if possible. If you choose to take relief, you have two options at the cost of one penalty stroke. You can go back to where you last played under stroke and distance, or you can keep the point where the ball last crossed the penalty area edge between you and the hole and drop anywhere on that line going back as far as you like. Unlike red penalty areas, there is no lateral two-club-length drop option with yellow stakes. Choose the option that leaves you the best angle and distance for your next shot.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "hook", "topping"]
        ),

        // MARK: - Specialty Shots

        Tip(
            id: "tip_intentional_fade",
            title: "How to Hit an Intentional Fade",
            summary: "A controlled fade curves gently left to right and is one of the most reliable shots in golf.",
            body: "To hit an intentional fade, aim your body and clubface slightly left of your target for a right-handed golfer. Open the clubface a few degrees relative to your swing path at address, which imparts left-to-right sidespin. Swing along your body line, which should be pointed left, while keeping the face aimed at or just left of the target. The ball will start left and curve back toward your target. Keep the swing smooth and avoid trying to hold off the release, as the open face at impact does the work for you.",
            difficulty: .intermediate,
            linkedIssueIDs: ["hook", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_intentional_draw",
            title: "How to Hit an Intentional Draw",
            summary: "A controlled draw curves right to left and adds distance with a penetrating ball flight.",
            body: "Set up with your body aligned slightly right of the target and close the clubface just a degree or two relative to your swing path. Swing along your body line to the right while the slightly closed face promotes right-to-left spin. Feel as though your right forearm rotates over your left through impact to help close the face naturally. The ball should start right of the target and draw back toward it. Practice with a 7-iron first to feel the draw shape before applying the technique to longer clubs.",
            difficulty: .intermediate,
            linkedIssueIDs: ["slice", "lack_of_distance"]
        ),

        Tip(
            id: "tip_knockdown_shot",
            title: "The Knock-Down Shot",
            summary: "A low, controlled punch shot flies under the wind and checks up quickly on the green.",
            body: "Take one or two clubs more than normal and grip down an inch on the handle. Position the ball slightly back of center in your stance and press your hands forward at address so the shaft leans toward the target. Make a smooth three-quarter backswing and focus on a low, abbreviated follow-through that finishes around chest height. The forward shaft lean and shorter swing deloft the club, producing a lower, more penetrating ball flight. This shot is invaluable on windy days and when you need to keep the ball below tree branches.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_high_soft_lander",
            title: "Hit a High Soft Landing Shot",
            summary: "A high, soft approach shot lands gently and stops quickly on firm greens.",
            body: "Use your most lofted wedge and position the ball slightly forward in your stance, just inside your lead heel. Open the clubface a few degrees at address and maintain that loft through impact by keeping your hands from getting too far ahead of the ball. Make a full swing with a high finish, letting the club release fully to maximize launch angle. The combination of loft and a slightly ascending strike sends the ball high with plenty of backspin. This shot is perfect for elevated greens, tight pin positions, and firm conditions where a standard trajectory would roll out too far.",
            difficulty: .advanced,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_bump_and_run_hybrid",
            title: "Bump and Run with a Hybrid",
            summary: "A hybrid chip rolls the ball along the ground like a putt and is easier than a traditional chip for many golfers.",
            body: "Set up as you would for a putt with the ball in the center of your stance and your weight slightly favoring your front foot. Grip down to the bottom of the handle and stand closer to the ball so the hybrid sits more upright. Use your putting stroke to bump the ball forward, letting the low loft and rounded sole glide through the turf. The ball will pop up briefly then roll out like a putt, making distance control very predictable. This shot works best from tight lies and the fringe when there is plenty of green between you and the hole.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_bellied_wedge",
            title: "The Bellied Wedge Shot",
            summary: "Using the leading edge of your wedge like a putter is a clever option when the ball sits against the fringe.",
            body: "When your ball rests against the collar of rough where a putter would catch the grass behind it, try the bellied wedge. Address the ball with your sand or lob wedge and align the leading edge with the equator of the ball. Use your normal putting grip and stroke, striking the middle of the ball with the sharp bottom edge of the wedge. The ball will roll out smoothly like a putt without getting caught in the fringe grass. Practice this shot on the putting green to develop a feel for distance, as it rolls slightly faster than a normal putt.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "three_putting"]
        ),

        Tip(
            id: "tip_texas_wedge",
            title: "The Texas Wedge: Putting From Off the Green",
            summary: "Putting from the fairway or fringe is often the safest shot when conditions allow.",
            body: "When the ground between your ball and the green is tight, flat, and free of heavy rough, consider using your putter from off the green. The main advantage is that a putt almost never produces a disastrous result, while a chip can be thinned or chunked. Hit the putt slightly harder than you would from the same distance on the green to account for the slower surface of the fringe or fairway. Read the slope and grain of the ground between you and the green just as you would on a normal putt. This shot is especially effective on links-style courses and in windy conditions where a chip could balloon unpredictably.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_chip_with_three_wood",
            title: "Chipping with a 3-Wood",
            summary: "A 3-wood chip from tight lies around the green produces a reliable, low-rolling shot.",
            body: "This technique works similarly to the hybrid bump and run but produces even more roll. Grip down to the steel portion of the shaft and stand close to the ball with an upright posture. Place the ball in the center or slightly back of center in a narrow stance. Use a pendulum putting motion with minimal wrist action, letting the wide sole of the 3-wood glide across the turf. The ball comes off low and rolls predictably, making it an excellent choice when you have a lot of green to work with and want to eliminate the risk of a mis-hit chip.",
            difficulty: .beginner,
            linkedIssueIDs: ["poor_chipping", "shanks"]
        ),

        Tip(
            id: "tip_low_spinner",
            title: "The Low Spinning Wedge Shot",
            summary: "A low-trajectory wedge that checks and spins back requires clean contact and the right conditions.",
            body: "Use a fresh, clean-grooved wedge and a premium ball with a urethane cover for maximum spin. Position the ball slightly back of center with your hands well ahead of the ball at address to deloft the club. Strike the ball first with a descending blow, compressing it against the face before the club contacts the turf. The key is clean grooves meeting a clean ball with maximum friction. This shot works best from a tight fairway lie into a green that receives the ball softly, and it is nearly impossible from deep rough because grass gets between the face and ball.",
            difficulty: .advanced,
            linkedIssueIDs: ["inconsistent_contact", "poor_chipping"]
        ),

        Tip(
            id: "tip_flop_shot",
            title: "How to Hit a Flop Shot",
            summary: "The flop shot launches the ball high with minimal roll and is essential for short-sided situations.",
            body: "Open your lob wedge face until it points almost at the sky and align your body well left of the target. Position the ball forward in your stance, just inside your lead foot. Make an aggressive swing along your body line, sliding the club under the ball with the bounce of the club gliding along the turf. The ball will pop up nearly straight in the air and land softly with very little roll. This is a high-risk, high-reward shot that demands practice, so avoid it in competition until you can execute it reliably on the practice green.",
            difficulty: .advanced,
            linkedIssueIDs: ["poor_chipping", "inconsistent_contact"]
        ),

        Tip(
            id: "tip_stinger_low_punch",
            title: "The Stinger: Low Punch with a Long Iron",
            summary: "A stinger is a low, boring tee shot that cuts through wind and maximizes roll.",
            body: "Use a 2-iron, 3-iron, or driving iron and tee the ball low, just barely off the ground. Position the ball one ball-width back of your normal iron position and set your hands ahead of the clubhead at address. Make a controlled three-quarter backswing and focus on driving the hands low through impact with a curtailed follow-through that finishes around belt height. The ball should launch low with a strong, penetrating flight that runs out significantly after landing. This shot is invaluable on windy days, tight driving holes, and links-style courses where control matters more than carry distance.",
            difficulty: .advanced,
            linkedIssueIDs: ["lack_of_distance", "slice"]
        ),

        Tip(
            id: "tip_gap_wedge_mastery",
            title: "Gap Wedge Mastery",
            summary: "Your gap wedge fills the critical distance between your pitching wedge and sand wedge.",
            body: "The gap wedge, typically lofted between 50 and 52 degrees, covers the yardage that would otherwise be a no-man's land between your pitching wedge and sand wedge. Dial in three specific distances with your gap wedge: a full swing, a three-quarter swing, and a half swing. Knowing each of these numbers precisely eliminates guesswork on approach shots from 80 to 110 yards. Practice hitting your gap wedge to specific targets at the range rather than just making generic swings. The gap wedge is also a versatile chipping club that produces a mid-trajectory shot with moderate roll.",
            difficulty: .intermediate,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

        Tip(
            id: "tip_fifty_yard_shot",
            title: "Master the 50-Yard Shot",
            summary: "The 50-yard pitch is one of the most awkward distances in golf, but a reliable technique makes it scoreable.",
            body: "Many amateurs struggle at 50 yards because it is too far for a chip and too close for a full wedge swing. Use your sand wedge or gap wedge with the ball centered in your stance and your feet slightly narrower than shoulder width. Make a smooth backswing to about hip height, keeping your wrists firm and your lower body quiet. Accelerate smoothly through the ball and let the follow-through mirror the length of the backswing. The key is maintaining consistent tempo and resisting the urge to decelerate through impact, which causes fat and thin contact.",
            difficulty: .intermediate,
            linkedIssueIDs: ["poor_chipping", "fat_shots"]
        ),

        Tip(
            id: "tip_hundred_yard_shot",
            title: "Dial In Your 100-Yard Shot",
            summary: "The 100-yard approach is your best chance to hit it close, so commit to owning this distance.",
            body: "Determine which club and swing produce a reliable 100-yard carry for your game. For many golfers this is a smooth pitching wedge or a full gap wedge. Once you know the combination, practice it repeatedly until you can land the ball within a 10-yard circle of your target. On the course, when you have exactly 100 yards, commit fully to your rehearsed swing without any last-second adjustments. Owning this one distance gives you a reliable target for layup shots on par fives and a go-to approach that builds confidence across your entire game.",
            difficulty: .beginner,
            linkedIssueIDs: ["inconsistent_contact", "lack_of_distance"]
        ),

    ]
}
