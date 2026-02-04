//
//  ProfileCardView.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 2/4/26.
//

import SwiftUI

struct ProfileCardView: View {
    let profile: TaskProfile
    
    var body: some View {
        VStack {
            Image(profile.profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(.circle)
            Text(profile.name)
                .font(.title2.bold())
        }
    }
}
