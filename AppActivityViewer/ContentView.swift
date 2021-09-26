//
//  ContentView.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: AppActivityViewerDocument
    @State var ordering: Ordering = .alphabetical

    var body: some View {
        if document.entries.count > 0 {
            NavigationView {
                Form {
                    switch ordering {
                    case .alphabetical:
                        ForEach(document.apps.values.sorted { $0[0].app < $1[0].app }, id: \.self) { collection in
                            NavigationLink(destination: AppEntry(collection: collection)) { AppEntryRow(collection: collection) }
                        }
                    case .byNetwork:
                        ForEach(document.apps.values.sorted { $0.countNetworkRequests() > $1.countNetworkRequests() }, id: \.self) { collection in
                            NavigationLink(destination: AppEntry(collection: collection)) { AppEntryRow(collection: collection) }
                        }
                    case .byAccess:
                        ForEach(document.apps.values.sorted { $0.countAccessRequests() > $1.countAccessRequests() }, id: \.self) { collection in
                            NavigationLink(destination: AppEntry(collection: collection)) { AppEntryRow(collection: collection) }
                        }
                    }
                }.toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Menu {
                            Section {
                                Text("Order by…")
                                Picker(selection: $ordering) {
                                    Label("Alphabetical", systemImage: "abc").tag(Ordering.alphabetical)
                                    Label("Network Activity", systemImage: "network").tag(Ordering.byNetwork)
                                    Label("Access Requests", systemImage: "gear.badge.questionmark").tag(Ordering.byAccess)
                                } label: {
                                    Text("Order by")
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down.square")
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

enum Ordering: String, Identifiable, CaseIterable {
    case alphabetical
    case byNetwork
    case byAccess

    var id: String { rawValue }
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
