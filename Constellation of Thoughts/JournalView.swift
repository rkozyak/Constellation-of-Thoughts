//
//  JournalView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Constellation.createdAt) private var constellations: [Constellation]

    var body: some View {
        NavigationStack {
            ZStack {
                NightSky()

                if constellations.allSatisfy(\.stars.isEmpty) {
                    ContentUnavailableView("No Thoughts Yet", systemImage: "sparkles")
                } else {
                    list
                }
            }
            .navigationTitle("Journal")
        }
    }

    private var list: some View {
        List {
            ForEach(constellations) { constellation in
                if !constellation.stars.isEmpty {
                    Section {
                        ForEach(stars(in: constellation)) { star in
                            row(for: star)
                        }
                        .onDelete { offsets in
                            delete(offsets, in: constellation)
                        }
                    } header: {
                        Label(constellation.name, systemImage: "circle.fill")
                            .foregroundStyle(constellation.color)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }

    private func row(for star: Star) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(star.text)

            if !star.note.isEmpty {
                Text(star.note)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Text(star.createdAt, format: .dateTime.month().day().hour().minute())
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }

    private func stars(in constellation: Constellation) -> [Star] {
        constellation.stars.sorted { $0.createdAt > $1.createdAt }
    }

    private func delete(_ offsets: IndexSet, in constellation: Constellation) {
        let stars = stars(in: constellation)
        for offset in offsets {
            let star = stars[offset]
            if let remoteID = star.remoteID {
                Task { try? await StarCloud.delete(id: remoteID) }
            }
            modelContext.delete(star)
        }
    }
}

#Preview {
    JournalView()
        .modelContainer(for: Star.self, inMemory: true)
}
