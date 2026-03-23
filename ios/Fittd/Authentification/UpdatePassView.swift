//
//  UpdatePassView.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/20.
//

import SwiftUI

@MainActor
final class updatePassViewModel: ObservableObject {
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var success = false

    func updatePassword() async throws {
        guard !password.isEmpty else { return }
        errorMessage = nil
        try await AuthentificationManager.shared.updatePassword(password: password)
        success = true
    }
}

struct UpdatePassView: View {
    @StateObject private var viewModel = updatePassViewModel()

    var body: some View {
        VStack(spacing: 12) {
            SecureField("New Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.caption)
            }

            if viewModel.success {
                Text("Password updated!")
                    .foregroundStyle(.green)
                    .font(.caption)
            }

            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                    } catch {
                        viewModel.errorMessage = error.localizedDescription
                    }
                }
            }
        }
        .navigationTitle("Update Password")
    }
}

#Preview {
    NavigationStack {
        UpdatePassView()
    }
}
