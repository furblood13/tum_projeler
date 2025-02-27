import SwiftUI
import SwiftData

struct ResultView: View {
    @Environment(\.modelContext) private var modelContext
    @Query (sort: \Result.tarih,order:.reverse)private var results: [Result]
    @Binding var selectionTabItem:Int
    var body: some View {
           NavigationStack {
               VStack {
                   List {
                       Section {
                           ForEach(results){ result in
                               VStack(alignment: .leading) {
                                   Text(result.sinavAdi)
                                       .bold()
                                       .font(.headline)
                                   HStack {
                                       HStack(alignment: .top){
                                           Text("Genel Yetenek:")
                                           Text(result.gyNet.formatted())
                                       }
                                       Spacer()
                                       HStack(alignment: .top){
                                           Text("ÖABT:")
                                           Text((result.oabtNet ?? 0).formatted())
                                       }
                                   }
                                   
                                   HStack {
                                       HStack{
                                           Text("Genel Kültür:")
                                           Text(result.gkNet.formatted())
                                       }
                                       Spacer()
                                       HStack{
                                           Text("Eğitim Bilimleri:")
                                           Text((result.ebNet ?? 0).formatted())
                                       }
                                   }
                                   
                                   HStack {
                                       Text("Puan:")
                                       Text(result.sonuc.formatted())
                                           .bold()
                                           .italic()
                                   }
                                   
                                   HStack {
                                       Spacer()
                                       Text(result.tarih.formatted(date:.complete, time:.omitted))
                                           .italic()
                                           .font(.footnote)
                                   }
                                   
                               }
                           }
                           //satırı silmeye yarıyo
                           .onDelete{indexSet in
                               for index in indexSet{
                                   modelContext.delete(results[index])
                               }
                           }
                          
                       } 
                      
                   }
                   .overlay{
                       //eğerki liste boşsa direk bunu kullanabiliyoz listin sonuna koyulur
                       if results.isEmpty{
                           ContentUnavailableView{
                               Label("Sonuç Bulunamadı", systemImage: "magnifyingglass")
                           }description:{
                               Text("Hiç hesaplama yapılmamış")
                           } actions: {
                               Button(action: {
                                  selectionTabItem = 0
                               }, label: {
                                 Label("Hesaplamalara dön", systemImage: "arrow.left.circle")
                                       .font(.title2)
                                       .foregroundStyle(.white)
                                       .frame(maxWidth: .infinity,maxHeight: 40)
                                       .bold()
                                   
                               })
                               .buttonStyle(.borderedProminent)
                               .tint(.main)
                           }
                          
                       }
                   }
                   
                   
               }
               //satırı editlemeyi sağlıyo birden çok silebiliyon
               .navigationTitle("Hesaplamalar")
               .toolbar {
                   EditButton()
               }
           }
       }
   }

   #Preview {
       ResultView(selectionTabItem: .constant(1))
   }
