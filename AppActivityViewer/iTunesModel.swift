//
//  iTunesModel.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import Foundation

struct iTunesResponse: Codable {
    let resultCount: Int
    let results: [iTunesEntry]
}

struct iTunesEntry: Codable {
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let trackName, sellerName: String

    enum CodingKeys: String, CodingKey {
        case artworkUrl60, artworkUrl512, artworkUrl100
        case trackName, sellerName
    }
}

enum iTunesHelper {
    static func getITunesData(identifier: String?) async -> iTunesEntry? {
        guard let identifier = identifier,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(iTunesResponse.self, from: data).results.first
        } catch {
            print("Error loading icon: \(error)")
            return nil
        }
    }
}
