//
//  TestCoreData.swift
//  RecipleaseServiceTestsCase
//
//  Created by Florian Peyrony on 04/01/2022.
//

import XCTest

import XCTest
@testable import Reciplease
import CoreData


extension Hit {
    static func with(name: String, url: String) -> Hit {
        return Hit(recipe: Recipe(name: name, url: url))
    }
}


class TestCoreData: XCTestCase {
    
    var saveFavoriteRecipe: SaveFavoriteRecipe!
    var recipeSaved: FavoriteRecipe?
    var alamofireService: RecipeAlamofireService?
    var expectation: XCTestExpectation!
    var saveRecipe: SaveFavoriteRecipe?
    let coreDataService = SaveFavoriteRecipe()

    
    
    
    
    func testSavingRecipe() {
        
        // Given
        let hit = Hit.with(name: "Totot", url: "http://google.com")
        let hit2 = Hit.with(name: "Totot", url: "http://google.com")
       
    
        // When
        print(" HOW MANY ELEMENT IN DATABASE\(AppDelegate.viewContext.accessibilityElementCount())")
        self.coreDataService.saveRecipe(recipe: hit)
        
        // then
        XCTAssertNotNil(coreDataService.container.viewContext)
        XCTAssertEqual(hit.recipe.image, hit2.recipe.image)
        // verifier que la recipe est bien la bonne
    }
    
    func testDeleatingRecipe() {
        // given
        var numberOfFavoritesRecipes = 0
        var numberOfRecipesAfterDeleating = 0
        var recipes: [FavoriteRecipe] = []
        let hit = Hit.with(name: "Toto", url: "http://google.com")
        self.coreDataService.saveRecipe(recipe: hit)
        
        
        // set the database to no data
        let persistentStoreDescription = NSPersistentStoreDescription()
            persistentStoreDescription.type = NSInMemoryStoreType
        coreDataService.container.persistentStoreDescriptions = [persistentStoreDescription]
        
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            recipes = try AppDelegate.viewContext.fetch(request)
            numberOfFavoritesRecipes = recipes.count
            numberOfRecipesAfterDeleating = numberOfFavoritesRecipes
        } catch {
            print("error => \(error)")
        }
        print(" HOW MANY ELEMENT IN DATABASE\(AppDelegate.viewContext.accessibilityElementCount())")
        print(" HOW MANY ELEMENT IN DATABASE\(numberOfFavoritesRecipes)")

        // when
        coreDataService.deleteRecipe(recipe: recipes[0])
        
        do {
            recipes = try AppDelegate.viewContext.fetch(request)
            numberOfRecipesAfterDeleating = recipes.count
            print(" HOW MANY ELEMENT IN DATABASE AFTER DELEATING\(numberOfRecipesAfterDeleating)")
        } catch {
            print("error => \(error)")
        }
        
        // then
        XCTAssertNotEqual(numberOfFavoritesRecipes, numberOfRecipesAfterDeleating)
    }
}
