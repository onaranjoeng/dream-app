import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .profile

    enum Tab: String {
        case search, create, friends, profile
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Content
                Group {
                    switch selectedTab {
                    case .search:
                        SearchView() // Now contains functionality for exploring content as well
                    case .create:
                        CreateView()
                    case .friends:
                        FriendsView()
                    case .profile:
                        ProfileView()
                    // The 'explore' case has been removed
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Custom Tab Bar
                Divider().background(Color.black)
                HStack(spacing: 0) { // Adjust spacing for equal distribution
                    // Removed the button for the 'explore' tab
                    
                    TabBarButton(icon: "magnifyingglass", tab: .search, selectedTab: $selectedTab, size: 28)
                        .frame(maxWidth: .infinity)
                    
                    Divider().frame(width: 1, height: 50).background(Color.white)
                    
                    TabBarButton(icon: "plus", tab: .create, selectedTab: $selectedTab, size: 28)
                        .frame(maxWidth: .infinity)
                    
                    Divider().frame(width: 1, height: 50).background(Color.white)
                    
                    TabBarButton(icon: "person.2.fill", tab: .friends, selectedTab: $selectedTab, size: 28)
                        .frame(maxWidth: .infinity)
                    
                    Divider().frame(width: 1, height: 50).background(Color.white)
                    
                    TabBarButton(icon: "person.fill", tab: .profile, selectedTab: $selectedTab, size: 28)
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.6))
                .clipShape(Rectangle())
            }
        }
    }
}

struct TabBarButton: View {
    let icon: String
    let tab: HomeView.Tab
    @Binding var selectedTab: HomeView.Tab
    var size: CGFloat

    var body: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .foregroundColor(selectedTab == tab ? .white : .gray)
            .onTapGesture {
                selectedTab = tab
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
