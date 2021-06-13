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
                Text("Loading")
            case .unauthenticated:
                Text("unauthenticated")
            case .tabView:
                Text("TabView")
            }
        }
        .onReceive(state.$state) { state in
            nav.update(forState: state)
        }
    }

}

extension ContentView {
    enum MainView {
        case loading
        case unauthenticated
        case tabView
    }
    
    final class Navigator: ObservableObject {
        @Published var mainView: MainView = .loading
        
        func update(forState state: AppState.State) {
            switch state {
            case .loading:
                mainView = .loading
            case .unauthenticated:
                mainView = .unauthenticated
            case .home, .account, .search:
                mainView = .tabView
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
