//
//  ContentView.swift
//  Edutainment
//
//  Created by Travis Brigman on 2/4/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var maxTables = 1
    @State private var quantitySelect = 2
    
    @State private var gameQuestions = [Question]()
    
    @State private var enteredAnswer = ""
    
    @State private var gameScore = 0
    @State private var questionCount = 0
    
    var questionQuantity = ["5","10","15","20","All"]
    
    var body: some View {
        Group{
            if !isGameActive {
                
                Form {
                    Stepper(value: $maxTables, in: 1...12, step: 1) {
                        Text("Up to the \(maxTables)'s times tables")
                    }
                    Section(header: Text("How many questions do you want?")){
                        Picker("Question Picker", selection: $quantitySelect) {
                            ForEach(0 ..< questionQuantity.count) {
                                Text("\(self.questionQuantity[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button("start game"){
                            self.isGameActive.toggle()
                        }

                    }
                    .padding()
                    .onAppear(perform: startNewGame)
                }
                
            } else {
                Text("\(gameQuestions[questionCount].equation )")
                TextField("Answer", text: $enteredAnswer, onCommit: checkAnswer)
                    .keyboardType(.numberPad)
                
                }
            }
        }
        
    func checkAnswer() {
        if gameQuestions[questionCount].answer == Int(enteredAnswer) {
            gameScore += 1
            if questionCount < gameQuestions.count {
                questionCount += 1
            }
        }
    }
    
    
    func startNewGame() {
        gameQuestions = questionBuilder(tableNumbers: maxTables, maxQuestions: 5)
        print(gameQuestions)
    }
}
    
func questionBuilder(tableNumbers: Int, maxQuestions: Int) -> [Question] {
    var questionArray = [Question]()
    for number in 1...tableNumbers {
        for i in 1...10 {
            questionArray.append(Question(productA: i, productB: number))
        }
    }
    return questionArray[0...maxQuestions].shuffled()
}


struct Question {
    let productA: Int
    let productB: Int
    var equation: String {
        
        return "\(productA) x \(productB) is ?"
    }
    var answer: Int {
        
        return productA * productB
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


