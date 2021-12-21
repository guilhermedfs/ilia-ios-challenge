//
//  ConfigsVIewModel.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 21/12/21.
//

import Foundation
import RxSwift
import RxCocoa

class ConfigViewModel {
    var colorBackgroudChange = PublishSubject<String>()
    
    func changeColorBackgroud(color: String) {
        colorBackgroudChange.onNext(color)
    }
}
