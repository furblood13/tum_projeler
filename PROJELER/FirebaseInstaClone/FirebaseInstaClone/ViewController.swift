//
//  ViewController.swift
//  FirebaseInstaClone
//
//  Created by Furkan buğra karcı on 1.08.2024.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

    
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            //bu da giriş için firebase bizim için kullanıcının olup olmadığıı kontrol ediyo
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(message: error?.localizedDescription ?? "Error")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        else{
            makeAlert(message: "Please fill all the blank areas")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        //email ve şifre boş mu dolu mu diye kontrol ediyoz boş yer varsa alert gösteriyoz
        if emailText.text=="" || passwordText.text==""{
            makeAlert(message:"Please fill all the blank areas")
            //aşşada da
        }else{
            //kullanıcıyı oluşturuyoz mail ve şifreyi kendi uygdakine eşitliyoz eğerki bi hata oldmadıysa feed ekranına segue yapıoz
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(message: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        
    }
    func makeAlert(message:String){
        let alert = UIAlertController(title: "ERROR", message:message , preferredStyle: UIAlertController.Style.alert)
         let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okbutton)
         self.present(alert, animated: true, completion: nil)
         //yukaradkilerin hepsi minicik bi alert yazmak için amk
        
    }
}

