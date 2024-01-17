//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Peter Szots on 12/05/2022.
//

import SwiftUI

struct QuestionView: View {
    
    var timesTable: Int
    var questionAmount: Int
    
    @State private var multiplier = Int.random(in: 1...12)
    @State private var randomMultiplier = Int.random(in: 0...12)
    @State private var resultMessage = "What is your answer?"
    @State private var roundCounter = 1
    @State private var showResult = false
    @State private var score = 0
    @State private var animationAmount = 0.0
    
    var answers: [Int] {
        let answersArray = [
                (questionResult(a: timesTable, b: multiplier)),
                (timesTable * randomMultiplier),
                (Int.random(in: 0...144))
        ].shuffled()
        return answersArray
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Round \(roundCounter)")
                    .foregroundColor(.primary)
                Spacer()
                Text("Score: \(score)/\(questionAmount)")
                    .foregroundColor(.primary)
            }
            .padding(12)
            .background(Color(red: 0.6, green: 0.8, blue: 0.9))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
            .font(.headline)
            
            
            VStack (alignment: .center) {
                Text("What is \(timesTable) * \(multiplier) = ?")
                    .font(.largeTitle.bold())
//                Spacer()
//                Text("Answer: \(questionResult(a: timesTable, b: multiplier))")
            }
            
            VStack (spacing: 5) {
                
                ForEach(answers, id: \.self) { number in
                    Button("\(number)") {
                        if questionResult(a: timesTable, b: multiplier) == number {
                            resultMessage = "Well played!"
                            score += 1
                        } else {
                            resultMessage = "Not really. Try again!"
                        }
                        newRound()
                    }
                    
                    .frame(width: 40, height: 42, alignment: .center)
                    .font(.title2.weight(.bold))
                    .foregroundColor(.cyan)
                    .padding(20)
                    .background(.white)
                    .clipShape(Circle()).fixedSize()
                    .shadow(radius: 4)
         
                }
            }
            .padding(15)
            .background(.cyan)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 2)
            .font(.title)
            
            Spacer()
            VStack (spacing:10) {
                Text(resultMessage)
            }
            Spacer()

        }
        .alert("Final result", isPresented: $showResult) {
            Button("Play Again") {
                newRound()
                score = 0
                roundCounter = 0
            }
        } message: {
            Text("Your final score is: \(score)")
            Text("\( (score >= (questionAmount - 2)) ? "Your score is: \(score). Well done!" : "You can do it better!")")
                .font(.largeTitle)
        }
        
    }
    
    func questionResult(a: Int, b: Int) -> Int{
        return a * b
    }
    
    func newRound() {
        if roundCounter < questionAmount {
            roundCounter += 1
            multiplier = Int.random(in: 1...12)
            randomMultiplier = Int.random(in: 0...12)
        } else {
            showResult = true
        }
    }
    
}

struct ContentView: View {
    @State private var timesTable = 2
    @State private var questionsNumber = [5, 10, 20]
    @State private var selected = 5
    
    var body: some View {
        NavigationView {
            ZStack {
               LinearGradient(stops: [
                    .init(color: Color(red: 1, green: 1, blue: 1), location: 0.5),
                    .init(color: Color(red: 0.6, green: 0.8, blue: 0.9), location: 1.0)
               ], startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                VStack (alignment: .center, spacing: 20) {
                    Spacer()
                    Text ("Chose your times table")
                        .foregroundColor(.primary).bold()
                    VStack {
                        Stepper("\(timesTable) times table", value: $timesTable, in: 2...12, step: 1)
                            .padding(.horizontal, 20)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .padding(10)
                    }

                    Text ("How many questions would you like?")
                        .foregroundColor(.primary).bold()
                    
                    ForEach(questionsNumber, id: \.self) { number in
                        Button("\(number) questions") {
                            self.selected = number
                        }
                        .font(.title3.weight(.bold))
                        .padding(20)
                        .frame(width: 170, alignment: .center)
                        .background( selected == number ? .cyan : Color(red: 1, green: 1, blue: 1) )
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(-7)
                        .shadow(radius: 2)
                    }

                    VStack {
                        NavigationLink(destination: QuestionView(timesTable: timesTable, questionAmount: selected) ) {
                            Text("PLAY")
                                .font(.largeTitle).bold()
                                .foregroundColor(.primary)
                                .padding(20)
                                .background(.cyan)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(radius: 2)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Time Tables App")
            //
                .foregroundColor(.primary)
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

