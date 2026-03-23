//
//  AuthentificationManagert.swift
//  Fittd
//
//  Created by 佐保楓 on 2025/10/18.
//

import Foundation

struct AuthDataResultModel {
    let email: String
}

final class AuthentificationManager {
    static let shared = AuthentificationManager()
    private init() {}

    private let tokenKey = "auth_token"
    private let emailKey = "auth_email"
    private let baseURL = "http://127.0.0.1:5000"

    // MARK: - Token storage

    func saveToken(_ token: String, email: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(email, forKey: emailKey)
    }

    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }

    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: emailKey)
    }

    // MARK: - Auth

    func getAuthentifucateUser() throws -> AuthDataResultModel {
        guard let email = UserDefaults.standard.string(forKey: emailKey),
              getToken() != nil else {
            throw URLError(.userAuthenticationRequired)
        }
        return AuthDataResultModel(email: email)
    }

    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let token = try await post(path: "/register", body: ["email": email, "password": password])
        saveToken(token, email: email)
        return AuthDataResultModel(email: email)
    }

    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let token = try await post(path: "/login", body: ["email": email, "password": password])
        saveToken(token, email: email)
        return AuthDataResultModel(email: email)
    }

    func updatePassword(password: String) async throws {
        guard let token = getToken() else { throw URLError(.userAuthenticationRequired) }
        try await postAuthenticated(path: "/update-password", body: ["password": password], token: token)
    }

    func signOut() {
        clearToken()
    }

    // MARK: - Networking

    private func post(path: String, body: [String: String]) async throws -> String {
        guard let url = URL(string: baseURL + path) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let msg = (try? JSONDecoder().decode([String: String].self, from: data))?["error"] ?? "Request failed"
            throw NSError(domain: "Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
        }
        guard let token = (try? JSONDecoder().decode([String: String].self, from: data))?["token"] else {
            throw URLError(.badServerResponse)
        }
        return token
    }

    private func postAuthenticated(path: String, body: [String: String], token: String) async throws {
        guard let url = URL(string: baseURL + path) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            let msg = (try? JSONDecoder().decode([String: String].self, from: data))?["error"] ?? "Request failed"
            throw NSError(domain: "Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
        }
    }
}
