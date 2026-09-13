//
//  ContentView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI

enum AppTab: Hashable {
    case home, journal, search
}

struct ContentView: View {
    @State private var selection: AppTab = .home
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "moon.stars.fill", value: AppTab.home) {
                HomeView()
            }

            Tab("Journal", systemImage: "book.closed.fill", value: AppTab.journal) {
                HomeView()
            }

            Tab(value: AppTab.search, role: .search) {
                NavigationStack {
                    Text("Search")
                        .navigationTitle("Search")
                }
                .searchable(text: $searchText)
            }
        }
    }
}

#Preview {
    ContentView()
}
