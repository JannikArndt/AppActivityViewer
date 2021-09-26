//
//  AppActivityViewerApp.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

@main
struct AppActivityViewerApp: App {
    @Environment(\.scenePhase) var lifeCycle

    var body: some Scene {
        DocumentGroup(viewing: AppActivityViewerDocument.self) { file in
            ContentView(document: file.$document)
        }.onChange(of: lifeCycle) { newLifeCyclePhase in
            switch newLifeCyclePhase {
            case .active:
                print("App is active")
                if let documentBrowserViewController = UIApplication.shared.windows.first?.rootViewController as? UIDocumentBrowserViewController {
                    documentBrowserViewController.allowsDocumentCreation = false
                }
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is going to the Background")
            @unknown default:
                print("default")
            }
        }
    }
}
