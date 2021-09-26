//
//  AppActivityViewerApp.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

@main
struct AppActivityViewerApp: App {
    var body: some Scene {
        DocumentGroup(viewing: AppActivityViewerDocument.self) { file in
            ContentView(document: file.$document)
        }
    }
}
