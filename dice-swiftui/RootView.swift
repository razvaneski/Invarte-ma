//
//  RootView.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel = DiceViewModel()
    
    var body: some View {
        if viewModel.showSplash {
            SplashScreen()
        } else {
            DiceScreen(viewModel: viewModel)
        }
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
