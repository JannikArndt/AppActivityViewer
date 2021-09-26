//
//  AppEntryRow.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct AppEntryRow: View {
    let collection: [Entry]

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ImageForBundleId(bundleId: collection.first?.app)
            VStack(alignment: .leading, spacing: 10) {
                Text(collection.first?.app ?? "<no app>").font(.headline)
                HStack {
                    LabelledNumber(category: "network", number: collection.filter { $0.isNetwork }.count)
                    LabelledNumber(category: "photo.on.rectangle", number: collection.filter { $0.category == .photos }.count)
                    LabelledNumber(category: "camera", number: collection.filter { $0.category == .camera }.count)
                    LabelledNumber(category: "mic", number: collection.filter { $0.category == .microphone }.count)
                    LabelledNumber(category: "person.3", number: collection.filter { $0.category == .contacts }.count)
                    LabelledNumber(category: "music.note.house", number: collection.filter { $0.category == .mediaLibrary }.count)
                    LabelledNumber(category: "location", number: collection.filter { $0.category == .location }.count)
                    LabelledNumber(category: "record.circle", number: collection.filter { $0.category == .screenRecording }.count)
                }
            }
        }
    }
}

struct LabelledNumber: View {
    let category: String
    let number: Int

    var body: some View {
        if number > 0 {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: category)
                Text("\(number)")
            }
        } else {
            EmptyView()
        }
    }
}
