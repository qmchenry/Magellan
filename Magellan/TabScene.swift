//
//  TabScene.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct TabScene: View {
    @EnvironmentObject var state: AppState
    @ObservedObject var nav = Navigator()

    var body: some View {
        TabView(selection: $nav.selectedTab) {
            VStack {
                Home()
            }
            .tabItem({ TabLabel(tab: .home) })
            .tag(Tab.home)

            VStack {
                Text("Search Tab")
            }
            .tabItem({ TabLabel(tab: .search) })
            .tag(Tab.search)

            VStack {
                Text("Account Tab")
            }
            .tabItem({ TabLabel(tab: .account) })
            .tag(Tab.account)
        }
    }

    enum Tab: Int {
        case home
        case search
        case account

        var title: String {
            switch self {
            case .home:
                return "Home"
            case .search:
                return "Search"
            case .account:
                return "Account"
            }
        }

        var iconName: String {
            switch self {
            case .home:
                return "house.fill"
            case .search:
                return "magnifyingglass"
            case .account:
                return "person"
            }
        }
    }

    struct TabLabel: View {
        let tab: Tab

        var body: some View {
            HStack {
                Image(systemName: tab.iconName)
                Text(tab.title)
            }
        }
    }
}

extension TabScene {
    final class Navigator: ObservableObject {
        @Published var selectedTab: TabScene.Tab = .home

        func update(forState state: AppState.State) {
            guard let tab = tab(forState: state), tab != selectedTab else { return }
            selectedTab = tab
        }

        private func tab(forState state: AppState.State) -> TabScene.Tab? {
            switch state {
            case .loading, .unauthenticated:
                return nil
            case .purchase, .home:
                return .home
            case .account:
                return .account
            case .search:
                return .search
            }
        }
    }
}

struct TabScene_Previews: PreviewProvider {
    static var previews: some View {
        TabScene()
            .environmentObject(AppState(initialState: .search))
    }
}
