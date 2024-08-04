//
//  EditProfileView.swift
//  DreamSphere
//
//  Created by Matt Maletta on 4/8/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var username: String = ""
    @State private var profilePicture: Image? = nil // Placeholder for profile picture handling
    @State private var privacySetting: String = "Public" // Example privacy setting
    
    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                TextField("Username", text: $username)
                // Add more fields as necessary
            }
            
            Section(header: Text("Privacy Settings")) {
                Picker("Privacy", selection: $privacySetting) {
                    Text("Public").tag("Public")
                    Text("Friends Only").tag("Friends Only")
                    Text("Private").tag("Private")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            // Placeholder for profile picture editing
            // In a real scenario, you might include image picker functionality
            
            Section {
                Button(action: {
                    // Action for saving changes
                    // For now, this does nothing
                }) {
                    Text("Save Changes")
                }
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView()
        }
    }
}
