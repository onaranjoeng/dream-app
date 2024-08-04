import SwiftUI

// Struct for community dreams accessible throughout the app
struct CommunityDream: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var author: String
    var datePosted: Date
}

// Background view with a starry night sky
struct StarryNightBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Create two layers of stars, each layer contains multiple stars
                // The second layer starts its animation with a delay, creating a continuous effect
                ForEach(0..<2, id: \.self) { layer in
                    StarLayerView(numberOfStars: 100, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                        .offset(y: layer == 0 ? 0 : -geometry.size.height)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct StarLayerView: View {
    let numberOfStars: Int
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let starPositions: [CGPoint]
    
    init(numberOfStars: Int, screenWidth: CGFloat, screenHeight: CGFloat) {
        self.numberOfStars = numberOfStars
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.starPositions = (1...numberOfStars).map { _ in CGPoint(x: CGFloat.random(in: 0...screenWidth), y: CGFloat.random(in: 0...screenHeight)) }
    }
    
    var body: some View {
        ForEach(0..<numberOfStars, id: \.self) { index in
            StarAnimationView(screenHeight: screenHeight)
                .position(starPositions[index])
                .animation(
                    Animation.linear(duration: 10).repeatForever(autoreverses: false).delay(Double(index) * 0.1),
                    value: UUID()
                )
        }
    }
}

struct StarAnimationView: View {
    let screenHeight: CGFloat
    @State private var opacity: Double = 0.3 // Initial opacity for the dim state
    @State private var startY: CGFloat = 0.0
    @State private var endY: CGFloat = 0.0

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 2, height: 2)
            .opacity(opacity)
            .position(x: UIScreen.main.bounds.width * CGFloat.random(in: 0...1), y: endY)
            .onAppear {
                // Set initial and end positions for the Y axis
                startY = -10 // Start slightly above the top edge to not be visible initially
                endY = startY
                
                // Falling animation setup
                let animationDuration: Double = 10
                
                // Opacity animation setup
                withAnimation(Animation.easeInOut(duration: animationDuration / 2).repeatForever(autoreverses: true)) {
                    opacity = 1.0 // Fade to fully visible
                }
                
                // Start the falling animation
                Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { _ in
                    withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                        endY = screenHeight + 10 // End slightly below the bottom edge to ensure it's fully out of view
                    }
                }
            }
    }
}




// Component to display dreams, using the CommunityDream struct


struct UnifiedDreamView: View {
    let dream: CommunityDream
    var isExpandable: Bool = false
    @State private var isExpanded = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // User profile picture
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.gray.opacity(0.5)))
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(dream.author)
                        .font(.headline)
                        .foregroundColor(.orange)
                        .shadow(radius: 1)
                    
                    Text(dateFormatter.string(from: dream.datePosted))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Moon icon in the top right corner
                Image(systemName: "moon.stars.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.yellow)
                    .shadow(radius: 3)
            }
            
            Text(dream.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 1)
            
            Text(dream.content)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(isExpandable && !isExpanded ? 3 : nil)
                .padding(.top, 2)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.orange.opacity(0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
        .onTapGesture {
            if isExpandable {
                withAnimation { isExpanded.toggle() }
            }
        }
    }
}



struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Search...", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if !text.isEmpty {
                        Button(action: { self.text = "" }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
    }
}
