//
//  NightSky.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/13/26.
//

import SwiftUI

/// The shared background gradient behind every screen.
struct NightSky: View {
    var body: some View {
        LinearGradient(
            colors: [Color(red: 0.03, green: 0.05, blue: 0.15), .black],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
