//
//  ProjectApp.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/06/12.
//

import SwiftUI

@main
struct ProjectApp: App {
    @StateObject private var model = Model()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(model)
        }
    }
}
