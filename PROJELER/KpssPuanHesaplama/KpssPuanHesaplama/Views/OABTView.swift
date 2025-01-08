//
//  EgitimBilimleriView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI

struct OABTView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var gkDogrusayisi:Double=30
    @State private var gkYanlissayisi:Double=0
    
    @State private var gyDogrusayisi:Double=30
    @State private var gyYanlissayisi:Double=0
    
    @State private var ebDogrusayisi:Double=40
    @State private var ebYanlissayisi:Double=0
    
    @State private var oabtDogrusayisi:Double=40
    @State private var oabtYanlissayisi:Double=0
    
    @State private var sonuc2022:Double = 0
    @State private var sonuc2023:Double = 0
    @State private var sonucEB2023:Double = 0
    @State private var sonucEB2022:Double = 0
    
    @State private var sonucOABT2022:Double = 0
    @State private var sonucOABT2023:Double = 0
    
    @State private var isShowingSheet = false
    
    @State private var oabtKatsayi  = 0.4334
    @State private var oabtPuan     = 43.805
    
    
    @State private var selectedOption = 0
    let options = [
        (0.4334,43.805, "Beden Eğitimi"),
        (0.3666,41.071, "Biyoloji"),
        (0.4301,39.060, "Coğrafya"),
        (0.4052,34.908, "Din Kültürü"),
        (0.3679,42.156, "Edebiyat"),
        (0.5388,39.313, "Fen Bilgisi"),
        (0.3817,41.604, "Fizik"),
        (0.5225,36.309, "İlköğretim Matematik"),
        (0.3883,37.962, "İmam Hatip Meslek Dersleri Ö."),
        (0.3791,40.920, "İngilizce"),
        (0.4542,42.157, "Kimya"),
        (0.4247,41.759, "Lise Matematik"),
        (0.4944,33.292, "Okul Öncesi"),
        (0.4883,29.014, "Rehberlik "),
        (0.6184,33.598, "Sınıf Öğretmenliği"),
        (0.6142,34.101, "Sosyal Bilgiler"),
        (0.3521,41.418, "Tarih"),
        (0.4565,34.329, "Türkçe")
    ]
    
    let adCoordinator = AdCoordinator()
    init(){
        AdCoordinator.load()
    }
    var body: some View {
        VStack {
            
            Form{
               
                Section{
                    Stepper(value: $gyDogrusayisi, in:1...60){
                        Label("Doğru Sayısı:\(gyDogrusayisi,specifier: "%.0f")", systemImage: "checkmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: gyDogrusayisi)
                    Stepper(value: $gyYanlissayisi, in:0...60){
                        Label("Yanlış Sayısı:\(gyYanlissayisi,specifier: "%.0f")", systemImage: "xmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: gyYanlissayisi)
                }header: {
                    Text("Genel Yetenek")
                        .textCase(.none)
                        .foregroundStyle(.main)

                }
            footer:{
                if(gyDogrusayisi+gyYanlissayisi>60){
                    Text("Toplam doğru ve yanlış sayısı 60`ı geçemez")
                        .foregroundStyle(.red)
                }
            }
                Section{
                    Stepper(value: $gkDogrusayisi, in:1...60){
                        Label("Doğru Sayısı:\(gkDogrusayisi,specifier: "%.0f")", systemImage: "checkmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: gkDogrusayisi)
                    Stepper(value: $gkYanlissayisi, in:0...60){
                        Label("Yanlış Sayısı:\(gkYanlissayisi,specifier: "%.0f")", systemImage: "xmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: gkYanlissayisi)
                }header: {
                    Text("Genel Kültür")
                        .textCase(.none)
                        .foregroundStyle(.main)

                        
                }
            footer:{
                if(gkDogrusayisi+gkYanlissayisi>60){
                    Text("Toplam doğru ve yanlış sayısı 60`ı geçemez")
                        .foregroundStyle(.red)
                }
            }
                Section{
                    Stepper(value: $ebDogrusayisi, in:1...80){
                        Label("Doğru Sayısı:\(ebDogrusayisi,specifier: "%.0f")", systemImage: "checkmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: ebDogrusayisi)
                    Stepper(value: $ebYanlissayisi, in:0...80){
                        Label("Yanlış Sayısı:\(ebYanlissayisi,specifier: "%.0f")", systemImage: "xmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: ebYanlissayisi)
                }header: {
                    Text("Eğitim Bilimleri")
                        .textCase(.none)
                        .foregroundStyle(.main)

                        
                }
            footer:{
                if(ebDogrusayisi+ebYanlissayisi>80){
                    Text("Toplam doğru ve yanlış sayısı 80`ı geçemez")
                        .foregroundStyle(.red)
                }
            }
                Section{
                    Picker("Bölüm Seçiniz", selection: $selectedOption){
                        ForEach(0..<options.count,id:\.self){index in
                            HStack{
                                Image(systemName: "book.closed.fill")

                                //.2 yapmanın sebebi options dizisindeki ikinci elemanı kullanmak istememiz yani ismini
                                Text(options[index].2)
                                
                            }
                        }
                    }
                    //listede seçilen elemanı tutmamızı sağlıyor
                    .onChange(of: selectedOption){
                        //indexde hangi sıradaysa onu veriyoz listedeki
                        oabtKatsayi = options[selectedOption].0
                        oabtPuan = options[selectedOption].1
                    }
                    Stepper(value: $oabtDogrusayisi, in:1...75){
                        Label("Doğru Sayısı:\(oabtDogrusayisi,specifier: "%.0f")", systemImage: "checkmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: oabtDogrusayisi)
                    Stepper(value: $oabtYanlissayisi, in:0...75){
                        Label("Yanlış Sayısı:\(oabtYanlissayisi,specifier: "%.0f")", systemImage: "xmark.circle")
                            .foregroundStyle(.black)
                    }
                        .bold()
                        .sensoryFeedback(.selection, trigger: oabtYanlissayisi)
                    
                    HesaplaButton(title: "Hesapla") {
                        let gkNet = gkDogrusayisi - (gkYanlissayisi/4)
                        let gyNet = gyDogrusayisi - (gyYanlissayisi/4)
                        let ebNet = ebDogrusayisi - (ebYanlissayisi/4)
                        let oabtNet = oabtDogrusayisi - (oabtYanlissayisi/4)
                        
                        sonucEB2022 = Constants.eb2022Puan + gyNet * Constants.eb2022GYKatsayi + gkNet * Constants.eb2022GKKatsayi + ebNet * Constants.eb2022Katsayi
                        sonuc2022 = Constants.lisans2022Puan + gyNet * Constants.lisans2022GYKatsayi + gkNet * Constants.lisans2022GKKatsayi
                        sonucEB2023 = Constants.eb2023Puan + gyNet * Constants.eb2023GYKatsayi + gkNet * Constants.eb2023GKKatsayi + ebNet * Constants.eb2023Katsayi
                        sonuc2023 = Constants.lisans2023Puan + gyNet * Constants.lisans2023GYKatsayi + gkNet * Constants.lisans2023GKKatsayi
                        sonucOABT2022 = oabtPuan + gyNet * Constants.oabt2022GYKatsayi + gkNet * Constants.oabt2022GKKatsayi + ebNet * Constants.oabt2022EBKatsayi + oabtNet * oabtKatsayi
                        //değişkenin değerini değiştiriyo isshowingsheet false ise true ya çeviriyo hesaplama işimiz bittiği için burda bu değeri true ya çevirip sonuç viewını göstereiliriz
                        isShowingSheet.toggle()
                        
                        let result2022OABT = Result(sinavAdi: "2022 ÖABT", gyNet: gyNet, gkNet: gkNet, ebNet: ebNet, oabtNet: oabtNet, sonuc: sonuc2022)
                                               modelContext.insert(result2022OABT)
                        adCoordinator.presentAd()
                    }
                    .disabled(formcontrol)
                    .sensoryFeedback(.success, trigger: sonuc2022)
                    //isshowingsheet die bir değişken tanımladık
                    //bu true ise SonucViewı acılacak
                    .sheet(isPresented: $isShowingSheet) {
                        SonucView(sonuc2022: sonuc2022, sonucEB2022: sonucEB2022, sonucOABT2022: sonucOABT2022, sonuc2023: sonuc2023, sonucEB2023: sonucEB2023, sonucOABT2023: nil)
                    }
                }header: {
                    Text("ÖABT")
                        .textCase(.none)
                        .foregroundStyle(.main)

                        
                }
            footer:{
                if(oabtDogrusayisi+oabtYanlissayisi>75){
                    Text("Toplam doğru ve yanlış sayısı 75`ı geçemez")
                        .foregroundStyle(.red)
                }
            }
                
            
            }
            
        }
        .navigationTitle("ÖABT")
        
    }
    
    var formcontrol:Bool {
        if(gkDogrusayisi+gkYanlissayisi > 60 || gyDogrusayisi+gyYanlissayisi>60 || ebDogrusayisi + ebYanlissayisi > 80 || oabtDogrusayisi+oabtYanlissayisi>75){
            return true
        }
            return false
    }
}


#Preview {
    OABTView()
}
