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
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(AppActivityViewerDocument()))
    }
}
