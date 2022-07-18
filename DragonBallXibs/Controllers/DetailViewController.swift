//
//  DetailViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 16/7/22.
//

import UIKit

private enum Constants {
  static let normalImageHeight = 200.0
}

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var hero:Hero?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        guard let hero = hero else {
          return
        }
        
        self.title = hero.name
        
        self.imageView.setImage(url: hero.photo)
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
    }
    
    func set(model: Hero) {
      hero = model
    }

}

extension DetailViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let correctedOffset = scrollView.contentOffset.y
    imageHeight.constant = Constants.normalImageHeight - correctedOffset
  }
}
