//
//  FavoriteListRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 11/05/2021.
//

import UIKit
import CoreData

class FavoriteListRecipeViewController: UIViewController {
    var recipes: [FavoriteRecipe] = []
    
    let coreDataService = SaveFavoriteRecipe()



    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            recipes = try AppDelegate.viewContext.fetch(request)
            tableView.reloadData()
        } catch {
            print("error => \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? FavoriteRecipe,
           let destination = segue.destination as? FavoriteRecipeViewController,
           segue.identifier == "segueToFavoriteRecipeSaved" {
            destination.recipe = recipe
        } else {
            print("error")
        }
    }
}

extension FavoriteListRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentFavoriteRecipeCell", for: indexPath) as? PresentFavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        let ingredients = recipe.ingredients
        
        cell.configure(recipeName: recipe.recipeName!, recipeIngredients: ingredients!, forXpeople: Int(recipe.forXpeople), recipeTime: Double(recipe.timeToPrepare), image: recipe.image!)
        return cell
    }
}

extension FavoriteListRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("u tape on this cell")
        let selectFavoriteRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteRecipeSaved", sender: selectFavoriteRecipe)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            let selectFavoriteRecipe = recipes[indexPath.row]
            AppDelegate.viewContext.delete(selectFavoriteRecipe)
            recipes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
            
        }
    }
}
