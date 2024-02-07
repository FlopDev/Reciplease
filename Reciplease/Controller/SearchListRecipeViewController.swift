//
//  SearchListRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 28/04/2021.
//

import UIKit

class SearchListRecipeViewController: UIViewController {
    
    var recipes: [Hit]!
    let recipe = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipe = sender as? Hit,
           let destination = segue.destination as? SearchRecipeFoundedViewController,
           segue.identifier == "segueToFavoriteRecipe" {
            destination.recipe = recipe
            print("this is the recipe \(recipe)")
        }
    }

}

extension SearchListRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentRecipeCell", for: indexPath) as? PresentTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row].recipe
        let igredients = recipe.ingredients
            .map { $0.text }
            .joined(separator: ", ")
        cell.configure(recipeName: recipe.label,
                       recipeIngredients: "\(igredients)",
                       recipeTime: Double((recipe.totalTime)),
                       forXpeople: recipe.yield, image: recipe.image)
        return cell
    }
 
}
extension SearchListRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("u tape on this cell")
        let selectRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteRecipe", sender: selectRecipe)
    
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            recipes.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
