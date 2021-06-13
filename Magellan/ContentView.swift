//
//  ContentView.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var state: AppState
    @ObservedObject var nav = Navigator()
    
    var body: some View {
        Group {
            switch nav.mainView {
            case .loading:
                Loading()
            case .unauthenticated:
                Unauthenticated()
            case .tabView:
                TabScene()
            }
        }
        .onReceive(state.$state) { state in
            nav.update(forState: state)
        }
    }

    enum MainView {
        case loading
        case unauthenticated
        case tabView
    }
}

extension ContentView {

    final class Navigator: ObservableObject {
        @Published var mainView: ContentView.MainView = .loading

        func update(forState state: AppState.State) {
            let view = view(forState: state)
            guard view != mainView else { return }
            mainView = view
        }

        private func view(forState state: AppState.State) -> ContentView.MainView {
            switch state {
            case .loading:
                return .loading
            case .unauthenticated:
                return .unauthenticated
            case .home, .purchase, .account, .search:
                return .tabView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState(initialState: .unauthenticated(then: .search)))
    }
}
