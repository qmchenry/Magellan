//
//  Home.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI
import Combine

struct Home: View {
    @State var buyables = ["1", "2", "3"]
    @EnvironmentObject var state: AppState
    @ObservedObject var nav = Navigator()

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ForEach(Array(zip(buyables.indices, buyables)), id: \.0) { index, buyable in
                    NavigationLink("Purchase \(buyable)", destination: Purchase(item: buyable), isActive: $nav.isActive[index])
                }
            }
        }
        .navigationBarTitle("Home Sweet Home")
        .onReceive(state.$state) { state in
            nav.update(forState: state)
        }
    }

    init() {
        nav.update(buyables: buyables)
    }
}

extension Home {
    final class Navigator: ObservableObject {
        @Published var isActive: [Bool] = []
        private var buyables = [String]()

        func update(forState state: AppState.State) {
            guard let nowActive = isActive(forState: state), nowActive != isActive else { return }
            isActive = nowActive
        }

        private func isActive(forState state: AppState.State) -> [Bool]? {
            guard case let .purchase(item) = state else { return nil }
            return buyables.map { buyable in item == buyable }
        }

        func update(buyables: [String]) {
            self.buyables = buyables
            isActive = buyables.map { _ in false }
        }

        private var cancellable = Set<AnyCancellable>()
        init() {
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
