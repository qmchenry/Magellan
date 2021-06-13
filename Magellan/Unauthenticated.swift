//
//  Unauthenticated.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct Unauthenticated: View {
    @EnvironmentObject var state: AppState

    var isThenPurchase: Bool {
        switch state.state {
        case .purchase:
            return true
        default:
            return false
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isThenPurchase {
                    Text("You need to sign in before you can make a purchase")
                } else {
                    Text("Welcome! Let's get you signed up and signed in!")
                }
                NavigationLink("Sign Up", destination: SignUp())
                NavigationLink("Sign In", destination: SignIn())
                Button(action: { state.unauthenticatedComplete(isAuthenticated: false) }) {
                    Text("Be our guest")
                }

                Text("This is the first page of a navigation stack that lets an unauthenticated user sign up or sign in. The AppState.State representing it carries the next State like .unauthenticated(then: .home) such the that intent for what follows the unauthenticated flow is maintained as the user steps through the unauth views.\nThe AppState.state property is available in the View to allow the content to be contextual dependent on the then: State.")

            }
        }
    }
}

struct Unauthenticated_Previews: PreviewProvider {
    static var previews: some View {
        Unauthenticated()
    }
}
