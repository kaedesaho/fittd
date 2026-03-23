//
//  RootView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/18.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false

    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    SettingView(showSignInView: $showSignInView)
                }
                MainView()
            }
        }
        .onAppear {
            showSignInView = AuthentificationManager.shared.getToken() == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthentificationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
