//
//  DetailsVC.swift
//  SimpsonsBook
//
//  Created by Furkan buğra karcı on 29.07.2024.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedSimpson:Simpsons?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text=selectedSimpson?.name
        jobLabel.text=selectedSimpson?.job
        imageView.image=selectedSimpson?.image
        // Do any additional setup after loading the view.
    }
    

   
}
