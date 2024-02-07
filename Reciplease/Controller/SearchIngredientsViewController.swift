//
//  SearchIngredientsViewController.swift
//  Reciplease
//
//  Created by Florian Peyrony on 28/04/2021.
//

import UIKit

class SearchIngredientsViewController: UIViewController, UITextFieldDelegate {
    
    
    var ingredients = ""
    var recipes: [Hit]!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ingredientsListLabel: UILabel!
    @IBOutlet weak var searchForRecipeButton: UIButton!
    
    let listVController = SearchListRecipeViewController()
    
    let alamofireService = RecipeAlamofireService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonsSkin()
        activityIndicator.isHidden = true
        searchForRecipeButton.isHidden = false
    }
    
    
    @IBAction func addIngredient(_ sender: Any) {
        
        if ingredientTextField.text!.isEmpty == true {
            self.presentAlert(title: "Erreur", message: "Veuillez rentrer un ingredient à rechercher")
        } else {
            ingredientsListLabel.text! += "- \(ingredientTextField.text!)\n"
            ingredients += " \(ingredientTextField.text!)"
            print("Les ingrédients sont : \(ingredients) ")
        }
        ingredientTextField.text = ""
    }
    
    @IBAction func searchButton(_ sender: Any) {
        activityIndicator.isHidden = false
        searchForRecipeButton.isHidden = true
        alamofireService.getRecipe(ingredient: ingredients) { [self] (success, data) in
            if success == true {
                self.recipes = data!.hits
                ingredients = ""
                DispatchQueue.main.async {
                    self.ingredientsListLabel.text = ""
                    self.performSegue(withIdentifier: "segueToList", sender: self)
                    self.activityIndicator.isHidden = true
                    self.searchForRecipeButton.isHidden = false
                }
            } else {
                self.presentAlert(title: "OK", message: "Vous n'avez rien dans votre frigot ? Veuillez rentrer un ingredient")
            }
        }
    }
    // changer le prepare for segue vers PresentTableViewCell pour créer les données labas et pas lors du chargement, ca prend trop de temps
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToList" {
            let searchListRecipeViewController = segue.destination as! SearchListRecipeViewController
            searchListRecipeViewController.recipes = recipes
        }
    }
    
    
    @IBAction func clearIngredientsList(_ sender: Any) {
        ingredientsListLabel.text = ""
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientTextField.resignFirstResponder()
        
    }
    func setUpButtonsSkin() {
        searchForRecipeButton.layer.cornerRadius = 20
        searchForRecipeButton.layer.borderWidth = 1
        searchForRecipeButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)
        clearButton.layer.cornerRadius = 10
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = #colorLiteral(red: 0.3289624751, green: 0.3536478281, blue: 0.357570827, alpha: 1)


    }
    
}
