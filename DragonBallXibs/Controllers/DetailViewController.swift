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
    
    @IBOutlet weak var transformsButton: UIButton!
    private var hero:Hero?
    private var transformation:Transformation?
    
    var transformations:[Transformation]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformsButton.alpha = 0
        
        scrollView.delegate = self

        
        if let hero = hero {
            self.title = hero.name
            
            self.imageView.setImage(url: hero.photo)
            self.nameLabel.text = hero.name
            self.descriptionTextView.text = hero.description
            
            checkTransformations()
        }
        
        if let transformation = transformation {
            
            self.imageView.setImage(url: transformation.photo)
            self.nameLabel.text = transformation.name
            self.descriptionTextView.text = transformation.description
        }
        

    }
    
    
    func set(model: Hero) {
      hero = model
    }
    
    func setTransformation(model:Transformation){
        transformation = model
    }
    
    func checkTransformations(){
        guard let token = LocalDataModel.getToken() else {
          return
        }

        let networkModel = NetworkModel(token: token)
        
        networkModel.getTransformations(id: hero?.id ?? "") { [weak self] transformations, _ in
            guard let self = self else { return }
            
            self.transformations = transformations
            
            DispatchQueue.main.async {
                if !transformations.isEmpty {
                    self.transformsButton.alpha = 1
                }
            }
            
        }
    }


    @IBAction func onTransformationsTap(_ sender: Any) {
        
        let nextVC = TransformationsTableViewController()
        
        nextVC.setTransformations(transformations: transformations)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension DetailViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let correctedOffset = scrollView.contentOffset.y
    imageHeight.constant = Constants.normalImageHeight - correctedOffset
  }
}
