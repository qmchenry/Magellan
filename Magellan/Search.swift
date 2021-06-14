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

    func update(fromState state: AppState.State) {
        let updatedIsActive = makeIsActive(forState: state)
        if updatedIsActive != isActive {
            isActive = updatedIsActive
        }
    }

    private func makeIsActive(forState state: AppState.State) -> [Bool] {
        if case let .search(item) = state {
            return buyables.map { $0 == item }
        } else {
            return [Bool](repeating: false, count: buyables.count)
        }
    }

    init() {
        let models = ["1", "2", "3"]
        buyables = models
        isActive = models.map { _ in false }
        // left out setting up a combine pipeline to keep isActive the same count as buyables
    }
}

// MARK: - View

struct Search: View {
    @EnvironmentObject var state: AppState
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
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
                    Text("This is similar to Home's approach, but applies an Identifiable override for NavigationLink vs the built-in Hashable binding. It also uses a single NavigationLink in the background that is an EmptyView when the binding is nil.")
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("🔎 Search")
        }
        .onReceive(state.$state) { state in
            viewModel.update(fromState: state)
        }
    }

    func startPurchase(item: String) {
        if state.isAuthenticated {
            state.state = .search(item: item)
        } else {
            state.state = .unauthenticated(then: .search(item: item))
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
