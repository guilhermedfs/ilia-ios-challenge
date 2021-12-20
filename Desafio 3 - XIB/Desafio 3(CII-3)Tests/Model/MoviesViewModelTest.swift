//
//  MoviesModelViewTest.swift
//  Desafio 3(CII-3)Tests
//
//  Created by Guilherme - ília on 09/12/21.
//

import Foundation
@testable import Desafio_3_CII_3_
import XCTest

class MoviesViewModelTest: XCTestCase {
    
    /// Tests if the value change when it's lower than the max page (should change)
    func testChangePageMoviesViewModelLess() {
        let mockedMovieData = MovieData(maxPage: 20, currentPage: 3)
        let moviesModelView = MoviesViewModel(movieData: mockedMovieData, countryDict: CountryDict())
        
        moviesModelView.loadPages()
        XCTAssertEqual(mockedMovieData.currentPage, 4)
    }
    
    /// Tests if the value change when it's equal than the max page (should not change)
    func testChangePageMoviesViewModelEqual() {
        let mockedMovieData = MovieData(maxPage: 20, currentPage: 20)
        let moviesModelView = MoviesViewModel(movieData: mockedMovieData, countryDict: CountryDict())
        
        moviesModelView.loadPages()
        XCTAssertNotEqual(mockedMovieData.currentPage, 21)
    }
    
    /// Tests if the value change when it's bigger than the max page (should not change)
    func testChangePageMoviesViewModelBigger() {
        let mockedMovieData = MovieData(maxPage: 20, currentPage: 20)
        let moviesModelView = MoviesViewModel(movieData: mockedMovieData, countryDict: CountryDict())
        
        moviesModelView.loadPages()
        XCTAssertNotEqual(mockedMovieData.currentPage, 21)
    }
    
    func testChangePageMoviesViewModelChange() {
        let mockedMovieData = MovieData(maxPage: 30, currentPage: 20)
        let moviesModelView = MoviesViewModel(movieData: mockedMovieData, countryDict: CountryDict())
        let oldCurrentPage = mockedMovieData.currentPage
        
        moviesModelView.loadPages()
        
        let newCurrentPage = mockedMovieData.currentPage
        
        XCTAssertEqual(newCurrentPage - oldCurrentPage, 1)
    }
}

