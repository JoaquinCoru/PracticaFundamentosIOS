//
//  SettingsViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 22/7/22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }

    @IBAction func onLogOutButtonTap(_ sender: Any) {
        
        LocalDataModel.deleteToken()
        
        dismiss(animated: false)
    }
    

}
