//
//  HomeView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI

struct HomeView: View {
    @State private var isPresentingAccount = false

    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .navigationTitle("Constellation")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Account", systemImage: "person.crop.circle") {
                            isPresentingAccount = true
                        }
                    }
                }
        }
        .sheet(isPresented: $isPresentingAccount) {
            AccountView()
        }
    }
}

#Preview {
    HomeView()
}
