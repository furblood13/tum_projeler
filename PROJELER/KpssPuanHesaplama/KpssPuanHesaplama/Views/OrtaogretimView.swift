//
//  OrtaogretimView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI

struct OrtaogretimView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var gkDogrusayisi:Double=50
    @State private var gkYanlissayisi:Double=0
    
    @State private var gyDogrusayisi:Double=40
    @State private var gyYanlissayisi:Double=0
    @State private var sonuc:Double = 0
    
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
                    Text("KPSS Puanı: \(sonuc,specifier: "%.3f")")
                        .bold()
                    
                    HesaplaButton(title: "Hesapla") {
                        let gkNet = gkDogrusayisi - (gkYanlissayisi/4)
                        let gyNet = gyDogrusayisi - (gyYanlissayisi/4)
                        
                        withAnimation {
                            sonuc = Constants.ortaogretimPuan + gyNet * Constants.ortaogretimGYKatsayi + gkNet * Constants.ortaogretimGKKatsayi
                        }
                        let result = Result(sinavAdi: "2022 Ortaöğretim KPSS", gyNet: gyNet, gkNet: gkNet, sonuc: sonuc)
                        modelContext.insert(result)
                        
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
        .navigationTitle("Ortaöğretim")

    }
    
    var formcontrol:Bool {
        if(gkDogrusayisi+gkYanlissayisi > 60 || gyDogrusayisi+gyYanlissayisi>60){
            return true
        }
            return false
    }
}

#Preview {
    OrtaogretimView()
}
