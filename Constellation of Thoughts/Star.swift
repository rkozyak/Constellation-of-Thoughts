//
//  Star.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import Foundation
import SwiftData

/// A single saved thought, drawn as one star in its constellation.
@Model
final class Star {
    var text: String
    var note: String
    var createdAt: Date
    /// Offset from the constellation's center, in normalized sky coordinates.
    var offsetX: Double
    var offsetY: Double

    var constellation: Constellation?

    init(text: String, note: String = "", constellation: Constellation? = nil) {
        self.text = text
        self.note = note
        self.createdAt = .now
        self.constellation = constellation

        let angle = Double.random(in: 0 ..< (2 * .pi))
        let radius = Double.random(in: 0.08...0.28)
        self.offsetX = cos(angle) * radius
        self.offsetY = sin(angle) * radius
    }
}
