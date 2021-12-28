//
//  Poster.swift
//  Desafio3SwiftUI
//
//  Created by Guilherme - ília on 28/12/21.
//

import SwiftUI

struct Poster: View {
    let path: String?
    
    init(path: String?) {
        self.path = path
    }
    
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w342/\(path ?? "")")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150, maxHeight: 250)
        } placeholder: {
            ProgressView()
        }
    }
}

struct Poster_Previews: PreviewProvider {
    static var previews: some View {
        Poster(path: "")
    }
}
