//
//  StarCloud.swift
//  Constellation of Thoughts
//
//  Created by Richard Kozyak on 9/15/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

/// Mirrors stars to Cloud Firestore under the signed-in user: `users/{uid}/stars/{starID}`.
enum StarCloud {
    /// The signed-in user's stars collection, or nil when nobody is signed in.
    private static var stars: CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return Firestore.firestore().collection("users").document(uid).collection("stars")
    }

    /// Uploads a star and returns its Firestore document ID, or nil when signed out.
    static func upload(_ star: Star) async throws -> String? {
        guard let stars else { return nil }

        let document = try await stars.addDocument(data: [
            "text": star.text,
            "note": star.note,
            "constellation": star.constellation?.name ?? "",
            "hue": star.constellation?.hue ?? 0,
            "createdAt": star.createdAt,
        ])
        return document.documentID
    }

    static func delete(id: String) async throws {
        try await stars?.document(id).delete()
    }
}
