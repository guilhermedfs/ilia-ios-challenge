//
//  MovieOverviewViewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation
import Moya
import SwiftUI
import CoreData

class MovieOverviewViewModel: ObservableObject {
    @Published var url: String = ""
    @Published var overviewData: OverviewData
    
    init(overviewData: OverviewData) {
        self.overviewData = overviewData
    }
    
    func setImageLink(url: String) -> String {
        let url = "https://image.tmdb.org/t/p/w342/\(String(url))"
        return url
    }
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: date)!
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: s)
        
        return dateString
    }
    
    func getTextColor(average: Double) -> Color {
        if average < 4.0 {
            return Color.red
        } else if average >= 4.0 && average < 6.0 {
            return Color.yellow
        } else {
            return Color.green
        }
    }
    
    func isSaved(items: FetchedResults<FavoritesMovies>, title: String) -> Bool {
        if items.contains(where: {$0.name == title}) {
            return true
        }
        
        return false
    }
    
    func unfavoriteMovie(context: NSManagedObjectContext) {
        let save = FavoritesMovies(context: context)
        
        PersistenceController.shared.delete(overviewData.title)
        save.objectWillChange.send()
    }
    
    func favoriteMovie(context: NSManagedObjectContext) {
        let save = FavoritesMovies(context: context)
        let note = MoviesNotes(context: context)
        
        save.name = overviewData.title
        save.resume = overviewData.overview
        save.imagePath = overviewData.posterPath
        save.releaseDate = overviewData.releaseDate
        save.voteAverage = overviewData.voteAverage
        note.movieTitle = overviewData.title
        save.notes = note
        
        PersistenceController.shared.save()
        save.objectWillChange.send()
    }
    
}
