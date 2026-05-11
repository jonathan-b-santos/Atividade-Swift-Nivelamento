import Foundation
import Combine
internal import SwiftUI

class EcommerceViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "MacBook Pro", price: 12500.0, imageName: "laptopcomputer"),
        Product(name: "iPhone 15", price: 7500.0, imageName: "iphone"),
        Product(name: "iPad Air", price: 5200.0, imageName: "ipad"),
        Product(name: "AirPods Pro", price: 1800.0, imageName: "airpodspro")
    ]
    
    @Published var cart: [CartItem] = []
    
    var totalPrice: Double {
        cart.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func addToCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += 1
        } else {
            cart.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(at offsets: IndexSet) {
        cart.remove(atOffsets: offsets)
    }
    
    func checkout() {
        cart.removeAll()
    }
}
