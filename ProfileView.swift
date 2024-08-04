import SwiftUI

struct ProfileView: View {
    @State private var isEditingProfile = false
    @State private var isShowingSettings = false

    let userName = "John Doe"
    let dateJoined = "January 2020"
    let dreamsCount = 5
    let dreams: [CommunityDream] = [
        CommunityDream(title: "Dream 1", content: "Description of Dream 1", author: "John Doe", datePosted: Date()),
        CommunityDream(title: "Dream 2", content: "Description of Dream 2", author: "John Doe", datePosted: Date().addingTimeInterval(-86400))
    ]

    var body: some View {
        NavigationView {
            ZStack {
                StarryNightBackground().edgesIgnoringSafeArea(.all) // Reintegrated StarryNightBackground
                
                VStack {
                    HStack {
                        Image("PFP")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(userName)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                            Text("Joined: \(dateJoined)")
                                .foregroundColor(.gray)
                            Text("Dreams: \(dreamsCount)")
                                .foregroundColor(.gray)
                        }
                        .padding([.top, .leading])

                        Spacer()
                    }
                    .padding(.top, 20)

                    Button(action: {
                        isEditingProfile = true
                    }) {
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color(.sRGB, red: 0.15, green: 0.15, blue: 0.15, opacity: 1))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(dreams) { dream in
                                UnifiedDreamView(dream: dream)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    NavigationLink(destination: EditProfileView(), isActive: $isEditingProfile) { EmptyView() }
                    NavigationLink(destination: SettingsView(), isActive: $isShowingSettings) { EmptyView() }
                }
                .padding(.top)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings = true
            }) {
                Image(systemName: "gearshape")
                    .imageScale(.large)
                    .foregroundColor(.white)
            })
            .navigationBarHidden(false) // Ensure the navigation bar is shown
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

// Ensure your UnifiedDreamView and other component placeholders are defined as needed.
