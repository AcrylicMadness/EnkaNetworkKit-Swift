//
//  ContentView.swift
//  EnkaNetworkKitDemo
//
//  Created by Кирилл Аверкиев on 03.05.2023.
//

import EnkaNetworkKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(EnkaNetworkKit().text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
