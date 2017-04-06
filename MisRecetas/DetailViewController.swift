 //
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Angelo Valderrama on 4/3/17.
//  Copyright © 2017 Angelo Valderrama. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeTimeLabel: UILabel!
    @IBOutlet var detailInfoStackView: UIStackView!
    
    @IBOutlet var detailsTableView: UITableView!
    
    @IBOutlet var ratingButton: UIButton!
    
    // close the modal segue
    @IBAction func close(segue: UIStoryboardSegue) {
        if let reviewVC = segue.source as? ReviewViewController {
            if let rating = reviewVC.ratingSelected {
                self.recipe.rating = rating
                let image = UIImage(named: self.recipe.rating)
                self.ratingButton.setImage(image, for: .normal)
            }
        }
    }
    var recipe : Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // establecer la imagen del rating
        let image = UIImage(named: self.recipe.rating)
        self.ratingButton.setImage(image, for: .normal)
        
        // configurar self sizing cells para la table view
        self.detailsTableView.estimatedRowHeight = 44
        self.detailsTableView.rowHeight = UITableViewAutomaticDimension
        
        // asignar la imagen de la receta a la recipeImageView
        self.recipeImageView.image = self.recipe.image
        // Asignar nombre de la receta y el tiempo de preparación en sus respectivas labels
        self.recipeNameLabel.text = self.recipe.name
        self.recipeTimeLabel.text = "Tiempo de preparación: \(recipe.time!) minutos"

        // Do any additional setup after loading the view.
        // MARK: BlurEffectToStackView
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            //always fill the view
            blurEffectView.frame = self.detailInfoStackView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.detailInfoStackView.insertSubview(blurEffectView, at: 0) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            let backgroundOnDisabledTransparency = UIView(frame: self.detailInfoStackView.bounds)
            backgroundOnDisabledTransparency.backgroundColor = UIColor.black
            backgroundOnDisabledTransparency.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.detailInfoStackView.insertSubview(backgroundOnDisabledTransparency, at: 0)
        }
        // End of blur Effect to stackView
        
        // modificación de la apariencia del table view
        self.detailsTableView.backgroundColor = #colorLiteral(red: 0.4756116867, green: 0.8995105624, blue: 0.9493601918, alpha: 1)
        // establecer el color de fondo de separador
        self.detailsTableView.separatorColor = #colorLiteral(red: 0.839550674, green: 0.8775880933, blue: 0.870023787, alpha: 1)
        
        // establecer el título de la barra de navegación al nombre de la receta
        self.title = self.recipe.name
        
        // establecer el footer(celdas de sobra) de la table view a una configuración de vista sin tamaño
        self.detailsTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // Función para deshabilitar la acción de ocultar la barra de navegación al hacer swipe
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // deshabilitar ocultar la barra de navegación al hacer swipe
        navigationController?.hidesBarsOnSwipe = false
        // mostrar la barra de navegación en caso de que se hubiera ocultado en la vista anterior
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ratingButtonPerform(_ sender: Any) {
        performSegue(withIdentifier: "showReview", sender: sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reviewVC = segue.destination as? ReviewViewController {
            reviewVC.recipe = self.recipe
        }
    }
    
    
    override var prefersStatusBarHidden: Bool { return true }

}
 

 extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return self.recipe.ingredients.count
        case 2:
            return self.recipe.steps.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRecipeCell", for: indexPath) as! recipeDetailViewCell
        
        // establecer el color de fondo de las celdas
        cell.backgroundColor = #colorLiteral(red: 0.9849129319, green: 0.9881878495, blue: 0.9881268144, alpha: 1)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre:"
                cell.valueLabel.text = self.recipe.name
            case 1:
                cell.keyLabel.text = "Tiempo:"
                cell.valueLabel.text = "\(self.recipe.time! ) min"
            /*case 2:
                cell.keyLabel.text = "Favorita:"
                if self.recipe.isFavourite {
                    cell.valueLabel.text = "Sí"
                } else {
                    cell.valueLabel.text = "No"
                }*/
            default:
                break
            }
        
        case 1:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Ingredientes:"
            } else {
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = "● \(self.recipe.ingredients[indexPath.row])"
        case 2:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Pasos:"
            } else {
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = self.recipe.steps[indexPath.row]
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch section {
        case 0:
            title = "Detalles"
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break
        } // end of switch
        return title
    } // end of function
 }


 extension DetailViewController : UITableViewDelegate {
    
 }
