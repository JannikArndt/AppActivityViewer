//
//  AppEntry.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct AppEntry: View {
    let collection: [Entry]

    var body: some View {
        Form {
            CategoryView(icon: "network", name: "Network", entries: collection.filter { $0.isNetwork })
            CategoryView(icon: "photo.on.rectangle", name: "Photos", entries: collection.filter { $0.category == .photos })
            CategoryView(icon: "camera", name: "Camera", entries: collection.filter { $0.category == .camera })
            CategoryView(icon: "mic", name: "Microphone", entries: collection.filter { $0.category == .microphone })
            CategoryView(icon: "person.3", name: "Contacts", entries: collection.filter { $0.category == .contacts })
            CategoryView(icon: "music.note.house", name: "Media Library", entries: collection.filter { $0.category == .mediaLibrary })
            CategoryView(icon: "location", name: "Location", entries: collection.filter { $0.category == .location })
            CategoryView(icon: "record.circle", name: "Screen Recording", entries: collection.filter { $0.category == .screenRecording })
        }
        .navigationTitle(collection.first?.app ?? "<unknown>")
    }
}

struct AppEntry_Previews: PreviewProvider {
    static var previews: some View {
        AppEntry(collection: [])
    }
}

struct CategoryView: View {
    let icon: String
    let name: String
    let entries: [Entry]

    var body: some View {
        if entries.count > 0 {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: icon)
                    Text("\(name)")
                }.font(.headline)

                ForEach(entries, id: \.self) { entry in
                    if let domain = entry.domain {
                        Text("\(domain)")
                    } else {
                        Text("\(entry.timeStamp.formatDate())")
                    }
                }
            }.padding()
        } else {
            EmptyView()
        }
    }
}
