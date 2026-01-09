//
//  DashboardView.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 1/2/26.
//
import SwiftUI

struct DashboardView: View {
    @Binding var profile: Profile
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @State private var isShowingSettings = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedGroup) {
                ForEach(profile.group) { group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                        
                    }
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                        
                    } label : {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                    }
                        .accessibilityIdentifier("homeButton")
                
                }
                ToolbarItem(placement: .primaryAction) {
                    Button { isShowingAddGroup = true } label : {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addGroupButton")
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = profile.group.firstIndex(where: { $0.id == group.id}) {
                    TaskGroupDetailView(groups: $profile.group[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
              
        }
        
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.group.append(newGroup)}
        }
    }
    
}


