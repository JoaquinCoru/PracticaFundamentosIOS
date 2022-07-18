//
//  HeroesTableViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 16/7/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    var heroes: [Hero] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Heroes"
     //   LocalDataModel.deleteToken()
        
        tableView?.register(
          UINib(nibName: "TableViewCell", bundle: nil),
          forCellReuseIdentifier: "reuseIdentifier")
        
        guard let token = LocalDataModel.getToken() else {
          return
        }
        
        let networkModel = NetworkModel(token: token)
        
        networkModel.getHeroes { [weak self] heroes, _ in
          guard let self = self else { return }
          
          self.heroes = heroes
          
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
          return UITableViewCell()
        }
        
        cell.set(model: heroes[indexPath.row])
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = DetailViewController()
        
        nextVC.set(model: heroes[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
