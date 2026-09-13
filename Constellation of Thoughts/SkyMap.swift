//
//  SkyMap.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI
import SwiftData

/// Draws every constellation as a cluster of stars joined by faint lines.
struct SkyMap: View {
    @Query(sort: \Constellation.createdAt) private var constellations: [Constellation]

    @Binding var selection: Star?

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ZStack {
                Canvas { context, _ in
                    for constellation in constellations {
                        var path = Path()
                        path.addLines(stars(in: constellation).map { position(of: $0, in: size) })
                        context.stroke(
                            path,
                            with: .color(constellation.color.opacity(0.25)),
                            lineWidth: 1
                        )
                    }
                }

                ForEach(constellations) { constellation in
                    ForEach(stars(in: constellation)) { star in
                        StarView(star: star)
                            .position(position(of: star, in: size))
                            .onTapGesture { selection = star }
                    }
                }
            }
        }
        .padding(40)
    }

    /// Oldest first, so the line joining them reads as the order the thoughts arrived.
    private func stars(in constellation: Constellation) -> [Star] {
        constellation.stars.sorted { $0.createdAt < $1.createdAt }
    }

    /// Converts a star's normalized sky coordinates into a point in the view.
    private func position(of star: Star, in size: CGSize) -> CGPoint {
        let x = (star.constellation?.centerX ?? 0) + star.offsetX
        let y = (star.constellation?.centerY ?? 0) + star.offsetY
        return CGPoint(
            x: (x + 1) / 2 * size.width,
            y: (y + 1) / 2 * size.height
        )
    }
}

private struct StarView: View {
    let star: Star

    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 8, height: 8)
            .shadow(color: star.constellation?.color ?? .white, radius: 6)
            .frame(width: 44, height: 44)
            .contentShape(.circle)
    }
}
