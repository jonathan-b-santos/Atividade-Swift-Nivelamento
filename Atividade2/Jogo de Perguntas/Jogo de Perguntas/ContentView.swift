import SwiftUI
import Combine

// MARK: - Modelo
struct Question {
    let question: String
    let options: [String]
    let correctIndex: Int
}

// MARK: - ViewModel
class GameViewModel: ObservableObject {
    @Published var selectedTheme = 0
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var showResult = false
    @Published var answered = false
    @Published var selectedAnswer: Int? = nil
    
    var questions: [Question] = []
    
    let themes = ["Antigo Testamento", "Novo Testamento", "Bíblia Completa"]
    
    // Perguntas
    let oldTestamentQuestions: [Question] = [
        Question(question: "Quem construiu a arca?", options: ["Moisés", "Noé", "Abraão", "Davi"], correctIndex: 1),
        Question(question: "Quem abriu o Mar Vermelho?", options: ["Elias", "Moisés", "Josué", "Pedro"], correctIndex: 1),
        Question(question: "Quem derrotou Golias?", options: ["Saul", "Davi", "Samuel", "Salomão"], correctIndex: 1),
        Question(question: "Primeiro livro da Bíblia?", options: ["Êxodo", "Gênesis", "Levítico", "Números"], correctIndex: 1),
        Question(question: "Quem foi engolido por um grande peixe?", options: ["Jonas", "Elias", "Isaías", "Jeremias"], correctIndex: 0),
        Question(question: "Quem recebeu os 10 mandamentos?", options: ["Abraão", "Moisés", "Davi", "Jacó"], correctIndex: 1),
        Question(question: "Quem foi o homem mais sábio?", options: ["Davi", "Salomão", "Saul", "Noé"], correctIndex: 1),
        Question(question: "Quem lutou com um anjo?", options: ["José", "Jacó", "Moisés", "Abraão"], correctIndex: 1),
        Question(question: "Quem interpretava sonhos no Egito?", options: ["José", "Moisés", "Daniel", "Davi"], correctIndex: 0),
        Question(question: "Quem sobreviveu à cova dos leões?", options: ["Elias", "Daniel", "Isaías", "Jonas"], correctIndex: 1)
    ]
    
    let newTestamentQuestions: [Question] = [
        Question(question: "Quem batizou Jesus?", options: ["Pedro", "João Batista", "Paulo", "Tiago"], correctIndex: 1),
        Question(question: "Quem traiu Jesus?", options: ["Pedro", "João", "Judas", "Tomé"], correctIndex: 2),
        Question(question: "Onde Jesus nasceu?", options: ["Jerusalém", "Belém", "Nazaré", "Egito"], correctIndex: 1),
        Question(question: "Quem negou Jesus 3 vezes?", options: ["Paulo", "Pedro", "Tiago", "André"], correctIndex: 1),
        Question(question: "Quantos discípulos Jesus tinha?", options: ["10", "11", "12", "13"], correctIndex: 2),
        Question(question: "Primeiro milagre de Jesus?", options: ["Curar cego", "Multiplicar pão", "Água em vinho", "Andar sobre águas"], correctIndex: 2),
        Question(question: "Quem escreveu Apocalipse?", options: ["Pedro", "Paulo", "João", "Lucas"], correctIndex: 2),
        Question(question: "Quem foi convertido no caminho de Damasco?", options: ["Pedro", "Paulo", "Tiago", "Mateus"], correctIndex: 1),
        Question(question: "Quem era o cobrador de impostos?", options: ["Lucas", "Mateus", "João", "Pedro"], correctIndex: 1),
        Question(question: "Quem disse 'Eu sou o caminho, a verdade e a vida'?", options: ["Pedro", "Paulo", "Jesus", "João"], correctIndex: 2)
    ]
    
    func startGame() {
        score = 0
        currentQuestionIndex = 0
        showResult = false
        
        switch selectedTheme {
        case 0:
            questions = Array(oldTestamentQuestions.shuffled().prefix(5))
        case 1:
            questions = Array(newTestamentQuestions.shuffled().prefix(5))
        default:
            questions = Array((oldTestamentQuestions + newTestamentQuestions).shuffled().prefix(5))
        }
    }
    
    func answer(_ index: Int) {
        guard !answered else { return }
        
        selectedAnswer = index
        answered = true
        
        if index == questions[currentQuestionIndex].correctIndex {
            score += 1
        }
    }
    
    func nextQuestion() {
        answered = false
        selectedAnswer = nil
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
    }
}

// MARK: - View
struct ContentView: View {
    @StateObject var vm = GameViewModel()
    
    var body: some View {
        if vm.questions.isEmpty {
            VStack {
                Text("📖 Quiz Bíblico")
                    .font(.largeTitle)
                
                Picker("Tema", selection: $vm.selectedTheme) {
                    ForEach(0..<vm.themes.count, id: \.self) {
                        Text(vm.themes[$0])
                    }
                }
                .pickerStyle(.menu)
                .padding()
                
                Button("Iniciar Jogo") {
                    vm.startGame()
                }
                .padding()
            }
        } else if vm.showResult {
            VStack {
                Text("Resultado")
                    .font(.largeTitle)
                
                Text("Acertos: \(vm.score)")
                Text("Erros: \(5 - vm.score)")
                
                Button("Jogar novamente") {
                    vm.questions = []
                    vm.showResult = false
                }
            }
        } else {
            TabView(selection: $vm.currentQuestionIndex) {
                ForEach(0..<vm.questions.count, id: \.self) { index in
                    VStack {
                        Text(vm.questions[index].question)
                            .font(.title2)
                            .padding()
                        
                        ForEach(0..<4, id: \.self) { i in
                            Button(vm.questions[index].options[i]) {
                                vm.answer(i)
                            }
                            .padding()
                        }
                        
                        if vm.answered {
                            if vm.selectedAnswer == vm.questions[index].correctIndex {
                                Text("✅ Correto!")
                            } else {
                                Text("❌ Errado! Resposta: \(vm.questions[index].options[vm.questions[index].correctIndex])")
                            }
                            
                            Button("Próxima") {
                                vm.nextQuestion()
                            }
                            .padding()
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

#Preview {
    ContentView()
}
