//
//  ViewController.swift
//  SegueApp
//
//  Created by Furkan buğra karcı on 27.07.2024.
//

import UIKit

class ViewController: UIViewController {
    var username=""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mylabel: UILabel!
    
    @IBAction func nextButton(_ sender: Any) {
        username=nameText.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="toSecondVC"{
            let destinationVC=segue.destination as! SecondVC
            destinationVC.myname=username
            
        }
    }
}

