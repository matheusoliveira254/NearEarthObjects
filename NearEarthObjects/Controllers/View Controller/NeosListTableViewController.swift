//
//  NeosListTableViewController.swift
//  NearEarthObjects
//
//  Created by Matheus Oliveira on 10/4/22.
//

import UIKit

class NeosListTableViewController: UITableViewController {
    //Temporary placeholder for the objects received
    var neosArray: [NearEarthObjects] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Array assignement, passing data to the neosArray using closure.
        NearEarthObjectController.fetchNeos { array in
            guard let array = array else {return}
            DispatchQueue.main.async {
                self.neosArray = array
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neosArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "neosCell", for: indexPath)
        let neosCell = neosArray[indexPath.row]
        cell.textLabel?.text = "\(neosCell.name)"
        cell.detailTextLabel?.text = "Designation: \(neosCell.designation), Collision Possible: \(neosCell.isWorldKiller)"
        return cell
    }
}
