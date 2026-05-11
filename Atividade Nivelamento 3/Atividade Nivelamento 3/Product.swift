import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
    let imageName: String
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}