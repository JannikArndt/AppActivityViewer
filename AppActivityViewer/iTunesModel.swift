//
//  iTunesModel.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import Foundation

struct iTunesResponse: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let artworkUrl60, artworkUrl512, artworkUrl100: String

    enum CodingKeys: String, CodingKey {
        case artworkUrl60, artworkUrl512, artworkUrl100
    }
}
