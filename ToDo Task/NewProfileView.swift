import SwiftUI

struct NewProfileView: View {
    @Environment(\.dismiss)  var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    
    @State private var profileName  = ""
    @State private var selectedImage = "person.circle"
    
    let images = ["Professor", "Student"]
    
    var onSave: (Profile) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Profile Name") {
                    TextField("Type the name of the new profile", text: $profileName)
                        .accessibilityIdentifier("profileNameTextField")
                }
                
                Section("Select Image") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(6)
                                .background(selectedImage == image ? Color.cyan.opacity(0.2) : Color.gray.opacity(0.2))
                                .foregroundStyle(selectedImage == image ? Color.cyan : Color.gray)
                                .clipShape(.circle)
                                .onTapGesture {
                                    selectedImage = image
                                }
                                .accessibilityIdentifier("imageSelect_\(image)")
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Profile Creator")
            .toolbar {
                if languageManager.isRTL {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { saveProfile() }
                            .accessibilityIdentifier("saveProfileButton")
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                            .accessibilityIdentifier("cancelProfileButton")
                    }
                } else {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                            .accessibilityIdentifier("cancelProfileButton")
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { saveProfile() }
                            .accessibilityIdentifier("saveProfileButton")
                    }
                }
            }
        }
    }
    
    func saveProfile() {
        let NewProfile = Profile(name: profileName, profileImage: selectedImage, groups: [])
        onSave(NewProfile)
        dismiss()
    }
}
