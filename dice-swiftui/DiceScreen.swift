//
//  DiceScreen.swift
//  dice-swiftui
//
//  Created by Radu Paun on 05.05.2022.
//

import Foundation
import SwiftUI

struct DiceScreen: View {
    
    @ObservedObject var viewModel: DiceViewModel
    @AppStorage("previousRolls") private var previousRolls: [DiceRoll] = []
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    let generator = UINotificationFeedbackGenerator()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                BackgroundView()
                
                VStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .center, spacing: 0) {
                        PreviousDiceView(viewModel: viewModel)
                        
                        Image("illustration_app")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 128, alignment: .center)
                            .padding(.top, 28)
                    }
                    .padding([.leading, .trailing], 28)
                    
                    DiceView(viewModel: viewModel)
                        .padding(.top, 52)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 0) {
                        
                        Button {
                            impactMed.impactOccurred()
                            viewModel.newRoll()
                        } label: {
                            Text("Învârte zarurile")
                                .frame(height: 48)
                                .font(Font.titan(size: 16))
                                .padding([.leading, .trailing], 56)
                                .background(Color.init(hex: "#D87153"))
                                .cornerRadius(24)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 20)
                        .onShake {
                            impactMed.impactOccurred()
                            viewModel.newRoll()
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text("...sau dă shake")
                                .font(Font.titan(size: 16))
                                .foregroundColor(.white)
                            
                            Image("ic_shake")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
                        }
                    }
                    
                    Image("bg_footer")
                        .resizable()
                        .ignoresSafeArea()
                        .aspectRatio(CGSize(width: 360, height: 170), contentMode: .fit)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                if viewModel.showDialog && !viewModel.showAnimation {

                    ZStack {
                        Color.black.opacity(0.4)
                        
                        DoubleDiceDialog(action: { viewModel.showDialog = false })
                            .animation(.default)
                            .transition(.slide)
                            .onAppear {
                                generator.notificationOccurred(.success)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PreviousDiceView: View {
    @AppStorage("previousRolls") private var previousRolls: [DiceRoll] = []
    @ObservedObject var viewModel: DiceViewModel
    
    var showLastDice: Bool { previousRolls.count > 1 }
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationLink {
            HistoryScreen()
        } label: {
            HStack {
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    HStack {
                        VStack(alignment: .trailing, spacing: 0) {
                            Text("Zarul anterior")
                                .foregroundColor(.white)
                                .font(Font.titan(size: 14))
                            if showLastDice {
                                let lastDice = previousRolls.reversed()[1]
                                Text("\(lastDice.firstDice)-\(lastDice.secondDice)")
                                    .foregroundColor(.white)
                                    .font(Font.titan(size: 14))
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 8)
                        
                        Image("ic_nav_history")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.trailing, 4)
                    }
                    .frame(height: 48)
                    .background(Color.black)
                    .cornerRadius(24)
                }
                .frame(height: 48, alignment: .center)
            }
        }
        .onTapGesture {
            impactMed.impactOccurred()
        }
    }
}

struct DiceView: View {
    
    @ObservedObject var viewModel: DiceViewModel
    
    var body: some View {
        if viewModel.showAnimation {
            HStack(alignment: .center, spacing: 48) {
                LottieView(name: "Dice_shuffle_01", loopMode: .playOnce, viewModel: viewModel)
                    .frame(width: 108, height: 108, alignment: .center)
                LottieView(name: "Dice_shuffle_02", loopMode: .playOnce, viewModel: viewModel)
                    .frame(width: 108, height: 108, alignment: .center)
            }
        } else {
            ZStack {
                HStack(alignment: .center, spacing: 48) {
                    Image("dice_face_0\(viewModel.firstDiceValue)")
                        .frame(width: 108, height: 108, alignment: .center)
                    
                    Image("dice_face_0\(viewModel.secondDiceValue)")
                        .frame(width: 108, height: 108, alignment: .center)
                }
            }
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("bg_pattern")
            .resizable()
            .ignoresSafeArea()
    }
}

struct DiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        DiceScreen(viewModel: DiceViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
