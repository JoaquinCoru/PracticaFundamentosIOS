//
//  TransformationsTableViewController.swift
//  DragonBallXibs
//
//  Created by Joaquín Corugedo Rodríguez on 18/7/22.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    private var transformations:[Transformation] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transformaciones"

        tableView?.register(
          UINib(nibName: "TableViewCell", bundle: nil),
          forCellReuseIdentifier: "reuseIdentifier")
        
        transformations.sort {
            $0.name < $1.name
        }
    }
    
    func setTransformations(transformations:[Transformation]){
        self.transformations = transformations
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TableViewCell else {
          return UITableViewCell()
        }
        
        cell.setTransformation(model: transformations[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        
        nextVC.setTransformation(model: transformations[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }


    
}
