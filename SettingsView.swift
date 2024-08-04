import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Placeholder state variables for settings options
    @State private var notificationsEnabled = false
    @State private var darkModeEnabled = false
    @State private var soundEnabled = false
    @State private var receiveNewsletter = false
    @State private var accountPrivacy: String = "Public" // Could be "Public", "Friends", or "Private"
    @State private var language: String = "English" // Placeholder for language selection

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications")
                    }
                    Toggle(isOn: $darkModeEnabled) {
                        Text("Dark Mode")
                    }
                    Toggle(isOn: $soundEnabled) {
                        Text("Sound Effects")
                    }
                }
                
                Section(header: Text("Privacy")) {
                    Picker("Account Privacy", selection: $accountPrivacy) {
                        Text("Public").tag("Public")
                        Text("Friends Only").tag("Friends")
                        Text("Private").tag("Private")
                    }
                }
                
                Section(header: Text("Communications")) {
                    Toggle(isOn: $receiveNewsletter) {
                        Text("Receive Newsletter")
                    }
                }
                
                Section(header: Text("Account")) {
                    NavigationLink("Change Password", destination: Text("Change Password View"))
                    Button("Log Out") {
                        // Handle log out
                    }
                }
                
                Section(header: Text("More")) {
                    Picker("Language", selection: $language) {
                        Text("English").tag("English")
                        Text("Spanish").tag("Spanish")
                        // Add more languages as needed
                    }
                    NavigationLink("Help & Support", destination: Text("Help & Support View"))
                    NavigationLink("About", destination: Text("About View"))
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
