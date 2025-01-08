//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Furkan buğra karcı on 29.07.2024.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray=[String]()
    var idArray=[UUID]()
    var selectedPainting=""
    var selectedPaintingID:UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButoonClicked))
        // Do any additional setup after loading the view.
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
   @objc func getData(){
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelagate.persistentContainer.viewContext
        
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults=false
        
        do{
          let results =  try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? String{
                    self.nameArray.append(id)
                }
                self.tableView.reloadData()
            }
        }catch{
            print("error")
        }
    }
    @objc func addButoonClicked(){
        selectedPainting=""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=nameArray[indexPath.row]
        return  cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toDetailsVC"{
            let destinationVC=segue.destination as! DetailsVC
            destinationVC.chosenPainting=selectedPainting
            destinationVC.chosenPaintingID=selectedPaintingID
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting=nameArray[indexPath.row]
        selectedPaintingID=idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

