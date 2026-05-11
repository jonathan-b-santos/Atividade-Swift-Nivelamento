internal import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: EcommerceViewModel
    @State private var showingConfirmation = false
    @State private var showingSuccessAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.cart) { item in
                    HStack {
                        Text("\(item.quantity)x")
                        Text(item.product.name)
                        Spacer()
                        Text("R$ \(String(format: "%.2f", item.product.price * Double(item.quantity)))")
                    }
                }
                .onDelete(perform: viewModel.removeFromCart)
                
                if !viewModel.cart.isEmpty {
                    Section {
                        HStack {
                            Text("Total").bold()
                            Spacer()
                            Text("R$ \(String(format: "%.2f", viewModel.totalPrice))")
                                .bold()
                                .foregroundColor(.green)
                        }
                    }
                    
                    Section {
                        Button(action: {
                            showingConfirmation = true
                        }) {
                            Text("Confirmar Compra")
                                .frame(maxWidth: .infinity)
                                .bold()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
            }
            .navigationTitle("Meu Carrinho")
            .alert("Confirmar Pedido", isPresented: $showingConfirmation) {
                Button("Cancelar", role: .cancel) { }
                Button("Confirmar") {
                    viewModel.checkout()
                    showingSuccessAlert = true
                }
            } message: {
                Text("O total da sua compra é R$ \(String(format: "%.2f", viewModel.totalPrice)). Deseja finalizar?")
            }
            .alert("Sucesso!", isPresented: $showingSuccessAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Sua compra foi realizada com sucesso!")
            }
        }
    }
}
