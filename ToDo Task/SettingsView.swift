import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true
    @AppStorage("themeSelection") private var themeSelection: Theme = .system
    @AppStorage("languageCode") private var languageCode: String = Locale.current.language.languageCode?.identifier ?? "en"

    public init() {}

    var body: some View {
        List {
            Section("General") {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    .accessibilityIdentifier("toggleNotifications")

                Picker("Theme", selection: $themeSelection) {
                    ForEach(Theme.allCases, id: \.self) { theme in
                        Text(theme.displayName).tag(theme)
                    }
                }
                .accessibilityIdentifier("pickerTheme")
            }

            Section("Language") {
                Picker("App Language", selection: $languageCode) {
                    ForEach(Locale.availableIdentifiers.sorted(), id: \.self) { id in
                        Text(Locale(identifier: id).localizedString(forLanguageCode: id) ?? id)
                            .tag(id)
                    }
                }
                .accessibilityIdentifier("pickerLanguage")
            }

            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-")
                        .foregroundStyle(.secondary)
                        .monospaced()
                }
                HStack {
                    Text("Build")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-")
                        .foregroundStyle(.secondary)
                        .monospaced()
                }
            }
        }
    }
}

private enum Theme: String, CaseIterable, Codable, Hashable {
    case system
    case light
    case dark

    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .navigationTitle("Settings")
    }
}
