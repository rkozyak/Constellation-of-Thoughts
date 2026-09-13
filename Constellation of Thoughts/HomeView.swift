//
//  HomeView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var stars: [Star]

    @State private var isPresentingAccount = false
    @State private var selectedStar: Star?

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.03, green: 0.05, blue: 0.15), .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if stars.isEmpty {
                    ContentUnavailableView("No Thoughts Yet", systemImage: "sparkles")
                } else {
                    SkyMap(selection: $selectedStar)
                }
            }
            .navigationTitle("Constellation")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Account", systemImage: "person.crop.circle") {
                        isPresentingAccount = true
                    }
                }
            }
        }
        .sheet(item: $selectedStar) { star in
            StarDetailView(star: star)
        }
        .sheet(isPresented: $isPresentingAccount) {
            AccountView()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Star.self, inMemory: true)
}
