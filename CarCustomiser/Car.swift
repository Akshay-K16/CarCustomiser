//
//  Car.swift
//  CarCustomiser
//
//  Created by Khemaney, Akshay (SPH) on 20/01/2021.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func displayStats() -> String {
        return "Make: \(make)\nModel: \(model)\nTop Speed: \(topSpeed)mph\nAcceleration: (0-60): \(acceleration)s\nHandling: \(handling)"
    }
}
