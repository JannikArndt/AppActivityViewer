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
        ScrollView { LazyVStack(alignment: .leading, spacing: 5) {
            ForEach(loadData(text: document.text), id: \.self) { entry in
                Text(entry.app)
            }
        }
        }
    }

    func loadData(text: String) -> [Entry] {
        let lines = text.split(whereSeparator: \.isNewline)
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
        print("Read \(result.count) entries")

        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(AppActivityViewerDocument()))
    }
}
