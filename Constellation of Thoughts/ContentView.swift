//
//  ContentView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI
import FirebaseAuth
import SwiftData

enum AppTab: Hashable {
    case home, journal, new
}

struct ContentView: View {
    @Environment(AuthSession.self) private var session
    /// Stars that have not reached Firestore yet, from before sync existed or a failed upload.
    @Query(filter: #Predicate<Star> { $0.remoteID == nil }) private var unsyncedStars: [Star]

    @State private var selection: AppTab = .home
    @State private var isAddingStar = false

    /// Choosing "New" opens the sheet rather than switching tabs, so the tab that
    /// was already showing stays put behind it.
    private var tab: Binding<AppTab> {
        Binding {
            selection
        } set: { newValue in
            if newValue == .new {
                isAddingStar = true
            } else {
                selection = newValue
            }
        }
    }

    var body: some View {
        TabView(selection: tab) {
            Tab("Home", systemImage: "moon.stars.fill", value: AppTab.home) {
                HomeView()
            }

            Tab("Journal", systemImage: "book.closed.fill", value: AppTab.journal) {
                JournalView()
            }

            Tab("New", systemImage: "star.fill", value: AppTab.new, role: .prominent) {
                EmptyView()
            }
        }
        .sheet(isPresented: $isAddingStar) {
            NewStarView()
        }
        // Reruns on sign-in, so stars saved while signed out get backed up.
        .task(id: session.user?.uid) {
            guard session.user != nil else { return }
            for star in unsyncedStars {
                star.remoteID = try? await StarCloud.upload(star)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthSession())
        .modelContainer(for: Star.self, inMemory: true)
}
