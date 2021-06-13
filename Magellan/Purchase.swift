//
//  Purchase.swift
//  Magellan
//
//  Created by Quinn McHenry on 6/12/21.
//

import SwiftUI

struct Purchase: View {
    let item: String
    var body: some View {
        Text("Let's buy item \(item)")
    }
}

struct Purchase_Previews: PreviewProvider {
    static var previews: some View {
        Purchase(item: "1")
    }
}
