//
//  SignIn.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack {
            Button(action: {
                state.unauthenticatedComplete(isAuthenticated: true)
            }) {
                Text("Good job \"Signing in\"")
            }
        }
        .navigationBarTitle("Sign in")
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
