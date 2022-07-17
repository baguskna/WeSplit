//
//  ContentView.swift
//  WeSplit
//
//  Created by Bagus Kurnia on 16/07/22.
//

import SwiftUI

struct ContentView: View {
  let tipPercentages: [Int] = [10, 15, 20, 25, 0]
  let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
  @FocusState private var amountIsFocus: Bool
  @State private var checkAmount: Double = 0.0
  @State private var numberOfPeople: Int = 2
  @State private var tipPercentage: Int = 20
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: currency)
            .keyboardType(.decimalPad)
            .focused($amountIsFocus)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
        }
        
        Section {
          Text(totalPerPerson, format: currency)
        } header: {
          Text("Amount per person")
        }
        
        Section {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("How much tip do you want to leave?")
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()

          Button("Done") {
            amountIsFocus = false
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
