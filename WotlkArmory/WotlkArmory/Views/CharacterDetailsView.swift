//
//  CharacterDetailsView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-26.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @StateObject var viewModel = CharacterDetailsViewModel()
    private var characterName: String
    private var characterServer: String
    
    init(characterName: String, characterServer: String) {
        self.characterName = characterName
        self.characterServer = characterServer
    }
    
    struct Constants {
        static let itemSizeToScreenHeight: CGFloat = 0.1
    }
    
    func resizedItemIconView(item: Item, screenHeight: CGFloat) -> some View {
        ItemIconView(item: item)
            .frame(
                width: screenHeight * Constants.itemSizeToScreenHeight,
                height: screenHeight * Constants.itemSizeToScreenHeight
            )
    }
    
    var body: some View {
        if(viewModel.isFetching) {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        else {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height
                VStack {
                    Text(viewModel.characterName + "-" + viewModel.characterServer)
                    HStack {
                        VStack {
                            resizedItemIconView(item: viewModel.Head, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Neck, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Shoulder, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Cloak, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Chest, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Shirt, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Tabard, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Wrist, screenHeight: screenHeight)
                        }
                        Spacer()
                        VStack {
                            resizedItemIconView(item: viewModel.Hands, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Waist, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Legs, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Feet, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Ring1, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Ring2, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Trinket1, screenHeight: screenHeight)
                            resizedItemIconView(item: viewModel.Trinket2, screenHeight: screenHeight)
                        }
                        
                    }
                    HStack {
                        resizedItemIconView(item: viewModel.MainHand, screenHeight: screenHeight)
                        resizedItemIconView(item: viewModel.OffHand, screenHeight: screenHeight)
                        resizedItemIconView(item: viewModel.Ranged, screenHeight: screenHeight)
                    }
                }
            }
            .onAppear {
                viewModel.fetchCharacterDetailed(characterName: characterName, characterServer: characterServer)
            }
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(characterName: "Totemancer", characterServer: "Earthshaker")
    }
}
