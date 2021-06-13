//
//  MagellanApp.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

@available(iOS 14.0, *)
struct MagellanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AppState(initialState: .loading))
        }
    }
}
