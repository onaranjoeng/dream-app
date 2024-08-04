import SwiftUI

struct WelcomeView: View {
    @State private var isShowingLoginView = false

    var body: some View {
        NavigationView {
            ZStack {
                StarryNightBackground() // Assuming this is now accessible from Shared Components
                    .edgesIgnoringSafeArea(.all)

                TabView {
                    WelcomeTabView(title: "Welcome to DreamSphere", subtitle: "", imageName: "moon.stars.fill")
                    WelcomeTabView(title: "Receive a notification in the morning", subtitle: "And write your dreams down", imageName: "text.badge.plus")
                    WelcomeTabView(title: "Add friends, and share your dreams with each other", subtitle: "", imageName: "person.2.fill")
                    VStack(spacing: 20) {
                        Text("Ready to get started?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Button("Create an account") {
                            isShowingLoginView = true
                        }
                        .buttonStyle(MainButtonStyle())
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .navigationTitle("Welcome")
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isShowingLoginView) {
            LoginView()
        }
    }
}

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.gray.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct WelcomeTabView: View {
    let title: String
    let subtitle: String
    let imageName: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
            Text(title).font(.title).fontWeight(.bold).foregroundColor(.white)
            if !subtitle.isEmpty {
                Text(subtitle).font(.title3).multilineTextAlignment(.center).foregroundColor(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
