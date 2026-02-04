//
//  GroupStatsView.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 12/11/25.
//
import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    var completedCount: Int { tasks.filter {$0.isCompleted}.count }
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)}
        
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.cyan)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.cyan)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .bold()
                    .accessibilityIdentifier("taskProgressPercentage")
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Task Progress")
                    .font(.headline)
                    .accessibilityIdentifier("taskProgressTitle")
                Text("\(completedCount) / \(tasks.count) Completed")
                    .accessibilityIdentifier("taskProgressCount")
            }
            
            .frame(maxWidth: .infinity, alignment:  .leading)
            Spacer()
//            Text("Created: \(group.createdAt.formatted(date: .long, time: .omitted))")
//                .accessibilityIdentifier("groupCreatedDate")
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        
    }
}
