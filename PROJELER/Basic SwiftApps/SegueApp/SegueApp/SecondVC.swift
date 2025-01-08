//
//  SecondVC.swift
//  SegueApp
//
//  Created by Furkan buğra karcı on 27.07.2024.
//

import UIKit

class SecondVC: UIViewController {
    @IBOutlet weak var SecondVControllerLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var myname=""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text=myname
        

        // Do any additional setup after loading the view.
    }
    

    
    
}
