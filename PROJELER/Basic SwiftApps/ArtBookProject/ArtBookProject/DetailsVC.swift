//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Furkan buğra karcı on 29.07.2024.
//

import UIKit
import CoreData
class DetailsVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    var chosenPainting=""
    var chosenPaintingID:UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenPainting != "" {
            
            let appDelegate=UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString=chosenPaintingID?.uuidString
            fetchRequest.predicate=NSPredicate(format: "id = %@", idString!)
            
            fetchRequest.returnsObjectsAsFaults=false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count>0{
                    for result in results as![NSManagedObject]{
                        if let name=result.value(forKey: "name") as? String{
                            nameText.text=name
                        }
                        if let artist=result.value(forKey: "artist") as? String{
                            artistText.text=artist
                        }
                        if let year=result.value(forKey: "year") as? Int{
                            yearText.text=String(year)
                        }
                        if let imageData=result.value(forKey: "image") as? Data{
                            let image=UIImage(data:imageData)
                            imageView.image=image
                        }
                    }
                }
            }
            catch{
                
            }
            
        }else{
            
        }
        let gestureR=UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(gestureR)
        imageView.isUserInteractionEnabled=true
        let imageTapReognizer=UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapReognizer)
    }
    
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    @objc func selectImage(){
        let picker=UIImagePickerController()
        picker.delegate=self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image=info[.originalImage ] as? UIImage
        self.dismiss(animated: true)
    }
    @IBAction func saveButoonClicked(_ sender: Any) {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let newPainting=NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        if let year=Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data=imageView.image?.jpegData(compressionQuality: 0.4)
        
        newPainting.setValue(data, forKey: "image")
        do{
            try context.save()
            print("islem basarili")
        }catch{
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
