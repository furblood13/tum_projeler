//
//  FeedViewController.swift
//  FirebaseInstaClone
//
//  Created by Furkan buğra karcı on 1.08.2024.
//

import UIKit
import FirebaseFirestore
import Firebase
import SDWebImage
class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userEmailArray=[String]()
    var userCommentArray=[String]()
    var likeArray=[Int]()
    var userImageArray=[String]()
    var documentIdArray=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate=self
        tableView.dataSource=self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        //firestoredaki posts koleksiyonundan datalari getir
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print(error!.localizedDescription) 
            }
            else{
                if snapshot?.isEmpty != true{
                    
                    //alttaki 4 satır kod kullanıcı yeni foto eklediği zaman diziyi yinelemeyi engelliyo bunu yapmazsak 2 kayıtın ustune 3. kayıt eklendiği zaman ve butona tıkllandığ zaman önceki kayıtları da tekrardan yazdırıyo
                     self.userImageArray.removeAll(keepingCapacity: false)
                     self.userEmailArray.removeAll(keepingCapacity: false)
                     self.userCommentArray.removeAll(keepingCapacity: false)
                     self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                      //datalar boş değilse firestoreda postedby ın karşısında kim yazıyosa onu kendi olışstıdıhmız arraye eklız
                        if let postedBy=document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment=document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes=document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl=document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        
        
    }

    //table viewin rowlarını gösterdik
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }//main de cell in identfierına FeedCell i tanımladığımız için burda da feedcell i çağırarak bir cellin içine kendi istedikerimizi yazdırabiliyoz
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text=userEmailArray[indexPath.row]
        cell.commentLabel.text=userCommentArray[indexPath.row]
        cell.likeLabel.text=String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text=documentIdArray[indexPath.row]
        return cell
    }
   

}
