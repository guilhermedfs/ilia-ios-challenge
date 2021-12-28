//
//  MoviesViewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Daniel Fernandes da Silva on 03/12/21.
//

import Foundation
import Moya

final class MoviesViewModel: ObservableObject {
    
    @Published var movies = [MovieResult]()
    @Published var newUrl: String = ""
    let movieProvider = MoyaProvider<MovieAPI>()
    var movieData = MovieData(maxPage: 20, currentPage: 1)
    
    func fetchData() {
        movieProvider.request(.upcomingMovies(page: movieData.currentPage)) { (result) in
            switch result {
            case .success(let response):
                let user = try! JSONDecoder().decode(MoviesOverview.self, from: response.data)
                let data = user.results
                self.movieData.maxPage = user.totalPages
                self.movies += data
                break
            case .failure(let error):
                print(error)
            }
        }
        
        func getImageLink(url: String) -> String {
            newUrl = "https://image.tmdb.org/t/p/w342/\(String(url))"
            return url
        }
    }
    
    func loadPages(){
        guard movieData.currentPage < movieData.maxPage else {
            return
        }
        movieData.currentPage += 1
        print(movieData.currentPage)
        fetchData()
    }
}

