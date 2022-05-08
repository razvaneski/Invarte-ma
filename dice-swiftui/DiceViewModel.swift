//
//  DiceViewModel.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

class DiceViewModel: ObservableObject {
    @AppStorage("previousRolls") private var previousRolls: [DiceRoll] = []
    
    @Published var firstDiceValue: Int = 1
    @Published var secondDiceValue: Int = 2
    @Published var showAnimation: Bool = false
    @Published var showSplash: Bool = true
    @Published var showDialog: Bool = false
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showSplash = false
            }
        }
        if let lastDice = previousRolls.last {
            firstDiceValue = lastDice.firstDice
            secondDiceValue = lastDice.secondDice
        }
    }
    
    func newRoll() {
        firstDiceValue = Int.random(in: 1...6)
        secondDiceValue = Int.random(in: 1...6)
        
        // Simulate double:
        // firstDiceValue = 6
        // secondDiceValue = 6
        
        previousRolls.append(DiceRoll(first: firstDiceValue, second: secondDiceValue))
        
        showAnimation = true
        if firstDiceValue == secondDiceValue {
            showDialog = true
        }
    }
    
    func hideAnimation() {
        showAnimation = false
    }
}
