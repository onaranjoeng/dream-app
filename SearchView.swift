import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    let communityDreams: [CommunityDream] = [
        // Sample dreams with dynamic dates
        CommunityDream(title: "Uncharted Galaxies", content: "I navigated through unknown galaxies...", author: "Morgan", datePosted: Date()),
        CommunityDream(title: "The Lost City", content: "I discovered a city lost in time...", author: "Riley", datePosted: Date().addingTimeInterval(-86400)), // 1 day ago
        CommunityDream(title: "Garden of Shadows", content: "A garden where shadows whispered...", author: "Taylor", datePosted: Date().addingTimeInterval(-432000)) // 5 days ago
    ]

    var body: some View {
        ZStack {
            StarryNightBackground() // Extends behind the status bar
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                // Position the search bar without extra top padding
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    // Removes previously added top padding to move the search bar up
                    .padding(.vertical, 0)

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(communityDreams.filter { searchText.isEmpty ? true : $0.title.contains(searchText) }, id: \.id) { dream in
                            UnifiedDreamView(dream: dream, isExpandable: true)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        // Use `.navigationBarHidden(true)` if within a NavigationView to hide the navigation bar
        .navigationBarTitle("Search & Discover", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
