//
//  Constellation.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import SwiftData

/// A theme that groups related thoughts together, drawn as one cluster in the sky.
@Model
final class Constellation {
    var name: String
    var hue: Double
    /// Where this cluster sits in the sky, in normalized coordinates from -1 to 1.
    var centerX: Double
    var centerY: Double
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Star.constellation)
    var stars: [Star] = []

    init(name: String) {
        self.name = name
        self.hue = Double.random(in: 0...1)
        self.centerX = Double.random(in: -0.5...0.5)
        self.centerY = Double.random(in: -0.5...0.5)
        self.createdAt = .now
    }

    var color: Color {
        Color(hue: hue, saturation: 0.35, brightness: 1)
    }
}
