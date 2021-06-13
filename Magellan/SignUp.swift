//
//  SignUp.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct SignUp: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack {
            Button(action: {
                state.unauthenticatedComplete(isAuthenticated: true)
            }) {
                Text("Let's pretend you signed up")
            }
        }
        .navigationBarTitle("Sign up")
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUp()
        }
    }
}
