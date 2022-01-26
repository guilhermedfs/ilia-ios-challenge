//
//  CardView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI

struct CardView: View {
    let title: String
    let posterPath: String?
    var path: String {
        return posterPath ?? ""
    }
    
    @State private var loaded = false
    private let transaction: Transaction = .init(animation: .linear)

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342/\(path)"), transaction: transaction) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .transition(.slide)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .frame(maxWidth: 150, maxHeight: 250)
                case .failure:
                    Image(systemName: "cloud")
                @unknown default:
                    EmptyView()
                }
            }
            
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
