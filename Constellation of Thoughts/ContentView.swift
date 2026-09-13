//
//  ContentView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/12/26.
//

import SwiftUI

enum AppTab: Hashable {
    case home, journal, settings
}

struct ContentView: View {
    @State private var selection: AppTab = .home
    @State private var isPresentingNewStar = false

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "moon.stars.fill", value: AppTab.home) {
                HomeView()
            }

            Tab("Journal", systemImage: "book.closed.fill", value: AppTab.journal) {
                HomeView()
            }

            Tab("Settings", systemImage: "gear", value: AppTab.settings) {
                SettingsView()
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                isPresentingNewStar = true
            } label: {
                Image(systemName: "star.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: 56, height: 56)
                    .contentShape(.circle)
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive(), in: .circle)
            .padding(.trailing, 16)
            .padding(.bottom, 4)
        }
        .sheet(isPresented: $isPresentingNewStar) {
            NewStarView()
        }
    }
}

#Preview {
    ContentView()
}
