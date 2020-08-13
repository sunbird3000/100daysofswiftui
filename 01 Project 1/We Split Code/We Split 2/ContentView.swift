//
//  ContentView.swift
//  WeSplit
//
//  Created by Nina Zidani on 8/6/20.
//  Copyright © 2020 Nina Zidani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    // Allows us to work around the restrictions of struct. Automatically watches for changes and updates the app. Kind of like "saving progress" in games.
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
   // Two way Binding: Binding the text fields to the updates. Tells Swift that it shuold read the value of the property but also write it back as it happens.
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // total per person = total amount + tip% / #of people
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
      var totalWithTip: Double {
        //total per person + total tip
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipvalue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipvalue
        
        return grandTotal
        
      
    }
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                
                Picker("Number of People", selection:
                $numberOfPeople) {
                    ForEach(2 ..< 100) {
                        Text("\($0) people")
                    }
                    
// For each can be used for Looping from 1 to 100 (passing through 0, 1, 2, and so on...).
                    
                }
            }
                
            Section(header: Text("How much tip do you want to leave?")) {
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    
                .pickerStyle(SegmentedPickerStyle())
                }
            
            Section(header: Text("Amount per person")) {
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }
                
            Section(header: Text("Total amount with tip")) {
            Text("$\(totalWithTip, specifier:"%.2f")")
                
            }
        .navigationBarTitle("Split the Bill")
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}


