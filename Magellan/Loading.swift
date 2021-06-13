//
//  Loading.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var state: AppState
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Loading...")
        .onReceive(timer) { _ in
            state.loadingCompleted()
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
