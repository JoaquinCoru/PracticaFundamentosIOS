//
//  TableViewCell.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 16/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    
    func set(model: Hero) {
      heroName.text = model.name
      heroDescription.text = model.description
      heroImage.setImage(url: model.photo)
    }
    
    func setTransformation (model:Transformation){
        heroName.text = model.name
        heroDescription.text = model.description
        heroImage.setImage(url: model.photo)
    }
}
