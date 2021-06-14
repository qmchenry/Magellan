//
//  AppState.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import Foundation
import Combine

final class AppState: ObservableObject {
//    static let initialState: State = .unauthenticated(then: .search(item: "2"))
//    static let initialState: State = .unauthenticated(then: .home)
    static let initialState: State = .home

    indirect enum State {
        case loading
        case unauthenticated(then: State)
        case home
        case purchase(item: String)
        case account
        case search(item: String?)
    }
    
    @Published var state: State
    @Published var isAuthenticated: Bool

    func loadingCompleted() {
        DispatchQueue.main.async { [self] in
            state = isAuthenticated ? .home : .unauthenticated(then: .home)
        }
    }

    func unauthenticatedComplete(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
        if !isAuthenticated {
            state = .home
        }
        guard case let .unauthenticated(then) = state else { state = .home; return }
        state = then
    }
    
    init(initialState: State) {
        state = initialState
        isAuthenticated = false
    }
}
