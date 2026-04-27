//
//  main.swift
//  Atividade Nivelamento
//
//  Created by JONATHAN SANTOS on 09/04/26.
//


//Atividade de nivelamento
/*
 Crie um sistema para gerenciar contatos. Neste sistema, teremos as seguintes funcionalidades:
 */

/*
 * Cadastro: Nome, idade, telefone e e-mail;
 * Listagem: Listar todos os contatos e seus respectivos dados;
 * Alteração: Liste o nome dos contatos, selecione pelo identificador e peça os dados: nome, idade, telefone e e-mail;
 * Remoção: Liste o nome dos contatos, e remova pelo identificador;
 * Finalizar: Sair do sistema.
 

Algumas regras:

* Todos os nomes cadastrados precisam ser diferentes, exemplo:
  * Ana e Ana \<- Não deverá ser aceito.
  * Ana Carolina e Ana Lúcia \<- Aceito.
* Todas as informações do contato no ato de cadastro e alteração devem estar devidamente preenchidos.
* Ao alterar ou remover, se o usuário informar um identificador inválido, deverá haver um retorno informando que a informação não é condizente com os identificadores listados.

 Usando laço de repetição para exibir o menu do siatema
 */

import Foundation

var sair: Bool = false
var idCadastro: Int = 0

var vetorGlobal: [Contato] = []

struct Contato {
    var id: Int
    var nome: String
    var idade: String
    var telefone: String
    var email: String
}


struct Acoes {
    
    private var vetor : [Contato] = []
    
    //Função para cadastrar
    public mutating func cadastrar(nome: String, idade: String, telefone: String, email: String) {
        // Validação: Campos obrigatórios (não vazios)
        if nome.isEmpty || idade.isEmpty || telefone.isEmpty || email.isEmpty {
            print("Erro: Todos os campos devem estar preenchidos.")
            return
        }
        
        // Validação: Nomes únicos
        let nomeExiste = vetor.contains(where: { $0.nome.lowercased() == nome.lowercased() })
        if nomeExiste {
            print("Erro: O nome '\(nome)' já está cadastrado. Tente outro.")
            return
        }
        
        idCadastro += 1
        
        let novoContato = Contato(id: idCadastro, nome: nome, idade: idade, telefone: telefone, email: email)
        vetor.append(novoContato)
        
        print("Cadastro realizado com sucesso!")
    }
    
    public func listar() {
        for c in vetor {
            print("ID: \(c.id) | " + "NOME: \(c.nome) | " + "IDADE: \(c.idade) | " + "TELEFONE: \(c.telefone) | " + "E-MAIL: \(c.email)")
            print("------------------------------------")
        }
        
        if vetor.isEmpty {
            print("Nenhum contato cadastrado.")
        }
    }

    public mutating func alterar(id: Int, nome: String, idade: String, telefone: String, email: String) {
        // Validação: Campos preenchidos
        if nome.isEmpty || idade.isEmpty || telefone.isEmpty || email.isEmpty {
            print("Erro: Todas as informações precisam estar devidamente preenchidas.")
            return
        }

        guard let index = vetor.firstIndex(where: { $0.id == id }) else {
            print("Informação não é condizente com os identificadores listados.")
            return
        }

        // Validação: Nome único (ignorando o próprio contato sendo alterado)
        if vetor.contains(where: { $0.id != id && $0.nome.lowercased() == nome.lowercased() }) {
            print("Erro: O nome '\(nome)' já está cadastrado em outro contato.")
            return
        }

        vetor[index] = Contato(id: id, nome: nome, idade: idade, telefone: telefone, email: email)
        print("Contato alterado com sucesso!")
    }

    /*
     Função para remover item pelo ID
     */
    
    public mutating func remover(id: Int) {
        if let index = vetor.firstIndex(where: { $0.id == id }) {
            vetor.remove(at: index)
            print("Contato removido com sucesso!")
        } else {
            print("Informação não é condizente com os identificadores listados.")
        }
    }
    
}

// Instância global para manter os dados durante a execução do loop
var sistemaDeAcoes = Acoes()

while sair == false {
    //Itens no menu
    print("Use os seguintes comandos para acessar o menu")
    print("C para cadastrar")
    print("L para listar")
    print("A para alterar")
    print("R para remover")
    print("S para sair")
    
    let comando: String = readLine() ?? ""
    
    switch comando {
        case "C", "c":
            print("Cadastrar")
            print("Digite o nome")
            let name: String = readLine()!
            print("Digite a idade")
            let idade: String = readLine()!
            print("Digite o telefone")
            let telefone: String = readLine()!
            print("Digite o e-mail")
            let email: String = readLine()!
            
            sistemaDeAcoes.cadastrar(nome: name, idade: idade, telefone: telefone, email: email)
            
        case "L", "l":
            print("\n--- Listagem de Contatos ---")
            sistemaDeAcoes.listar()
            
        case "A", "a":
            print("\n--- Alterar Contato ---")
            sistemaDeAcoes.listar()
            print("Selecione o identificador (ID) que deseja alterar:")
            if let input = readLine(), let idParaAlterar = Int(input) {
                print("Digite o novo nome:")
                let novoNome = readLine() ?? ""
                print("Digite a nova idade:")
                let novaIdade = readLine() ?? ""
                print("Digite o novo telefone:")
                let novoTelefone = readLine() ?? ""
                print("Digite o novo e-mail:")
                let novoEmail = readLine() ?? ""
                
                sistemaDeAcoes.alterar(id: idParaAlterar, nome: novoNome, idade: novaIdade, telefone: novoTelefone, email: novoEmail)
            } else {
                print("ID inválido.")
            }
        case "R", "r":
            print("Digite o ID que deseja remover:")
            if let input = readLine(), let idParaRemover = Int(input) {
                sistemaDeAcoes.remover(id: idParaRemover)
            } else {
                print("ID inválido. Digite um número.")
            }
            
        case "S", "s":
            sair = true
        default:
            print("Comando inválido")
    }
}
