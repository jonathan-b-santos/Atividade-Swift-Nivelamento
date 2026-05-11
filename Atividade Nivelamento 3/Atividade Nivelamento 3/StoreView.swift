internal import SwiftUI

struct StoreView: View {
    @ObservedObject var viewModel: EcommerceViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                HStack {
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text(product.name).font(.headline)
                        Text("R$ \(String(format: "%.2f", product.price))").foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: { viewModel.addToCart(product: product) }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("Apple Store")
        }
    }
}
