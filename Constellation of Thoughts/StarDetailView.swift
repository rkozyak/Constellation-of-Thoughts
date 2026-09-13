//
//  StarDetailView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI

struct StarDetailView: View {
    let star: Star

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(star.text)
                }

                if !star.note.isEmpty {
                    Section("Note") {
                        Text(star.note)
                    }
                }

                Section {
                    LabeledContent("Constellation", value: star.constellation?.name ?? "None")
                    LabeledContent("Saved", value: star.createdAt.formatted(date: .abbreviated, time: .shortened))
                }
            }
            .navigationTitle("Star")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
