//
//  ViewController.swift
//  SimpsonsBook
//
//  Created by Furkan buğra karcı on 29.07.2024.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource
{ var mysimpsons=[Simpsons]()
    var chosenSimpson:Simpsons?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
        tableView.delegate=self
        
        let homer=Simpsons(name: "Homer Simpson", job: "Nuclear Worker", image: UIImage(named: "Homer_Simpson")!)
        let bart=Simpsons(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart-simpson")!)
        let s=Simpsons(name: "S", job: "idk", image: UIImage(named: "s")!)
        mysimpsons.append(homer)
        mysimpsons.append(bart)
        mysimpsons.append(s)
    }

    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mysimpsons.count
            
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell=UITableViewCell()
        cell.textLabel?.text=mysimpsons[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson=mysimpsons[indexPath.row]
        self.performSegue(withIdentifier: "ToDetailsVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ToDetailsVC"{
            let destinationVC=segue.destination as!DetailsVC
            destinationVC.selectedSimpson=chosenSimpson
        }
    }
    
}

