//
//  ContentView.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 1/2/26.
//
import SwiftUI

struct ContentView: View {
    @State private var showPremiumAlert = false
    @State private var isShowingAddProfile = false
    @State private var isShowingSettings = false
    @State private var taskGroups: [TaskGroup] = []
    @State private var profiles: [TaskProfile] = []
    @State private var path = NavigationPath()
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("isDarkMode") private var isDarkMode = false

    let saveKey = "savedProfiles"
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    Text("Select the working profile")
                        .font(.largeTitle.bold())
                        .accessibilityIdentifier("ProfileSelector")

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($profiles) { $profile in
                            NavigationLink(value: profile) {
                                VStack {
                                    Image(profile.profileImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .clipShape(.circle)
                                    Text(profile.name)
                                        .font(.title2.bold())
                                }
//                                .accessibilityIdentifier("ProfileSelectorName")
//                                .contextMenu {
//                                    Button(role: .destructive) {
//                                        deleteProfile(profile)
//                                    } label: {
//                                        Label("Delete Profile", systemImage: "trash")
//                                    }
//                                }
                            }

                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
            .navigationDestination(for: TaskProfile.self) { selectedProfile in
                if let index = profiles.firstIndex(where: { $0.id == selectedProfile.id }) {
                    DashboardView(profile: $profiles[index])
                        .navigationBarBackButtonHidden(true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        if profiles.count >= 3 {
                            showPremiumAlert = true
                        } else {
                            isShowingAddProfile = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("New Profile")
                        }
                    }
                    .accessibilityIdentifier("addNewProfileButton")
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                    .accessibilityIdentifier("settingsButton")
                }
            }
            .sheet(isPresented: $isShowingAddProfile) {
                NewProfileView { newProfile in
                    profiles.append(newProfile)
                    saveData()
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .alert("Upgrade to Premium", isPresented: $showPremiumAlert) {
                Button("Got it!", role: .cancel) { }
            } message: {
                Text("Add more than 2 profiles to unlock premium features.")
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            loadData()
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                print("App is Active")
            } else if newValue == .inactive {
                print("app is inActive")
            } else if newValue == .background {
                print("App is Background - Saving Data!")
                saveData()
            }
        }
    }

    func saveData() {
        if let encodedData = try? JSONEncoder().encode(profiles) {
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }

    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedProfile = try? JSONDecoder().decode([TaskProfile].self, from: savedData) {
                profiles = decodedProfile
                return
            }
        }
        // show mock data dev purposes
        // profiles = Profile.sample
    }

    func deleteProfile(_ profile: TaskProfile) {
        profiles.removeAll { $0.id == profile.id }
        saveData()
    }
}

