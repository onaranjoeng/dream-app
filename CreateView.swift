import SwiftUI

struct CreateView: View {
    @State private var dreamTitle: String = ""
    @State private var dreamContent: String = "Type your dream here" // Added placeholder text
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        ZStack {
            StarryNightBackground()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Journal")
                    .font(.system(size: 36, weight: .bold)) // Increased font size
                    .foregroundColor(.gray)
                    .padding(.vertical, 10) // Adjusted padding for a larger box
                    .padding(.horizontal, 20)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 3)
                    )
                    .padding()

                Spacer()
                
                Text("Date: \(dateFormatter.string(from: Date()))")
                    .foregroundColor(.gray)
                    .font(.title3) // Increased font size for the date
                    .padding(.bottom, 5)
                
                TextField("Enter dream title...", text: $dreamTitle)
                    .padding()
                    .background(Color.gray) // Ensured it's visibly gray
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                ZStack(alignment: .topLeading) {
                    if dreamContent == "Type your dream here" {
                        Text("Type your dream here")
                            .foregroundColor(.white.opacity(0.6)) // Placeholder text color
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $dreamContent)
                        .opacity(dreamContent == "Type your dream here" ? 0.25 : 1) // Lower opacity when showing placeholder
                        .frame(height: 300)
                        .background(Color.gray) // Directly using gray to ensure no white background shows
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            if dreamContent == "Type your dream here" {
                                dreamContent = "" // Clear placeholder on tap
                            }
                        }
                }
                .padding(.bottom, 20)
                
                HStack(spacing: 10) {
                    ActionButton(title: "Post Publicly")
                    ActionButton(title: "Post to Friends")
                    ActionButton(title: "Save Privately")
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct ActionButton: View {
    var title: String

    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.7))
                .cornerRadius(10)
        }
        .padding(.top, 5)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

