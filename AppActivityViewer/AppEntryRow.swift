//
//  AppEntryRow.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct AppEntryRow: View {
    let collection: [Entry]

    @State private var iTunesData: iTunesEntry? = nil
    @State private var imageUrl: URL? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            AsyncImage(url: imageUrl) { image in
                image.resizable().frame(width: 40, height: 40, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Image(systemName: "questionmark.app").resizable().frame(width: 40, height: 40, alignment: .center)
            }
            VStack(alignment: .leading, spacing: 10) {
                if let name = iTunesData?.trackName,
                   let seller = iTunesData?.sellerName
                {
                    Text(name).font(.subheadline)
                    Text(seller).font(.caption).foregroundColor(.gray)
                } else {
                    Text(collection.first?.app ?? "<no app>").font(.headline)
                }

                HStack(alignment: .center, spacing: 10) {
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
        .task {
            let result = await iTunesHelper.getITunesData(identifier: collection.first?.app)
            iTunesData = result
            if let url = result?.artworkUrl100 {
                imageUrl = URL(string: url)
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
