//
//  HesaplaButton.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 30.09.2024.
//

import SwiftUI

struct HesaplaButton: View {
    let title:String
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
          Label(title, systemImage: "plus.forwardslash.minus")
                .font(.title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .bold()
            
        })
        .buttonStyle(.borderedProminent)
        .tint(.main)    }
}

#Preview {
    HesaplaButton(title: "Hesapla"){
        print("hesaplandı")
    }
}
