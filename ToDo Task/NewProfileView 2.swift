import SwiftUI

struct NewProfileView: View {
    let onAdd: (Profile) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var imageName: String = "person.circle"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .accessibilityIdentifier("newProfileNameField")
                }
                
                Section {
                    TextField("Image Name", text: $imageName)
                        .accessibilityIdentifier("newProfileImageField")
                    Text("Enter the asset name of the image")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("New Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("cancelNewProfileButton")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        let profileImage = imageName.isEmpty ? "person.circle" : imageName
                        let newProfile = Profile(id: UUID(), name: trimmedName, profileImage: profileImage)
                        onAdd(newProfile)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .accessibilityIdentifier("saveNewProfileButton")
                }
            }
        }
    }
}

#Preview {
    NewProfileView { profile in
        print("Created profile with name: \(profile.name)")
    }
}
