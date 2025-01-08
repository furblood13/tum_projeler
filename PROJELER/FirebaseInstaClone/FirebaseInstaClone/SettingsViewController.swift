//
//  SettingsViewController.swift
//  FirebaseInstaClone
//
//  Created by Furkan buğra karcı on 1.08.2024.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do  {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch{
            print("error")
        }
    }
    
    
    
    
}
