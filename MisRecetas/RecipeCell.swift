//
//  RecipeCell.swift
//  MisRecetas
//
//  Created by Angelo Valderrama on 4/3/17.
//  Copyright © 2017 Angelo Valderrama. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell { 
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var ingredientsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
