//
//  CardView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI
import ImageGetter

struct CardView: View {
    let title: String
    let posterPath: String?
    var path: String {
        return posterPath ?? ""
    }
    var body: some View {
        VStack {
            ImageGetter(path: path)
            Text(title)
                .font(.title3.bold())
                .lineLimit(1)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Hello World!", posterPath: "")
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
