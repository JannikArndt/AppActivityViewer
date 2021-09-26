//
//  ImageForBundleId.swift
//  AppActivityViewer
//
//  Created by Jannik Arndt on 26.09.21.
//

import SwiftUI

struct ImageForBundleId: View {
    let bundleId: String?

    @State private var imageURL: URL? = nil

    var body: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable().frame(width: 40, height: 40, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            Image(systemName: "questionmark.app").resizable().frame(width: 40, height: 40, alignment: .center)
        }.task {
            let url = await getUrl(identifier: bundleId)
            imageURL = url
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
            if let urlString = iTunesEntry.results.first?.artworkUrl100 {
                return URL(string: urlString)
            }
        } catch {
            print("Error loading icon: \(error)")
            return nil
        }
        return nil
    }
}

struct ImageForBundleId_Previews: PreviewProvider {
    static var previews: some View {
        ImageForBundleId(bundleId: "de.jannikarndt.zettl")
    }
}
