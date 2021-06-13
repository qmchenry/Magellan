//
//  AppState.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    indirect enum State {
        case loading
        case unauthenticated(then: State)
        case home(detail: String?)
        case account
        case search
    }
    
    @Published var state: State
    
    init(initialState: State) {
        state = initialState
    }
}
