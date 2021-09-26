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
                            AppEntryRow(collection: collection)
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
