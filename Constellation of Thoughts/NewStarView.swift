//
//  NewStarView.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import SwiftData

struct NewStarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Constellation.createdAt) private var constellations: [Constellation]

    @Environment(\.dismiss) private var dismiss

    @State private var text = ""
    @State private var note = ""
    @State private var constellation: Constellation?
    @State private var isNamingConstellation = false
    @State private var newConstellationName = ""

    private var canSave: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && constellation != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Thought") {
                    TextField("What do you want to remember?", text: $text, axis: .vertical)
                        .lineLimit(1...4)
                }

                Section("Note") {
                    TextField("Anything more to say?", text: $note, axis: .vertical)
                        .lineLimit(3...8)
                }

                Section("Constellation") {
                    Picker("Constellation", selection: $constellation) {
                        Text("None").tag(Constellation?.none)
                        ForEach(constellations) { constellation in
                            Text(constellation.name).tag(Constellation?.some(constellation))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()

                    Button("New Constellation", systemImage: "plus") {
                        isNamingConstellation = true
                    }
                }
            }
            .navigationTitle("New Star")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(!canSave)
                }
            }
            .alert("New Constellation", isPresented: $isNamingConstellation) {
                TextField("Name", text: $newConstellationName)
                Button("Cancel", role: .cancel) { newConstellationName = "" }
                Button("Create", action: createConstellation)
            } message: {
                Text("Group related thoughts under a theme.")
            }
        }
    }

    private func createConstellation() {
        let name = newConstellationName.trimmingCharacters(in: .whitespacesAndNewlines)
        newConstellationName = ""
        guard !name.isEmpty else { return }

        let created = Constellation(name: name)
        modelContext.insert(created)
        constellation = created
    }

    private func save() {
        let star = Star(
            text: text.trimmingCharacters(in: .whitespacesAndNewlines),
            note: note.trimmingCharacters(in: .whitespacesAndNewlines),
            constellation: constellation
        )
        modelContext.insert(star)

        dismiss()
    }
}

#Preview {
    NewStarView()
        .modelContainer(for: Star.self, inMemory: true)
}
