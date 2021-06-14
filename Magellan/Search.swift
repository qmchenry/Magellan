//
//  Search.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/13/21.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var buyables: [String]
    @Published var isActive: [Bool]

    init() {
        let models = ["1", "2", "3"]
        buyables = models
        isActive = models.map { _ in false }
        // left out setting up a combine pipeline to keep isActive the same count as buyables
    }
}

struct Search: View {
    @EnvironmentObject var state: AppState
    @ObservedObject var viewModel = SearchViewModel()
//    @ObservedObject var selection = Selection()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    if isValid() {
                        ForEach(Array(zip(viewModel.buyables.indices, viewModel.buyables)), id: \.0) { index, buyable in
                            NavigationLink(
                              destination: Purchase(item: buyable),
                              isActive: $viewModel.isActive[index],
                              label: { EmptyView() }
                            )
                            Button {
                                startPurchase(item: buyable)
                            } label: {
                                Text("Purchase \(buyable)")
                            }
                        }
                    } else {
                        Text("why is this happening?")
                    }
                    Text("This is similar to Home's approach, but applies an Identifiable override for NavigationLink vs the built-in Hashable binding. It also uses a single NavigationLink in the background that is an EmptyView when the binding is nil.")
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("🔎 Search")
        }
        .onReceive(state.$state) { state in
            update(forState: state)
        }
    }

    func startPurchase(item: String) {
        if state.isAuthenticated {
            state.state = .search(item: item)
        } else {
            state.state = .unauthenticated(then: .search(item: item))
        }
    }

    func isValid() -> Bool {
        if viewModel.buyables.count != viewModel.isActive.count {
            viewModel.isActive = isActiveArray(forBuyables: viewModel.buyables, state: state.state)
        }
        return true
    }

    func update(forState state: AppState.State) {
        guard let nowActive = isActive(forState: state), nowActive != viewModel.isActive else { return }
        viewModel.isActive = nowActive
    }

    private func isActive(forState state: AppState.State) -> [Bool]? {
        guard case let .search(item) = state else { return nil }
        return viewModel.buyables.map { buyable in item == buyable }
    }

    func isActiveArray(forBuyables buyables: [String], state: AppState.State) -> [Bool] {
        if case let .search(item) = state {
            return buyables.map { $0 == item }
        } else {
            return [Bool](repeating: false, count: buyables.count)
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
