//
//  ContentView.swift
//  MathicationTable
//
//  Created by Sougato Roy on 04/08/25.
//

import SwiftUI

struct QuizMode : View {
    let selectedTable: Int
    let numberOfQuestions: Int
    let difficulty: String
    let onRestart: () -> Void
    
    @State private var currentQuestion = 1
    @State private var randomNumber = 1
    @State private var userAnswer: Int?
    @State private var score = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            Text("Question \(currentQuestion) of \(numberOfQuestions)")
                .font(.title2)

            Text("\(selectedTable) × \(randomNumber) = ?")
                .font(.largeTitle)
            
            TextField("Your answer", value: $userAnswer, format: .number)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
            
            Button("Submit") {
                check()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
            
        }
        .onAppear(perform: generateRandomNumber)
        .alert("Game Over", isPresented: $showAlert) {
            Button("Play Again", action: onRestart)
        } message: {
            Text("Your score: \(score)/\(numberOfQuestions)")
        }

    }
    
    func generateRandomNumber() {
        switch difficulty {
            case "Easy" :
                randomNumber = Int.random(in: 1...10)
            case "Medium":
                randomNumber = Int.random(in: 11...15)
            case "Hard":
                randomNumber = Int.random(in: 16...20)
            default:
                randomNumber = Int.random(in: 1...10)
        }
        userAnswer = nil
    }
    
    func check(){
        if let answer = userAnswer, answer == selectedTable * randomNumber {
            score += 1
        }
        
        if currentQuestion == numberOfQuestions {
            showAlert = true
        } else {
            currentQuestion += 1
            generateRandomNumber()
        }
    }
}

struct ContentView: View {

    @State private var selectedTable :Int = 1
    @State private var numberOfQuestions :Int = 5
    @State private var difficulty :String = "Easy"
    
    @State private var gameStarted = false
        
    var body: some View {
        Text("Mathication Table")
            .font(.title)
            .fontWeight(.heavy)
        
        if gameStarted{
            QuizMode(selectedTable: selectedTable,numberOfQuestions: numberOfQuestions, difficulty: difficulty,onRestart: { gameStarted = false })
        }else{
            Form{
                Section("Which multiplication table you want to practice?"){
                    Picker("Select ", selection: $selectedTable){
                        ForEach(1..<21, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .fontWeight(.thin)
                }
                .fontWeight(.bold)
                
                Section("How many questions do you want to be asked?"){
                    Stepper("\(numberOfQuestions) questions", value: $numberOfQuestions, in: 5...20, step: 5)
                        .fontWeight(.thin)
                }
                .fontWeight(.bold)
                
                Section("Difficulty ?"){
                    Picker("Choose from ", selection: $difficulty){
                        ForEach(["Easy", "Medium", "Hard"], id: \.self){
                            Text($0)
                        }
                    }
                    .fontWeight(.thin)
                    //.pickerStyle(.segmented)
                }
                .fontWeight(.bold)

                Button("Start Game") {
                    gameStarted = true
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

#Preview {
    ContentView()
}
