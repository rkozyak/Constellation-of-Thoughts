//
//  ContentView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI
import SwiftData

enum AppTab: Hashable {
    case home, journal, new
}

struct ContentView: View {
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
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Star.self, inMemory: true)
}
