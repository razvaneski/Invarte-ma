//
//  SplashScreen.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundView()
            
            Image("illustration_app")
                .resizable()
                .padding([.leading, .trailing], 20)
                .frame(height: 128)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
