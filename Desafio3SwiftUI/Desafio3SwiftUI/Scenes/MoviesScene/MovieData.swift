//
//  MovieData.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation

class MovieData {
    private var _maxPage: Int
    private var _currentPage: Int
    
    public var maxPage: Int {
        get {
            return self._maxPage
        }
        set (newValue){
            self._maxPage = newValue
        }
    }
    
    public var currentPage: Int {
        get {
            return self._currentPage
        }
        set (newValue) {
            self._currentPage = newValue
        }
    }
    
    init(maxPage: Int, currentPage: Int) {
        self._maxPage = maxPage
        self._currentPage = currentPage
    }
}

struct Movies: Identifiable {
    let id: UUID
    let movies: MovieResult
}
