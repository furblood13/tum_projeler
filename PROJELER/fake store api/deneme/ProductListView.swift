//
//  ProductListView.swift
//  deneme
//
//  Created by Furkan buğra karcı on 15.08.2024.
//
import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                HStack {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.headline)
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Products")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}


#Preview {
    ProductListView()
}
