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
    ]
}
