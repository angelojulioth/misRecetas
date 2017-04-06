//
//  Recipe.swift
//  MisRecetas
//
//  Created by Angelo Valderrama on 4/1/17.
//  Copyright © 2017 Angelo Valderrama. All rights reserved.
//
//  Modelo de datos de la clase Receta

import Foundation
import UIKit

class Recipe: NSObject {
    var name : String! //nombre de la receta
    var image : UIImage! //imágen para representar la receta
    var time : Int! //tiempo de cocción
    var ingredients : [String]! //ingredientes de la recete
    var steps : [String]! //pasos para hacer la receta
//    var isFavourite : Bool = false
    var rating : String = "rating"
    
    init(name : String, image : UIImage, time : Int, ingredients : [String], steps : [String]) {
        self.name = name
        self.image = image
        self.time = time
        self.ingredients = ingredients
        self.steps = steps
    }
}
