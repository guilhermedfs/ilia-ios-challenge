//
//  ListOptionButton.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 21/01/22.
//

import SwiftUI

struct ListOptionButton: View {
    @Binding var edition: Bool
    var body: some View {
        Button {
            edition.toggle()
        } label: {
            Image(systemName: edition ? "square.and.arrow.down.fill" : "pencil")
                .foregroundColor(.black)
        }
    }
}
//
//struct ListOptionButton_Previews: PreviewProvider {
////    static var previews: some View {
////        ListOptionButton(edition: false)
////    }
//}
