//
//  ListViewController.swift
//  MapApp
//
//  Created by Furkan buğra karcı on 30.07.2024.
//

import UIKit
import CoreData
class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    var titleArray=[String]()
    var idArray=[UUID]()
    var chosenTitle = ""
    var chosenTitleId:UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        //sisteimn en üstüne + butonu eklemek için
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector( addButtonClicked))//burakadar
        tableView.dataSource=self
        tableView.delegate=self
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
   @objc func getData(){
        //verileri çekmek için olan fonksiyon
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        //Places db sinden request getircek
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults=false
        do{
            let results = try context.fetch(request)
            
            if results.count>0{
                self.titleArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject]{
                    //dbdeki title isimlileri oluşturduğumuz değişken olan titleArray e atma işlemi
                    if let title = result.value(forKey: "title") as? String{
                        self.titleArray.append(title)
                    }
                    //dbdeki id isimlileri oluşturduğumuz değişken olan idArray e atma işlemi
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                    tableView.reloadData()
                }
                
            }
        }catch{
            
        }
    }
    //butona tıklanıldığında ne olacağı
    @objc func addButtonClicked(){
        chosenTitle=""
        performSegue(withIdentifier: "ToViewController", sender: nil)
    }
    //kaç tane satır olacak cevap olarak int dönüyo biz de isim arrayinin uzunluğu kadar bir görünüm oluşturuyoruz
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    //her satırda ne yazacak(titleArrayde hangi indexdeyse o)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle=titleArray[indexPath.row]
        chosenTitleId=idArray[indexPath.row]
            performSegue(withIdentifier: "ToViewController", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ToViewController"{
            let destinationVC=segue.destination as! ViewController
            destinationVC.selectedTitle=chosenTitle
            destinationVC.selectedTitleId=chosenTitleId
            
        }
    }

}
