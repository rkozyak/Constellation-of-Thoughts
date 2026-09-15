//
//  AccountView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @Environment(AuthSession.self) private var session
    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var isWorking = false
    @State private var errorMessage: String?

    private var canSubmit: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                if let user = session.user {
                    signedIn(as: user.email ?? user.uid)
                } else {
                    signInForm
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .disabled(isWorking)
            .navigationTitle("Account")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private func signedIn(as name: String) -> some View {
        Section {
            LabeledContent("Signed in", value: name)
            Button("Sign Out", role: .destructive) {
                run { try session.signOut() }
            }
        } footer: {
            Text("Your stars are backed up to Firebase.")
        }
    }

    private var signInForm: some View {
        Group {
            Section {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .textContentType(.password)
            } footer: {
                Text("Sign in to back up your stars. Passwords need at least 6 characters.")
            }

            Section {
                Button("Sign In") {
                    run { try await session.signIn(email: email, password: password) }
                }
                .disabled(!canSubmit)

                Button("Create Account") {
                    run { try await session.createAccount(email: email, password: password) }
                }
                .disabled(!canSubmit)
            }
        }
    }

    private func run(_ action: @escaping () async throws -> Void) {
        errorMessage = nil
        isWorking = true
        Task {
            do {
                try await action()
            } catch {
                errorMessage = error.localizedDescription
            }
            isWorking = false
        }
    }
}

#Preview {
    AccountView()
        .environment(AuthSession())
}
