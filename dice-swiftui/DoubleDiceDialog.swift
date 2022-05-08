//
//  DoubleDiceDialog.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

struct DoubleDiceDialog: View {
    
    var action: () -> ()
    
    var body: some View {
        
        VStack {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Text("Ai dat dublă!")
                    .foregroundColor(Color.init(hex: "#D87153"))
                    .font(Font.titan(size: 24))
                    .padding(.bottom, 16)
                    .padding(.top, 48)
                Text("Foarte tare! Bravo, mai încearcă până mai dai o dată!")
                    .foregroundColor(.white)
                    .font(Font.titan(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.leading, 31)
                    .padding(.trailing, 31)
                    .padding(.bottom, 32)
                Button {
                    withAnimation {
                        action()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color.init(hex: "#D87153"))
                            .frame(width: 218, height: 48, alignment: .center)
                        Text("Super tare, mersi!")
                            .foregroundColor(.white)
                            .font(Font.titan(size: 16))
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(Color.init(hex: "#332F2C"))
            .cornerRadius(20)
            .addBorder(Color.init(hex: "#F2E7C9"), width: 4, cornerRadius: 20)
            .padding([.leading, .trailing], 20)
        }
    }
}

struct DoubleDiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        DoubleDiceDialog(action: {print("some")})
    }
}
