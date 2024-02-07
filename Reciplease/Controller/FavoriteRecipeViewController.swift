//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 29/04/2021.
//

import UIKit

class FavoriteRecipeViewController: UIViewController {

    @IBOutlet weak var recipePictureImageView: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var timeToPrepare: UILabel!
    @IBOutlet weak var encartView: UIView!
    @IBOutlet weak var getDirectionButton: UIButton!
    
    @IBOutlet weak var forXPeople: UILabel!
    var recipe: FavoriteRecipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDirectionButton.layer.cornerRadius = 20
        getDirectionButton.layer.borderWidth = 1
        getDirectionButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        encartView.layer.borderColor = UIColor.gray.cgColor
        encartView.layer.borderWidth = 1.0
        ingredientsListLabel.text = recipe.ingredients
        recipeName.text = recipe.recipeName
        timeToPrepare.text = "\(recipe.timeToPrepare) min"
        forXPeople.text = "for \(recipe.forXpeople)p"
        
        getImage()
    }
    
    @IBAction func getDirection(_ sender: Any) {
        if let urlToOpen = URL(string: "\(recipe.url!)") {
           UIApplication.shared.open(urlToOpen)
        } else {
            presentAlert(title: "Error", message: "Sorry, we can't open this URL")
       }
    }
    
    func getImage() {
       let url = URL(string: recipe.image!)!
    if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
               recipePictureImageView.image = UIImage(data: data)
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
