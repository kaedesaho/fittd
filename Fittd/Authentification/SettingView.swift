//
//  SettingView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/18.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() {
        AuthentificationManager.shared.signOut()
    }
}

struct SettingView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var showUpdatePassView = false

    var body: some View {
        List {
            Button("Log Out") {
                viewModel.signOut()
                showSignInView = true
            }

            Section {
                NavigationLink("Update Password") {
                    UpdatePassView()
                }
            } header: {
                Text("Email & Password")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingView(showSignInView: .constant(false))
    }
}
