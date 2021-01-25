//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Khemaney, Akshay (SPH) on 20/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var brakesPackage = false
    @State private var ECUPackage = false
    
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    
    @State private var disableAll: Bool = false
    
    var exhaustPackageDisabled: Bool {
        return disableAll ? true : exhaustPackage ? false : remainingFunds < 500 ? true : false
    }
    
    var tiresPackageDisabled: Bool {
        return disableAll ? true : tiresPackage ? false : remainingFunds < 500 ? true : false
    }
    
    var brakesPackageDisabled: Bool {
        return disableAll ? true : brakesPackage ? false : remainingFunds < 500 ? true : false
    }
    
    var ECUPackageDisabled: Bool {
        return disableAll ? true : ECUPackage ? false : remainingFunds < 500 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500

                }
            }
        )
        
        let brakesPackageBinding = Binding<Bool> (
            get : { self.brakesPackage },
            set : { newValue in
                self.brakesPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 1
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 1
                    remainingFunds += 500

                }
            }
        )
        
        let ECUPackageBinding = Binding<Bool> (
            get : { self.ECUPackage },
            set : { newValue in
                self.ECUPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration += 0.5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                    remainingFunds += 500

                }
            }
        )
        VStack{
            Text("\(remainingTime)s")
                .onReceive(timer) { _ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        self.disableAll = true
                    }
                }
            Form {
                VStack( alignment: .leading, spacing: 20) {
                    Text(starterCars.cars[selectedCar].displayStats())
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                    }).disabled(disableAll)
                }
                
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(exhaustPackageDisabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(tiresPackageDisabled)
                    Toggle("Brakes Package (Cost: 500)", isOn: brakesPackageBinding)
                        .disabled(brakesPackageDisabled)
                    Toggle("ECU Package (Cost: 500)", isOn: ECUPackageBinding)
                        .disabled(ECUPackageDisabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.black)
                .baselineOffset(10.0)
        }
    }
    
    func resetDisplay(){
        remainingFunds = 1000
        exhaustPackage = false
        tiresPackage = false
        brakesPackage = false
        ECUPackage = false
        starterCars = StarterCars()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
