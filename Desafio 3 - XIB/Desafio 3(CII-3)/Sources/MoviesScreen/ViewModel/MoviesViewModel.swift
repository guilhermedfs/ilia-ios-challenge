//
//  MoviesViewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Daniel Fernandes da Silva on 03/12/21.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

class MoviesViewModel {
    
    var movies = PublishSubject<[MovieResult]>()
    let movieProvider = MoyaProvider<MovieAPI>()
    var changePage = PublishSubject<Int>()
    var movieData: MovieData
    let country = NSLocale.current.languageCode
    let countryDict = CountryDict()
    
    init(movieData: MovieData) {
        self.movieData = movieData
    }
    
    func fetchData() {
        guard let newCountry = country else {return}
        movieProvider.request(.upcomingMovies(page: movieData.currentPage, country: countryDict.countries[newCountry]!)) { (result) in
            switch result {
            case .success(let response):
                let user = try! JSONDecoder().decode(MoviesOverview.self, from: response.data)
                let data = user.results
                self.movieData.maxPage = user.totalPages
                self.movies.onNext(data)
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadPages(){
        guard movieData.currentPage < movieData.maxPage else {
            return
        }
        movieData.currentPage += 1
        print(movieData.currentPage)
        changePage.onNext(movieData.currentPage)
    }
}

