//
//  OnlisansView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//


import SwiftUI

struct LisansView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var gkDogrusayisi:Double=50
    @State private var gkYanlissayisi:Double=0
    
    @State private var gyDogrusayisi:Double=40
    @State private var gyYanlissayisi:Double=0
    
    @State private var sonuc2022:Double = 0
    @State private var sonuc2023:Double = 0
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
                    Text("2023 KPSS Puanı: \(sonuc2023,specifier: "%.3f")")
                        .bold()
                    Text("2022 KPSS Puanı: \(sonuc2022,specifier: "%.3f")")
                        .bold()
                    
                    HesaplaButton(title: "Hesapla") {
                        let gkNet = gkDogrusayisi - (gkYanlissayisi/4)
                        let gyNet = gyDogrusayisi - (gyYanlissayisi/4)
                        
                        withAnimation {
                            sonuc2023 = Constants.lisans2023Puan + gyNet * Constants.lisans2023GYKatsayi + gkNet * Constants.lisans2023GKKatsayi
                            sonuc2022 = Constants.lisans2022Puan + gyNet * Constants.lisans2022GYKatsayi + gkNet * Constants.lisans2022GKKatsayi
                        }
                        let result2022 = Result(sinavAdi: "2022 Lisans KPSS", gyNet: gyNet, gkNet: gkNet, sonuc: sonuc2022)
                                                let result2023 = Result(sinavAdi: "2023 Lisans KPSS", gyNet: gyNet, gkNet: gkNet, sonuc: sonuc2023)
                                                modelContext.insert(result2022)
                                                modelContext.insert(result2023)
                        adCoordinator.presentAd()
                    }
                    .disabled(formcontrol)
                }header: {
                    Text("Sonuç")
                        .textCase(.none)
                        .foregroundStyle(.main)
                }
            
            }
            
        }
        .navigationTitle("Lisans")

    }
    
    var formcontrol:Bool {
        if(gkDogrusayisi+gkYanlissayisi > 60 || gyDogrusayisi+gyYanlissayisi>60){
            return true
        }
            return false
    }
}

#Preview {
    LisansView()
}

