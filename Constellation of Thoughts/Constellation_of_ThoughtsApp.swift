//
//  Constellation_of_ThoughtsApp.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI
import SwiftData

@main
struct Constellation_of_ThoughtsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Star.self)
    }
}
