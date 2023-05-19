//
//  BatView.swift
//  RiveIslandOverlay
//
//  Created by Zach Plata on 9/25/22.
//

import Foundation
import SwiftUI
import RiveRuntime

struct BatView: View {
    var size: CGSize
    @State private var isFinished = false;
    @State private var multiSelection = Set<UUID>()
    
    var schedItems = [
        TaskItem(task: "Wake up", time: "12:00 AM"),
        TaskItem(task: "Terrorize other bats", time: "12:15 AM"),
        TaskItem(task: "Eat fruit", time: "12:30 AM"),
        TaskItem(task: "Fly around the caves", time: "01:00 AM"),
        TaskItem(task: "Vampire stuff", time: "01:30 AM"),
        TaskItem(task: "Meeting with the Cullens", time: "02:00 AM"),
        TaskItem(task: "More flying around", time: "02:30 AM"),
        TaskItem(task: "Eat more fruit", time: "03:00 AM"),
        TaskItem(task: "Terrorize the townsfolk", time: "04:00 AM"),
        TaskItem(task: "Destroy the garlic fields", time: "04:30 AM"),
        TaskItem(task: "Report OKR status to Dracula", time: "05:00 AM"),
        TaskItem(task: "Back to the caves", time: "05:15 AM"),
        TaskItem(task: "Chaotic free time with the cave exploring humans", time: "05:30 AM"),
        TaskItem(task: "Sharpen teeth", time: "06:00 AM"),
        TaskItem(task: "Nestle in the cave depths", time: "07:00 AM"),
        TaskItem(task: "Sleep for the day", time: "07:15 AM")
    ]
    var rvm = RiveViewModel(
        fileName: "batty7",
        artboardName: "Bat"
    )
    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                let offset = proxy.frame(in: .named("scroll")).minY
                Color.clear.preference(key: ViewOffsetKey.self, value: round(offset * 10) / 10)
            }
            NavigationView {
                List(schedItems, selection: $multiSelection) {taskItem in
                    Text("**\(taskItem.time)** - \(taskItem.task)")
                }
                .navigationTitle("Daily Bat Schedule")
            }
            .frame(
                width: size.width,
                height: size.height
            )
            
        }
        .background(Color.gray)
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ViewOffsetKey.self) { value in
            print(value)
            if (value <= 110 && !isFinished) {
                rvm.setInput("pull", value: value)
                
            }
            if (value >= 100) {
                isFinished = true;
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    rvm.triggerInput("loadingFinished")
                }
            }
        }
        .border(.gray)
        rvm
            .view()
            .frame(width: size.width, height: 154)
            .offset(y: -2)
            .zIndex(1)
    }
}

struct TaskItem: Identifiable {
    let task: String
    let time: String
    let id = UUID()
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
