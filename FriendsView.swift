import SwiftUI

struct FriendsView: View {
    @State private var searchText = ""
    @State private var isSearchBarVisible = false
    
    let friendsDreams: [CommunityDream] = [
        CommunityDream(title: "Flying High", content: "I dreamt I was flying above the clouds  hasjhasfjhsdgfjhgsdjhfgsdjhfgsdjhgfjhsdgfjhsdgfjhsdgfjsdhkfhkthwkvjhferhgkjdhvkerhgkjwnvkeruhgshfeksjfhksdhvlakdhygkjdshvkjdfhgkjsdhfkjhtkjwehfjsdhfgkuwehgjkerhguwhgkerhgwhgkjshgkjsdhgehfgkjsdhgkhsdgk", author: "Alex", datePosted: Date().addingTimeInterval(-86400 * 10)), // 10 days ago
        CommunityDream(title: "Ocean Deep", content: "An underwater city full of light...", author: "Casey", datePosted: Date().addingTimeInterval(-86400 * 5)), // 5 days ago
        CommunityDream(title: "Mountain Peak", content: "Standing atop the tallest mountain, looking over the world...", author: "Jordan", datePosted: Date().addingTimeInterval(-86400 * 2)),
        CommunityDream(title: "Flying High", content: "I dreamt I was flying above the clouds  hasjhasfjhsdgfjhgsdjhfgsdjhfgsdjhgfjhsdgfjhsdgfjhsdgfjsdhkfhkthwkvjhferhgkjdhvkerhgkjwnvkeruhgshfeksjfhksdhvlakdhygkjdshvkjdfhgkjsdhfkjhtkjwehfjsdhfgkuwehgjkerhguwhgkerhgwhgkjshgkjsdhgehfgkjsdhgkhsdgk", author: "Alex", datePosted: Date().addingTimeInterval(-86400 * 10)), // 10 days ago
        CommunityDream(title: "Ocean Deep", content: "An underwater city full of light...", author: "Casey", datePosted: Date().addingTimeInterval(-86400 * 5)), // 5 days ago
        CommunityDream(title: "Mountain Peak", content: "Standing atop the tallest mountain, looking over the world...", author: "Jordan", datePosted: Date().addingTimeInterval(-86400 * 2))// 2 days ago
    ]
    
    var body: some View {
           NavigationView { // Ensure your view is wrapped in a NavigationView for navigation bar items to show
               ZStack {
                   StarryNightBackground() // Background component
                       .edgesIgnoringSafeArea(.all)
                   
                   VStack {
                       if isSearchBarVisible {
                           // SearchBar view with a binding to searchText
                           // Adjust this SearchBar view to match your search UI component
                           SearchBar(text: $searchText)
                               .padding([.horizontal, .bottom])
                       }
                       
                       ScrollView {
                           LazyVStack(spacing: 20) {
                               ForEach(friendsDreams.filter { searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(searchText) || $0.content.localizedCaseInsensitiveContains(searchText) }, id: \.id) { dream in
                                   UnifiedDreamView(dream: dream, isExpandable: true)
                                       .padding(.horizontal)
                               }
                           }
                       }
                   }
               }
               .navigationTitle("Friends' Dreams")
               .navigationBarItems(leading: Button(action: {
                   withAnimation {
                       isSearchBarVisible.toggle() // Toggle visibility with animation
                   }
               }) {
                   Image(systemName: "magnifyingglass")
                       .foregroundColor(.white)
               })
               .navigationBarTitleDisplayMode(.inline)
               .background(Color.black) // Extends background color to navigation elements
               .accentColor(.white) // Ensure navigation bar items are visible against the dark background
           } // Close NavigationView
       }
   }

   struct FriendsView_Previews: PreviewProvider {
       static var previews: some View {
           FriendsView()
       }
   }
