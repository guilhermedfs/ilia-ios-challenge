//
//  OverviewView.swift
//  Desafio3_SwiftUI
//
//  Created by Guilherme - ília on 27/12/21.
//

import SwiftUI
import ImageGetter

struct OverviewView: View {
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    var overviewViewModel = MovieOverviewViewModel()
    
    var path: String {
        return posterPath ?? ""
    }
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center) {
                ImageGetter(path: posterPath)
                Text(title)
                    .font(.title2.bold())
                    .padding(20)
                Text(overview)
                    .font(.system(size: 22))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            Spacer()
            Section {
                Text("Release date: ")
                    .fontWeight(.bold) +
                Text("\(releaseDate)")
                Text("Vote average: ")
                    .fontWeight(.bold) +
                Text("\(String(format: "%.1f", voteAverage))")
                    .foregroundColor(overviewViewModel.getTextColor(average: voteAverage))
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(title: "Hello", overview: "nil", posterPath: "", voteAverage: 0, releaseDate: "")
    }
}
