//
//  RiveIslandOverlayApp.swift
//  RiveIslandOverlay
//
//  Created by Zach Plata on 9/25/22.
//

import SwiftUI

@main
struct RiveIslandOverlayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    GeometryReader { proxy in
                        let size = proxy.size
                        BatView(size: size)
                    }
                    .ignoresSafeArea()
                }
            }
        }
    
}
struct NotificationModel {
    var title: String
    var content: String
}
