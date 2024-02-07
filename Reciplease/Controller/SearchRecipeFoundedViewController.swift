//
//  SearchRecipeFoundedViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 28/04/2021.
//

import UIKit

class SearchRecipeFoundedViewController: UIViewController {
    
    let coreDataService = SaveFavoriteRecipe()

    @IBOutlet weak var recipePictureImageView: UIImageView!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var makeFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var encartView: UIView!
    
    @IBOutlet weak var getDirectionButton: UIButton!
    var recipe: Hit!
    @IBOutlet weak var recipeTime: UILabel!
    
    @IBOutlet weak var forXPeople: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDirectionButton.layer.cornerRadius = 20
        getDirectionButton.layer.borderWidth = 1
        getDirectionButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        encartView.layer.borderColor = UIColor.gray.cgColor
        encartView.layer.borderWidth = 1.0
        
        // replace the format of data to a list
        let ingredients = "\(recipe.recipe.ingredientLines)"
        let ingredientsList = ingredients
            .replacingOccurrences(of: "[", with: "-")
            .replacingOccurrences(of: ",", with: "\n-")
        
        ingredientsListLabel.text = ingredientsList
        
        recipeName.text = "\(recipe.recipe.label)"
        recipeTime.text = "\(recipe.recipe.totalTime) min"
        forXPeople.text = "for \(recipe.recipe.yield)p"
        getImage()
         
    }
    
    func getImage() {
        let url = URL(string: recipe.recipe.image)!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
               recipePictureImageView.image = UIImage(data: data)
           }
    }
    
    
    @IBAction func makeFavorite(_ sender: Any) {
        makeFavoriteButton.isEnabled = true
        coreDataService.saveRecipe(recipe: recipe)
       // makeFavoriteButton.image = UIImage(named: "star.fill")
    }
    
    @IBAction func getDirection(_ sender: Any) {
        if let urlToOpen = URL(string: "\(recipe.recipe.url)") {
            UIApplication.shared.open(urlToOpen)
        } else {
            presentAlert(title: "Error", message: "Sorry, we can't open this URL")
        }
    }
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}

