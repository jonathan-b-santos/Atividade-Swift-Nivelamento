//
//  ContentView.swift
//  Atividade Nivelamento 3
//
//  Created by JONATHAN SANTOS on 11/05/26.
//

internal import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = EcommerceViewModel()
    
    var body: some View {
        TabView {
            // Aba da Loja
            StoreView(viewModel: viewModel)
                .tabItem {
                    Label("Loja", systemImage: "bag")
                }
            
            // Aba do Carrinho
            CartView(viewModel: viewModel)
                .tabItem {
                    Label("Carrinho", systemImage: "cart")
                }
                .badge(viewModel.cart.count)
            
            // Aba de Perfil (Terceira Tela)
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
