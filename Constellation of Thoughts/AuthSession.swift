//
//  AuthSession.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/15/26.
//

import Observation
import FirebaseAuth

/// The signed-in Firebase user, kept current by Firebase's auth state listener.
@Observable
final class AuthSession {
    private(set) var user: User?
    @ObservationIgnored private var listener: AuthStateDidChangeListenerHandle?

    init() {
        user = Auth.auth().currentUser
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }

    func createAccount(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
