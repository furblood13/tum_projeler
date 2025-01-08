//
//  EgitimBilimleriView.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI

struct EgitimBilimleriView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var gkDogrusayisi:Double=30
    @State private var gkYanlissayisi:Double=0
    
    @State private var gyDogrusayisi:Double=30
    @State private var gyYanlissayisi:Double=0
    
    @State private var ebDogrusayisi:Double=40
    @State private var ebYanlissayisi:Double=0
    
    @State private var sonuc2022:Double = 0
    @State private var sonuc2023:Double = 0
    @State private var sonucEB2023:Double = 0
    @State private var sonucEB2022:Double = 0
    let adCoordinator = AdCoordinator()
    init(){
        AdCoordinator.load()
    }
    @State private var isShowingSheet = false

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
                    HesaplaButton(title: "Hesapla") {
                        let gkNet = gkDogrusayisi - (gkYanlissayisi/4)
                        let gyNet = gyDogrusayisi - (gyYanlissayisi/4)
                        let ebNet = ebDogrusayisi - (ebYanlissayisi/4)
                        
                        sonucEB2022 = Constants.eb2022Puan + gyNet * Constants.eb2022GYKatsayi + gkNet * Constants.eb2022GKKatsayi + ebNet * Constants.eb2022Katsayi
                        sonuc2022 = Constants.lisans2022Puan + gyNet * Constants.lisans2022GYKatsayi + gkNet * Constants.lisans2022GKKatsayi
                        sonucEB2023 = Constants.eb2023Puan + gyNet * Constants.eb2023GYKatsayi + gkNet * Constants.eb2023GKKatsayi + ebNet * Constants.eb2023Katsayi
                        sonuc2023 = Constants.lisans2023Puan + gyNet * Constants.lisans2023GYKatsayi + gkNet * Constants.lisans2023GKKatsayi
                        isShowingSheet.toggle()
                        
                        let result2022EB = Result(sinavAdi: "2022 Eğitim Bilimleri", gyNet: gyNet, gkNet: gkNet, ebNet: ebNet, sonuc: sonucEB2022)
                                                let result2023EB = Result(sinavAdi: "2023 Eğitim Bilimleri", gyNet: gyNet, gkNet: gkNet, ebNet: ebNet, sonuc: sonucEB2023)
                                                
                                                modelContext.insert(result2022EB)
                            
                        modelContext.insert(result2023EB)
                        adCoordinator.presentAd()
                    }
                    .disabled(formcontrol)
                    .sensoryFeedback(.success, trigger: sonuc2022)
                    //isshowingsheet die bir değişken tanımladık
                    //bu true ise SonucViewı acılacak
                    .sheet(isPresented: $isShowingSheet) {
                        SonucView(sonuc2022: sonuc2022, sonucEB2022: sonucEB2022, sonucOABT2022: nil, sonuc2023: sonuc2023, sonucEB2023: sonucEB2023, sonucOABT2023: nil)
                    }
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
             
            
            }
            
        }
        .navigationTitle("Eğitim Bilimleri")
    }
    
    var formcontrol:Bool {
        if(gkDogrusayisi+gkYanlissayisi > 60 || gyDogrusayisi+gyYanlissayisi>60 || ebDogrusayisi + ebYanlissayisi > 80){
            return true
        }
            return false
    }
}


#Preview {
    EgitimBilimleriView()
}
