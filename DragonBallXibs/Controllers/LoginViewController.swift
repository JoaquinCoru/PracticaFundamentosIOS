//
//  LoginViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 10/7/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTestField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginTap(_ sender: Any) {
        let navigationController = UINavigationController()
        
        let heroesTableViewController = HeroesTableViewController()
        
        navigationController.setViewControllers([heroesTableViewController], animated: false)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
        
    
    }
    

}
