//
//  HistoryScreen.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

struct HistoryScreen: View {
    @AppStorage("previousRolls") private var previousRolls: [DiceRoll] = []
    
    var showHistory: Bool { previousRolls.count > 1 }
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(alignment: .leading, spacing: 0) {
                
                NavigationBar(showTitle: previousRolls.count > 1) {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                
                if showHistory {
                    ScrollView(showsIndicators: false) {
                        ForEach(previousRolls.reversed()[1...]) { roll in //sar peste primul element
                            HistoryItem(roll: roll)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .trailing], 44)
                    .padding(.top, 20)
                    
                }
                else {
                    VStack(alignment: .center) {
                        Image("illustration_empty_history")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 152, height: 108, alignment: .center)
                            .padding(.bottom, 24)
                        Text("Nu ai istoric încă")
                            .font(Font.titan(size: 24))
                            .foregroundColor(Color.init(hex: "#D87153"))
                            .padding(.bottom, 16)
                        Text("Dă shake sau învârte zarurile, aici vor apărea toate scorurile tale")
                            .frame(width: 304, alignment: .center)
                            .font(Font.titan(size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
    }
}

struct HistoryItem: View {
    var roll: DiceRoll
    
    var isDouble: Bool { roll.firstDice == roll.secondDice }
    var textColor: Color { isDouble ? Color.init(hex: "#D87153") : Color.init(hex: "#F2E7C9") }
    
    var body: some View {
        HStack {
            Text("\(roll.firstDice + roll.secondDice)")
                .frame(width: 24, alignment: .leading)
                .foregroundColor(textColor)
                .font(Font.titan(size: 20))
                .padding(.leading, 24)
                .padding(.trailing, 20)
            Text("\(roll.firstDice)-\(roll.secondDice)")
                .foregroundColor(textColor)
                .font(Font.titan(size: 20))
            Text(roll.date, format: .dateTime.day().month().hour().minute())
                .foregroundColor(textColor)
                .font(Font.titan(size: 14))
                .frame(alignment: .center)
            Spacer()
            
            if isDouble {
                Text("Dublă")
                    .foregroundColor(textColor)
                    .font(Font.titan(size: 20))
                    .frame(alignment: .trailing)
                    .padding(.trailing, 24)
            }
        }
        .frame(height: 40, alignment: .center)
        .background(Color.black.opacity(0.7))
        .cornerRadius(24)
    }
}


struct NavigationBar: View {
    
    var showTitle: Bool
    var backAction: () -> ()
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                backAction()
                impactMed.impactOccurred()
            } label: {
                Image("ic_nav_back")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            
            if showTitle {
                Text("Istoric")
                    .font(Font.titan(size: 24))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            Spacer()
        }
        .frame(height: 56, alignment: .center)
        .padding(.leading, 20)
    }
}

struct HistoryScreen_Preview: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
