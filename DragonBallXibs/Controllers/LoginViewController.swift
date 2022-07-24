//
//  LoginViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 10/7/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LocalDataModel.getToken() != nil{
            goToHeroesList()
        }else{
            userTextField.center.x -= view.bounds.width
            passwordTextField.center.x -= view.bounds.width
            
            UIView.animate(withDuration: 0.75,
                           delay: 0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
              self.userTextField.center.x += self.view.bounds.width
            }, completion: nil)
            
            UIView.animate(withDuration: 0.75,
                           delay: 0.4,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
              self.passwordTextField.center.x += self.view.bounds.width
            }, completion: nil)
            
            UIView.animate(withDuration: 1) {
              self.loginButton.alpha = 1
            }
        }
        

    }

    @IBAction func onLoginTap(_ sender: Any) {
        
        let model = NetworkModel()
        let user = userTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        
        guard !user.isEmpty, !password.isEmpty else {
          showAlert(title: "Missing fields", message: "please complete all fields to login")
          return
        }
        
        loginButton.isEnabled = false
        activityIndicator.startAnimating()
        
        model.login(user: user, password: password) {[weak self] token, error in
            
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                  self?.showAlert(title: "There was an error", message: error.localizedDescription)
                  return
                }
                
                guard let token = token, !token.isEmpty else {
                  self?.showAlert(title: "There is no token")
                  return
                }
                
                LocalDataModel.save(token: token)
                
                self?.userTextField.text = ""
                self?.passwordTextField.text = ""
                
                self?.goToHeroesList()
            }
        
        }
                    
    }
    
    func goToHeroesList(){
        let heroesTableViewController = HeroesTableViewController()
        
        let settingsViewController = SettingsViewController()
        
        let navigationController = UINavigationController()
        
        let tabBarController = UITabBarController()
        
        tabBarController.title = "Heroes"
        
        heroesTableViewController.title = "Heroes"
        heroesTableViewController.tabBarItem.image = UIImage(systemName: "table")
        settingsViewController.title = "Settings"
        settingsViewController.tabBarItem.image = UIImage(systemName: "gear")
        
        tabBarController.setViewControllers([heroesTableViewController,settingsViewController], animated: true)
        
        navigationController.setViewControllers([tabBarController], animated: true)
        
        
     //   navigationController.setViewControllers([heroesTableViewController], animated: false)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    

}
