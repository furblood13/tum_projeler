//
//  ViewController.swift
//  project-1
//
//  Created by Furkan buğra karcı on 24.07.2024.
//

import UIKit

class ViewController: UIViewController {

    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
    }
    
    @IBOutlet weak var firstText: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondText: UITextField!
    
    @IBAction func sumBtn(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber=Int(secondText.text!){
                let result=firstNumber+secondNumber
                label.text=String(result)
                
            }
        }
        
       
    }
    
    
    @IBAction func cikarBtn(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber=Int(secondText.text!){
                let result=firstNumber-secondNumber
                label.text=String(result)
                
            }
        }
        
    }
    
    @IBAction func bolBtn(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber=Int(secondText.text!){
                let result=firstNumber/secondNumber
                label.text=String(result)
                
            }
        }
        
    }
    
    @IBAction func carpBtn(_ sender: Any) {
        if let firstNumber = Int(firstText.text!){
            if let secondNumber=Int(secondText.text!){
                let result=firstNumber*secondNumber
                label.text=String(result)
                
            }
        }
        
    }
    
    
    
    
    
    
}

