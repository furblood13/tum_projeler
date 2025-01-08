//
//  ViewController.swift
//  Currency Converter
//
//  Created by Furkan buğra karcı on 31.07.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        //apiye bağlanma ve error handling
        let url=URL(string: "http://data.fixer.io/api/latest?access_key=af127e2f66327d59dfb23c2944a74146&format=1")

        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert=UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
                //bura kadar
            }
            //veriyi alma
            else{
                if data != nil{
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                        DispatchQueue.main.async{                                //YUKARDA Dictinoarye çevirdik veri o şekilde geldiği için
                            //bura kadar
                            
                            //rates de kendi içinde ayrı bir dictionary onun içindeki verilere ulaşmak içinde ilk satırdakini yapioz
                            if let rates=jsonResponse["rates"] as? [String:Any]{
                                if let cad = rates["CAD"] as? Double{
                                    self.cadlabel.text="CAD:\(String(cad))"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text="CHF:\(String(chf))"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text="GBP:\(String(gbp))"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text="JPY:\(String(jpy))"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text="USD:\(String(usd))"
                                }
                                if let turk = rates["TRY"] as? Double{
                                    self.tryLabel.text="TRY:\(String(turk))"
                                }
                            }
                        }
                    }catch{
                        print("error")
                    }
                }
            }
        }
        task.resume()
        
    }
    
    
}

