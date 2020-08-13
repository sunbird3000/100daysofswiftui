//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nina Zidani on 8/12/20.
//  Copyright © 2020 Nina Zidani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // We need two properties to store out game data: an array of country images and an integer storing which images are correct
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    //The int.random automatically picks a random number. We will use it to decide which country flag will be tapped.
    
    
    @State private var showingScore = false
    //Property that stores whether the alert is showing or not
    @State private var scoreTitle = ""
    //Property that srores the title that will be shown inside the alert
    
    @State private var userScore = 0
    //Property that stores the user score
    
    
    var body: some View {
        //when we return some view that conforms to the view protocol. If we want to return multiple things we can use hstack, zstack and vstack (horizontal, vertical and zedth)
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom) .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .padding(.top, 120)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in Button(action: {
                    self.flagTapped(number)
                }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
                    // tells swift UI to render the original image pixels rather than coloring them as a button
                    .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                        .shadow(color: .black, radius: 2)
                    }
                    
                }
                
                VStack (spacing: 10) {
                    Text("Your Score is:")
                    .foregroundColor(.white)
                        .padding(.top, 20)
                    Text("\(userScore)")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                    
                    
                }
                
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Yes!"
            userScore += 1
        } else {
            scoreTitle = "Nope! \n That's the flag of \(countries[number])"
        }
        showingScore = true
    
    }
    
    //ask Question method resets the game by shuffling up the countires and picking up a new correct answer
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


