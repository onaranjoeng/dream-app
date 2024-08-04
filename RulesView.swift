
                       
import SwiftUI

struct RulesView: View {
    var players: [String]
    @State private var currentRuleIndex = 0
    @State private var currentRule: String = ""
    @State private var backgroundColor = Color.blue
    @State private var shuffledRules: [String] = []
    
    private let backgroundColors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .yellow, .gray]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.5), value: backgroundColor)
                
                if geometry.size.width < geometry.size.height {
                    // User is likely in portrait mode - suggest rotating the device
                    VStack {
                        if geometry.size.width < geometry.size.height {
                                               // This VStack could be conditionally shown or hidden based on orientation
                                               Text("For the best experience, rotate your device to landscape.")
                                                   .foregroundColor(.white)
                                                   .font(.headline)
                                                   .padding()
                                                   .multilineTextAlignment(.center)
                                                   .transition(.opacity)
                                           }
                                           
                                           Spacer()
                                           Text(currentRule)
                                               .foregroundColor(.white)
                                               .font(.title)
                                               .fontWeight(.bold)
                                               .padding()
                                               .multilineTextAlignment(.center)
                                               .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                                           Spacer()
                    }
                    .onTapGesture {
                        goToNextRule()
                    }
                }
            }
        }
        .onAppear {
            shuffledRules = [
                "Thumb Master: {player} is now the Thumb Master until someone else draws this rule. They can discreetly place their thumb on the table at any time; the last person to place their thumb on the table drinks.",
                    "Story Time - Start a story with one sentence. Each person adds a sentence. First to hesitate or break the story flow drinks.",
                        "Categories - Pick a category (e.g., car brands). Go around in a circle naming items in the category until someone repeats or can't think of one. They drink.",
                    "Rhyme Time - Say a word. The next person must say a word that rhymes. Continue until someone fails. They drink.",
                        "The Question Master - Whoever draws this is the Question Master. If they ask you a question and you answer without asking one back, you drink.",
                        "The Rule Maker - Make a rule (e.g., no swearing). Anyone who breaks it drinks.",
                                 "Waterfall - Everyone starts drinking. You can't stop until the person before you stops.",
                                 "Coin Flip of Fate - {player}Flip a coin. Heads, you give out two drinks. Tails, you take two drinks. If you cant find a coin in 60 seconds, kill your drink",
                                 "Trivia Challenge - Ask a trivia question. First to shout the answer gives out a drink; wrong answers take a drink.",
                                 "Accent Challenge - Speak in an accent chosen by the group for a round. Fail, and you drink.",
                                 "Dance Off - Two players have a dance-off. Loser drinks.",
                                 "Karaoke Challenge - Sing a song chosen by the group. Fail to impress, and you drink.",
                                 "Guess the Song - Play the first few seconds of a song. First to guess it right gives out a drink; wrong guess, take a drink.",
                                 "Impressions - Do an impression of someone famous. Fail to impress, you drink.",
                                 "Dare or Drink - Choose a dare from the group or drink.",
                                 "T-Rex Arms - Keep your elbows at your sides like a T-Rex for the next round. Forget, and you drink.",
                                 "Flip Cup Expert - If you're the first to flip your cup successfully, give out three drinks.",
                                 "Social Media Roulette - Scroll through your photos blind and select one randomly. Post it or drink.",
                                 "Pass the Phone - Each player types one word to form a story in a text message. The last person before the message is sent drinks.",
                                 "If someone shotguns, everyone has to kill half of their drink",
                                 "If someone volunteers to take a shot, they can choose someone to do it with them. If there is no hard liquor, everyone drink",
                                 "Most Likely To get arrested, if its you, drink",
                                 "If you have a DUI, dont drive tonight, but you have to shotgun",
                                 " Most Likely To blackout tonight, if its you, drink",
                                 "Most Likely To lose a beauty contest, if its you, drink",
                                 "Most Likely To fall asleep on the floor, if its you, drink",
                                 "Most Likely To blame not going pro on an injury, if its you, drink",
                                 "Whoever chose to play this game, give out 5 drinks",
                                 "{player} must tell a joke; if no one laughs, they drink.",
                                 "Rock, Paper, Scissors Showdown: {player} and {player} play rock, paper, scissors. The loser drinks.",
                                 "Rhyme Time: {player} says a word, and players go around in a circle rhyming with it. First person to fail or repeat a word drinks.",
                                 "Question Master: {player} becomes the Question Master. Anyone who answers their questions directly drinks until someone else draws this rule.",
                                 "Honestly I cant come up with any more rules. Everyone drink",
                                 "If someone is leaving in the next 30 minutes, give out 5 drinks",
                                 "Whoever has the most unopened snapchats, kill your drink, then answer your damn phone",
                                 "{player} has to guess the total number of immediate family members {player} has, if they are right, give out 5 sips, if they are wrong, take them",
                                 "{player} has to spell the person to their rights last name, or kill their drink",
                                 "if there are a deck of cards handy, everyone guess a card number, and then flip the top card. however far off you are, drink that many sips. If youre too lazy to get cards, everyone drink",
                                 "{player}, compliment the person to your right, and give out 3 sips, or insult them, and take 3",
                                 "If anyones name starts with the letters M, K, L, or C, drink. if no ones does, everyone drink",
                                 "If you are on your first drink of the night, finish it and open a new one.",
                                 "If your shoes are off, take 3 sips, if your socks are off too, finish your drink",
                                 "Whoever has nicotine, take 8 sips, if you throw it out, give out a shotgun or shot",
                                 "If you’re high, take 4 sips",
                                 "CHUG TIME!!! Last one to finish their drink has to take a shot or shotgun. (I bet its {player)",
                                 "If you're a dude drinking a seltzer, finish it, and please just drink a beer",
                                 "if you are drinking hard liquor, give out 3 sips, you dont need anymore",

            ].shuffled()
            nextRule()
        }
    }

    private func nextRule() {
        guard !players.isEmpty, !shuffledRules.isEmpty else {
            currentRule = "Add some players to start!"
            return
        }
        
        let nextIndex = (currentRuleIndex + 1) % shuffledRules.count
        let rule = shuffledRules[nextIndex]
        let randomPlayer = players.randomElement() ?? "Someone"
        let nextRule = rule.replacingOccurrences(of: "{player}", with: randomPlayer)
        
        withAnimation {
            currentRuleIndex = nextIndex
            currentRule = nextRule
            backgroundColor = backgroundColors[currentRuleIndex % backgroundColors.count]
        }
    }

    private func goToNextRule() {
        withAnimation {
            nextRule()
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView(players: ["Alice", "Bob", "Charlie"])
    }
}
