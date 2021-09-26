//
//  AppActivityViewerDocument.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var ndjson: UTType {
        UTType(filenameExtension: "ndjson", conformingTo: .item)!
    }
}

struct AppActivityViewerDocument: FileDocument {
    var entries: [Entry]
    var apps: [String: [Entry]]

    init() {
        entries = []
        apps = [:]
    }

    static var readableContentTypes: [UTType] { [.ndjson] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }

        let lines = string.split(whereSeparator: \.isNewline)
        let result: [Entry] = lines.compactMap { line in
            do {
                if let data = line.data(using: .utf8) {
                    let entry: Entry = try JSONDecoder().decode(Entry.self, from: data)
                    return entry
                } else {
                    print("couldn't read utf8 from line \(line)")
                    return nil
                }
            } catch {
                print("Error: \(error)")
                return nil
            }
        }

        entries = result
        apps = Dictionary(grouping: entries, by: \.app)
        print("Read \(result.count) entries")
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.fileWriteNoPermission)
    }
}
