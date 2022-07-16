//
//  HeroesTableViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 16/7/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Heroes"
        
        tableView?.register(
          UINib(nibName: "TableViewCell", bundle: nil),
          forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
          return UITableViewCell()
        }
        
        cell.heroName.text = "Goku"
        
        cell.heroDescription.text = "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle."
        
        cell.heroImage.setImage(url:URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")!)

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = DetailViewController()
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
