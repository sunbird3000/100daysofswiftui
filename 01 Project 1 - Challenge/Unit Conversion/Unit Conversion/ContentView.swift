//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Nina Zidani on 8/11/20.
//  Copyright © 2020 Nina Zidani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var source = ""
    @State private var sourceSelection = 0
    @State private var resultSelection = 0
    @State private var showingAlert = false

    let units = ["Celcius", "Farenheit", "Kelvins"]

    //work all calculations from C
    
    //  C -> F = (0°C × 9/5) + 32 = 32°F
    //  F -> C = (0°F − 32) × 5/9
    //  C -> K = 0°C + 273.15 = 273.15K
    
    
    func calcBase() -> Double {
        //let x = Double(source) ?? 0.0
        var x: Double

        if let unwrapped = Double(source) {
            x = unwrapped
        } else {
            x = 0.0
            showingAlert = true
        }

        if (sourceSelection == 1) {
           return (x - 32) * 5/9
        }

        else if (sourceSelection == 2) {
            return x - 273.15
        }

        return x
    }

    func calculate() -> Double {
        if (resultSelection == 0) {
            return Double(calcBase())
        }
        else if (resultSelection == 1) {
            return (Double(calcBase()) * 9/5) + 32
        }
        else {
            return (Double(calcBase()) + 273.15)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter temp you want to convert")) {
                    TextField("Enter here", text: $source)
                    .keyboardType(.decimalPad)
                    Picker("Unit", selection: $sourceSelection) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .alert(isPresented: $showingAlert) {
                           Alert(title: Text("ERROR"), message: Text("Please enter a valid number"), dismissButton: .default(Text("OK")))
                       }
                }
                Section(header: Text("Choose conversion unit")) {
                    Text("\(calculate(), specifier: "%.2f")")
                    Picker("Unit", selection: $resultSelection) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
