import SwiftUI

struct DashboardView: View {
    @Binding var profile: TaskProfile
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @State private var isShowingSettings = false
    @State private var showPremiumAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Sidebar
            VStack(spacing: 0) {
                List(selection: $selectedGroup) {
                    Section {
                        Text(profile.name)
                            .font(.title)
                            .accessibilityIdentifier("profileName")
                    }
                    
                    Section(header: Text("Groups")) {
                        ForEach(profile.group) { group in
                            Label(group.title, systemImage: group.symbolName)
                                .tag(Optional(group))
                                .accessibilityIdentifier("groupRow_\(group.title)")
                        }
                        .onDelete(perform: deleteGroup)
                    }
                }
                .navigationTitle(profile.name)
                .listStyle(.sidebar)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: languageManager.isRTL ? "chevron.left" : "chevron.right")
                                Text("Home")
                            }
                        }
                        .accessibilityIdentifier("homeButton")
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button { isShowingAddGroup = true } label: {
                            Image(systemName: "plus")
                        }
                        .accessibilityIdentifier("addGroupButton")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { isShowingSettings = true } label: {
                            Image(systemName: "gearshape")
                        }
                        .accessibilityIdentifier("settingsButton")
                    }
                }
                
                // Premium banner at bottom of sidebar
                VStack {
                    Spacer(minLength: 0)
                    HStack {
                        Image("Flag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Premium")
                                .font(.title)
                            Text("Unlock all features")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Button {
                                isShowingSettings = true
                            } label: {
                                Text("Go to settings")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                    .padding(.top, 4)
                            }
                            .accessibilityIdentifier("goToSettingsButton")
                        }
                        Spacer()
                    }
                }
            }
        } detail: {
                if let group = selectedGroup, let index = profile.group.firstIndex(where: { $0.id == group.id }) {
                    TaskGroupDetailView(groups: $profile.group[index])
                } else {
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                        .accessibilityIdentifier("selectGroupToSeeDetails")
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button("New Group") { isShowingAddGroup.toggle() }
                            }
                        }
                }
            }
            .sheet(isPresented: $isShowingAddGroup) {
                NewGroupView { newGroup in
                    profile.group.append(newGroup)
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                NavigationStack {
                    SettingsView()
                        .navigationTitle("Settings")
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button("Done") { isShowingSettings.toggle() }
                            }
                        }
                }
            }
            .alert("Premium Required", isPresented: $showPremiumAlert) {
                Button("Upgrade to Premium") { isShowingSettings = true }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Upgrade to premium to unlock all features")
            }
        }
    
        // MARK: - Actions
        func deleteGroup(at offsets: IndexSet) {
            profile.group.remove(atOffsets: offsets)
        }
    
    }
    


