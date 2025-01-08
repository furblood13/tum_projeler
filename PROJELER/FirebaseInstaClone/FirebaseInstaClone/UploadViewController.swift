//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by Furkan buğra karcı on 1.08.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
class UploadViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //foto seçmek için imageviewi tıklanabilir yapma
        imageview.isUserInteractionEnabled=true
        let gestureR=UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageview.addGestureRecognizer(gestureR)
    }
    
    @objc func chooseImage(){
        //tıklandığında galeriyi açma foto seçebilme
        let pickerController=UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    //seçilen fotoyu imageview a set etme
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image=info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleMessage:String){
        let alert=UIAlertController(title:"Error", message: titleMessage, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        //FOTOYU FİREBASEE KAYDETMEK
        let storage=Storage.storage()
        let storageReference=storage.reference()
        //media isimli bir folderu oluşturuyoz hali hazırda varsada onu seçiyoz
        let mediaFolder=storageReference.child("media")
        //fotonun kayıt kalitesini seçioz
        if let data=imageview.image?.jpegData(compressionQuality: 0.5){
            //fotoların ismi aynı olursa sadece aynı fotolar kayıt olur bu yüzden uuıd oluşturup ismine onu veriyoz
            let uuid=UUID().uuidString
            let imageReferance=mediaFolder.child("\(uuid).jpg")
            //fotoyu putdata metodunu kullanarak kaydediyoz metadata açıklması gibi bişe önemsiz error yoksa da urlsini yazdırıyoz aşşası önemsiz
            imageReferance.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    self.makeAlert(titleMessage: error!.localizedDescription)
                }else{
                    imageReferance.downloadURL { url, error in
                        if error == nil{
                            let imageurl=url?.absoluteString
                            
                            
                            let firestoreDatabase=Firestore.firestore()
                            var firestoreReferance: DocumentReference? = nil
                            //dictionary oluşsturup firestora uygun şekilde verileri atmak için aşşasakini oluşturuyoz
                            let firestorePost=["imageUrl": imageurl!,"postedBy": Auth.auth().currentUser!.email!,"postComment":self.commentText.text!,"date":FieldValue.serverTimestamp(),"likes":0]
                            
                            //burda da post isimli koleksiyona döküman olarak ekliyoz
                            firestoreReferance=firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    self.makeAlert(titleMessage: error?.localizedDescription ?? "Error")
                                }
                                else{
                                    self.imageview.image=UIImage(named: "aw")
                                    self.commentText.text=""
                                    self.tabBarController?.selectedIndex=0}
                            })
                        }
                    }
                }
            }
        }
        
    }
}
