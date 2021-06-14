//
//  Account.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/14/21.
//

import SwiftUI

struct Account: View {
    @EnvironmentObject var state: AppState

    let destinations: [AppState.State] = [
        .home,
        .unauthenticated(then: .home),
        .search(item: nil),
        .search(item: "3"),
        .unauthenticated(then: .search(item: "3"))
    ]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(Array(zip(destinations.indices, destinations)), id: \.0) { _, destination in
                    Button {
                        state.state = destination
                    } label: {
                        Text(name(destination: destination))
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("⚙️ Account")
        }
    }

    func name(destination: AppState.State) -> String {
        "\(destination)"
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
