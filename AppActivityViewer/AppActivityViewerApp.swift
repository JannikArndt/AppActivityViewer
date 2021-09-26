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
    
    func getUrl(identifier: String?) async -> URL? {
        guard let identifier = identifier,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)")
        else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let iTunesEntry: iTunesResponse = try JSONDecoder().decode(iTunesResponse.self, from: data)
            if let urlString = iTunesEntry.results.first?.artworkUrl60 {
                return URL(string: urlString)
            }
        } catch {
            print("Error loading icon: \(error)")
            return nil
        }
        return nil
    }
}
