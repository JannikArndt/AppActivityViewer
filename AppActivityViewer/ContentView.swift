//
//  ContentView.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: AppActivityViewerDocument

    var body: some View {
        if document.entries.count > 0 {
            NavigationView {
                Form {
                    ForEach(document.apps.values.sorted { $0[0].app < $1[0].app }, id: \.self) { collection in
                        NavigationLink(destination: AppEntry(collection: collection)) {
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
            }
        } else {
            VStack(alignment: .leading, spacing: 10) {
                Text("The file contains no readable entries.")
                Text("To create an App Privacy Report, go to Settings > Privacy > Record App Activity.")
                Text("After you have recorded activity, save the file to your files.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(AppActivityViewerDocument()))
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
