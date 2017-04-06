//
//  ViewController.swift
//  MisRecetas
//
//  Created by Angelo Valderrama on 4/1/17.
//  Copyright © 2017 Angelo Valderrama. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var recipes : [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.separatorColor = #colorLiteral(red: 0.839550674, green: 0.8775880933, blue: 0.870023787, alpha: 1)
        
        var recipe = Recipe(name: "Tortilla de patatas",
                            image: #imageLiteral(resourceName: "tortilla"),
                            time: 20,
                            ingredients: ["Patatas", "Huevos", "Cebollas"],
                            steps: ["Pelar las patatas y la cebolla",
                                    "Cortar las patatas y la cebolla y sofreir",
                                    "Batir los huevos y echarlos durante un minuto en la sartén con el resto"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Pizza margarita",
                        image: #imageLiteral(resourceName: "pizza"),
                        time: 60,
                        ingredients: ["Harina", "Levadura", "Aceite", "Sal", "Salsa de tomate", "Queso"],
                        steps: ["Hacemos la masa con harina, levadura, aceite y sal",
                                "Dejamos reposar la masa treinta minutos",
                                "Extendemos la masa encima de una bandeja y añadimos el resto de ingredientes",
                                "Hornear durante doce minutos"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Hamburgesa con queso",
                        image: #imageLiteral(resourceName: "hamburgesa"),
                        time: 10,
                        ingredients: ["Pan de hamburgesa", "Lechuga", "Tomate", "Queso", "Carne de hamburgesa"],
                        steps: ["Poner al fuego la carne al gusto", "Montar la hamburgesa con sus ingredientes entre los panes"])
        recipes.append(recipe)
        
        recipe = Recipe(name: "Ensalada César",
                        image: #imageLiteral(resourceName: "ensalada"),
                        time: 15,
                        ingredients: ["Lechuga", "Tomates", "Pimientos", "Salsa César", "Pollo"],
                        steps: ["Limpiar todas las verduras y trocearlas",
                                "Cocer el pollo al gusto",
                                "Juntar todos los ingredientes en una ensaladera y servir con salsa césar encima"])
        recipes.append(recipe)
        
        print(recipes[0].name)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // función para ocultar y mostrar la barra de navegación al hacer swipe
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // habilitar ocultar la barra de navegación al hacer swipe
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cellID = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        cell.recipeImage.image = recipe.image!
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = "\(recipe.time!) min"
        cell.ingredientsLabel.text = "\(recipe.ingredients.count) ingredientes necesarios"
        cell.recipeImage.layer.cornerRadius = 42
        cell.recipeImage.clipsToBounds = true
        
        // Mostrar accesory type de la celda si la propiedad isFavourite es verdadera
        /*
        if recipe.isFavourite {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        
        return cell
    }
    
    /*
    // Función del modelo de datos que sirve para borrar deslizando una celda
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
    }
    */
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Añadir acción de compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let shareDefaultText = "Estoy viendo la receta de \"\(self.recipes[indexPath.row].name!)\" en la App del curso de iOS 10 con Juan Gabriel"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.recipes[indexPath.row].image!], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        } // fin de declaración de acción
        // Establecer el color de fondo para la acción
        shareAction.backgroundColor = #colorLiteral(red: 0.3921828568, green: 0.8795291185, blue: 0.7727074623, alpha: 1)
        
        //Añadir acción de borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            // Remover elemento de la celda seleccionada del modelo de datos
            self.recipes.remove(at: indexPath.row)
            
            // Una vez establecido el valor bool de la propiedad isFavourite para de esa manera agregar el accesory type
            // checkbox, se necesita refrescar la table view(en la posición establecida ya que recargar toda la vista sería
            // una tarea ineficiente si se trata de refrescar una sóla celda de la vista)  para que el accesory type se muestre
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // Esteblecer color de fondo para la acción de borrar
        deleteAction.backgroundColor = #colorLiteral(red: 0.9200661778, green: 0.1565550268, blue: 0.384498477, alpha: 1)
        
        return [shareAction, deleteAction]
    }
    
    
    
    
    // MARK: UITableViewDelegate
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let recipe = self.recipes[indexPath.row]
        
        // Crear un controlador UIController
        let alertController = UIAlertController(title: recipe.name, message: "Valora este plato", preferredStyle: .actionSheet)
        // Crear acciones(botones) para el controlador
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        // Cambiar el texto entre favourite y non favourite dependiendo de la propiedad de la receta
        var favouriteActionTitle = "Añadir a favorito"
        var favouriteActionStyle = UIAlertActionStyle.default
        if recipe.isFavourite {
            favouriteActionTitle = "Quitar favorito"
            favouriteActionStyle = UIAlertActionStyle.destructive
        }
        let favouriteAction = UIAlertAction(title: favouriteActionTitle, style: favouriteActionStyle) { (action) in
            let recipe = self.recipes[indexPath.row]
            recipe.isFavourite = !recipe.isFavourite
            
            self.tableView.reloadData()
        }

        // asignar acciones al controlador
        alertController.addAction(cancelAction)
        alertController.addAction(favouriteAction)
        // Presentar controlador
        self.present(alertController, animated: true, completion: nil)
    }
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedRecipe =  self.recipes[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.recipe = selectedRecipe
            }
        }
    }
}

