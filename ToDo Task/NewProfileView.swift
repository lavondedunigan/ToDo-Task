import SwiftUI

struct Profile: Identifiable, Codable {
    let id: UUID
    var name: String
    var profileImage: String
}

struct NewProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var profileImage: String = "person.circle"
    
    let onCreate: (Profile) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile Info")) {
                    TextField("Name", text: $name)
                    TextField("Profile Image Name", text: $profileImage)
                }
            }
            .navigationTitle("New Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        let newProfile = Profile(id: UUID(), name: name, profileImage: profileImage)
                        onCreate(newProfile)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NewProfileView { profile in
        // Dummy closure for preview
        print("Created profile: \(profile)")
    }
}
