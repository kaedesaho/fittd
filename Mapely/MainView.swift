//
//  MainView.swift
//  Mapely
//
//  Created by 佐保楓 on 2025/06/12.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                ClosetView()
                    .tabItem {
                        Label("Closet", systemImage: "tshirt.fill")
                    }
            }
            
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Model())
}
