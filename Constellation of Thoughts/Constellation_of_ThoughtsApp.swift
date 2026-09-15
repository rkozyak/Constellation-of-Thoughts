//
//  Constellation_of_ThoughtsApp.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct Constellation_of_ThoughtsApp: App {
    @State private var session: AuthSession

    init() {
        FirebaseApp.configure()
        _session = State(initialValue: AuthSession())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(session)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Star.self)
    }
}
