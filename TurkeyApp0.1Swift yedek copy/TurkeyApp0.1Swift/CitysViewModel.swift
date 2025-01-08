//
//  CitysViewModel.swift
//  TurkeyApp0.1Swift
//
//  Created by Furkan buğra karcı on 26.08.2024.
//

import Foundation


class CitysViewModel:ObservableObject{
    @Published var citys:[City] = []
    @Published var isloading = false
    
    
    func fetchDutyCitys(){
        isloading=true
        guard let url=URL(string:"https://raw.githubusercontent.com/furblood13/deneme/main/illerjsondeneme.json")else{
            print("Geçersiz URL") 
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod="GET"
        
        let session=URLSession.shared
        session.dataTask(with: request){[weak self] data,response,error in DispatchQueue.main.async{self?.isloading=false}
            if let jsondata=data, let _ = String(data:jsondata,encoding: .utf8){
                
            }
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Veri alınamadı")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode([City].self, from: data)
                
                    DispatchQueue.main.async{
                        self?.citys = decodedResponse
                    }
                
            }
            catch let DecodingError.dataCorrupted(context) {
                print("Veri bozulmuş: \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Anahtar bulunamadı: \(key) context: \(context)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Tip uyuşmazlığı: \(type) context: \(context)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Değer bulunamadı: \(value) context: \(context)")
            } catch {
                print("Genel hata: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
}
