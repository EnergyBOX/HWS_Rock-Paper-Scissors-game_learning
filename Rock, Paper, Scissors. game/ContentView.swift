//
//  ContentView.swift
//  Rock, Paper, Scissors. game
//
//  Created by Server Admin on 22.01.2024.
//

// Requariments
//Each turn of the game the app will randomly pick either rock, paper, or scissors.
//Each turn the app will alternate between prompting the player to win or lose.
//The player must then tap the correct move to win or lose the game.
//If they are correct they score a point; otherwise they lose a point.
//The game ends after 10 questions, at which point their score is shown.


import SwiftUI

struct ContentView: View {
    
    @State private var items = ["🤘", "📜", "✂️"]
    @State private var item = "⁉️"
    @State private var computerItem = "⁉️"
    
    @State private var results = ["Win", "Lose"]
    @State private var result = ""
    
    @State private var score = 0
    @State private var resultOfLastGame = "No result"
    
    @State private var isTheEndOfGame = false
    
    
    var playButtonText: String {
        if items.contains(computerItem) {
            return "Play Again"
            
        } else {
            return "Play Game"
        }
    }
    
    var playerCanPlay: Bool {
        if results.contains(result) && items.contains(item){
            return true
        } else {
            return false
        }
    }
    
    
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section {
                    Text(String(score))
                    Text(String(resultOfLastGame))
                }
                
                Section {
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.blue)
                                .cornerRadius(10)
                            Text("\(computerItem)")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        }
                        
                        Text("VS")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.blue)
                                .cornerRadius(10)
                            Text("\(item)")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Section {
                    ZStack {
                        Rectangle()
                            .frame(height: 100)
                            .foregroundColor(Color.blue)
                            .cornerRadius(10)
                        if playerCanPlay {
                            Button(action: {
                                playGame()
                            }) {
                                Text(playButtonText)
                                    .foregroundColor(.white)
                            }
                            
                        } else {
                            Text("Make a choise")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                Section("Pick either rock, paper, or scissors:") {
                    Picker("Picker in: 🤘📜✂️", selection: $item) {
                        ForEach(items, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Prompting the player to:") {
                    Picker("Picker in: win or lose", selection: $result) {
                        ForEach(results, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
            }

        }
        .alert(isPresented: $isTheEndOfGame, content: {
            Alert(
                title: Text("You WiNer"),
                message: Text("You score is \(score), and game will be REstsrt"),
                dismissButton: .destructive(Text("Restart"), action: restartGame)
            )
        })
        
    }
    
    
    func playGame() {
        computerItem = items.randomElement() ?? "🤬"
        var winer = winerDetector(item: item, computerItem: computerItem)
        
        
        
        if item == winer {
            if result == "Win" {
                score += 1
                resultOfLastGame = "You wanted to \(result) , and you Win"
            } else if result == "Lose" {
                score -= 1
                resultOfLastGame = "You wanted to \(result) , but you Win"
            }
        } else if computerItem == winer {
            if result == "Win" {
                score -= 1
                resultOfLastGame = "You wanted to \(result) , but you Lose"
            } else if result == "Lose" {
                score += 1
                resultOfLastGame = "You wanted to \(result) , and you Lose"
            }
        } else {
            resultOfLastGame = "This time it's a draw"
        }
        if score < 0 {score = 0}
        
        if score > 3 {isTheEndOfGame = true}
        
    }
    
    
    func winerDetector (item: String, computerItem: String) -> String {
        var result: String = ""
        if item == computerItem {result = "win-win"}
        var masive = [item, computerItem]
        if masive.contains("🤘") && masive.contains("📜") {
            result = "📜"
        } else if masive.contains("✂️") && masive.contains("🤘") {
            result = "🤘"
        } else if masive.contains("📜") && masive.contains("✂️") {
            result = "✂️"
        }
        return result
    }
    
    func restartGame() {
        items = ["🤘", "📜", "✂️"]
        item = "⁉️"
        computerItem = "⁉️"
        results = ["Win", "Lose"]
        result = ""
        score = 0
        resultOfLastGame = "No result"
        isTheEndOfGame = false
    }
    
}
    














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
