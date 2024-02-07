//
//  CoreDataService.swift
//  Reciplease
//
//  Created by Florian Peyrony on 30/06/2021.
//

import Foundation
import CoreData

 class SaveFavoriteRecipe {
    
    let container: NSPersistentContainer
    init() {
        container = AppDelegate.persistentContainer
    }
    
    func saveRecipe(recipe: Hit) {
        let recipeSaved = FavoriteRecipe(context: AppDelegate.viewContext)
        recipeSaved.image = recipe.recipe.image
        let ingredients = recipe.recipe.ingredients
            .map { $0.text }
            .joined(separator: ", ")
        recipeSaved.ingredients = "\(ingredients)"
        recipeSaved.url = recipe.recipe.url
        recipeSaved.recipeName = recipe.recipe.label
        recipeSaved.timeToPrepare = Int16(recipe.recipe.totalTime)
        recipeSaved.forXpeople = Int16(recipe.recipe.yield)
    
        // TO DO : rajouter des do catch pour la gestion d'erreur et avertir l'utilisateur par alert si il y a probleme
        try? AppDelegate.viewContext.save()
    }
    
    func deleteRecipe(recipe: FavoriteRecipe) {
        AppDelegate.viewContext.delete(recipe)
    }
    
}
