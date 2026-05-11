internal import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top)
                
                Text("Usuário Nivelamento")
                    .font(.title2)
                    .bold()
                
                Text("nivelamento3@exemplo.com")
                    .foregroundColor(.secondary)
                
                List {
                    Section(header: Text("Minha Atividade")) {
                        Label("Meus Pedidos", systemImage: "bag")
                        Label("Favoritos", systemImage: "heart")
                        Label("Cupons", systemImage: "tag")
                    }
                    
                    Section(header: Text("Configurações")) {
                        Label("Notificações", systemImage: "bell")
                        Label("Sair", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Minha Conta")
        }
    }
}
