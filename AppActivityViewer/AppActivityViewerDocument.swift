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
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.ndjson] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
