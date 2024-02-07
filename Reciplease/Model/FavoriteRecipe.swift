//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Florian Peyrony on 23/06/2021.
//

import Foundation
import CoreData

class FavoriteRecipe: NSManagedObject {
    static var allRecipes: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favoritesRecipes
    }
}
