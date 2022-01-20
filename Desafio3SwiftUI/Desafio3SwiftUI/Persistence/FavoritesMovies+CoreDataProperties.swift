//
//  FavoritesMovies+CoreDataProperties.swift
//  
//
//  Created by Guilherme - ília on 19/01/22.
//
//

import Foundation
import CoreData


extension FavoritesMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesMovies> {
        return NSFetchRequest<FavoritesMovies>(entityName: "FavoritesMovies")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var resume: String?
    @NSManaged public var voteAverage: Double

}
