//
//  Model.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//  See https://developer.apple.com/documentation/foundation/urlrequest/inspecting_app_activity_data

import Foundation

// MARK: - Entry

struct Entry: Codable, Hashable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        // for type access
        if let lhsId = lhs.identifier,
           let rhsId = rhs.identifier,
           let lhsKind = lhs.kind,
           let rhsKind = rhs.kind
        {
            return lhsId == rhsId && lhsKind == rhsKind
        } // for type networkActivity
        else if let lhsDomain = lhs.domain,
                let rhsDomain = rhs.domain,
                let lhsBundle = lhs.bundleID,
                let rhsBundle = rhs.bundleID
        {
            return lhsDomain == rhsDomain && lhs.timeStamp == rhs.timeStamp && lhsBundle == rhsBundle
        } else {
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(domain)
        hasher.combine(bundleID)
        hasher.combine(timeStamp)
    }

    var app: String {
        if let id = accessor?.identifier {
            return id
        } else if let bundle = bundleID {
            return bundle
        } else {
            return ""
        }
    }

    var isAccess: Bool { return type == .access }
    var isNetwork: Bool { return type == .networkActivity }

    var isBeginOfInterval: Bool { return kind == .intervalBegin }
    var isEndOfInterval: Bool { return kind == .intervalEnd }

    func isBeginOf(_ theCategory: Categories) -> Bool {
        return kind == .intervalBegin && category == theCategory
    }

    let accessor: AppIdentifier?
    let broadcaster: AppIdentifier? // Only present for screen recording.

    let category: Categories?

    let identifier: String? // The same for intervalBegin and intervalEnd
    let kind: Kind?
    let timeStamp: String
    let type: EntryType

    let domain: String?
    let firstTimeStamp: String?
    let context: String?
    let domainType: Int?
    let initiatedType: Initiated?
    let hits: Int?
    let domainOwner: String?
    let bundleID: String?

    enum CodingKeys: String, CodingKey {
        case accessor
        case broadcaster
        case category
        case identifier
        case kind
        case timeStamp
        case type
        case domain
        case firstTimeStamp
        case context
        case domainType
        case initiatedType
        case hits
        case domainOwner
        case bundleID
    }
}

enum Initiated: String, Codable {
    case AppInitiated, NonAppInitiated
}

enum EntryType: String, Codable {
    case access, networkActivity
}

enum Kind: String, Codable {
    case intervalBegin, intervalEnd
}

enum Categories: String, Codable {
    case photos, camera, microphone, contacts, mediaLibrary, location, screenRecording
}

// MARK: - AppIdentifier

struct AppIdentifier: Codable {
    let identifier: String // The app accessing the resource or broadcasting the screen
    let identifierType: String

    enum CodingKeys: String, CodingKey {
        case identifier
        case identifierType
    }
}

extension Array where Element == Entry {
    func countNetworkRequests() -> Int {
        reduce(0) { $1.isNetwork ? $0 + 1 : $0 }
    }

    func countAccessRequests() -> Int {
        reduce(0) { $1.isAccess && $1.isBeginOfInterval ? $0 + 1 : $0 }
    }

    func count(_ category: Categories) -> Int {
        reduce(0) { $1.isBeginOf(category) ? $0 + 1 : $0 }
    }
}
