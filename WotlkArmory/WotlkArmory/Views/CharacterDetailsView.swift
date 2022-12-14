//
//  CharacterDetailsView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-26.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @StateObject var viewModel = CharacterDetailsViewModel()
    private var info: CharacterShortInfo
    
    init(characterShortInfo: CharacterShortInfo) {
        self.info = characterShortInfo
    }
    
    struct Constants {
        static let itemSizeToScreenHeight: CGFloat = 0.105
        static let factionIconScale: CGFloat = 0.2
        static let itemNotHighlightedCapacity: Double = 0.25
        static let highlightItemAnimationDuration: Double = 0.2
        static let itemLevelTextColor: Color = Color.yellow
        
        static let lineWidth = GlobalConstants.lineWidth
        static let cornerRadius = GlobalConstants.cornerRadius
        static let progressViewScaleEffect = GlobalConstants.progressViewScaleEffect
    }
    
    var highlightingAnimation: Animation {
        Animation.easeInOut(duration: Constants.highlightItemAnimationDuration)
    }
    
    func resizedItemIconView(item: Item, screenHeight: CGFloat) -> some View {
        ItemIconView(item: item)
            .frame(
                width: screenHeight * Constants.itemSizeToScreenHeight,
                height: screenHeight * Constants.itemSizeToScreenHeight
            )
            .opacity(item != viewModel.highlightedItem && viewModel.highlightedItem != nil ? Constants.itemNotHighlightedCapacity : 1)
            .onTapGesture {
                withAnimation(highlightingAnimation) {
                    viewModel.highlightItem(item: item)
                }
            }
    }
    
    var highlightedItemInfoBox: some View {
        let highlighted = viewModel.highlightedItem!
        return ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .foregroundColor(Color(UIColor.systemBackground))
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .strokeBorder(lineWidth: Constants.lineWidth)
                .foregroundColor(itemRarityColor(rarity: highlighted.rarity))
            VStack(alignment: .leading) {
                Text(highlighted.name)
                    .foregroundColor(itemRarityColor(rarity: highlighted.rarity))
                    .font(.title)
                Text("Item Level \(highlighted.gs)")
                    .foregroundColor(Constants.itemLevelTextColor)
                Spacer()
                Link(destination: URL(string: "https://tbc.wowhead.com/item=\(highlighted.id)")!) {
                    Text("View on WoWHead")
                        .underline()
                }
            }
            .padding()
            .fontWeight(.bold)
        }
    }
    
    var body: some View {
        if (viewModel.error == true) {
            Text("Error loading character.")
        }
        else if(viewModel.isFetching) {
            VStack {
                Spacer()
                ProgressView()
                    .scaleEffect(Constants.progressViewScaleEffect)
                Spacer()
            }
        }
        else {
            VStack {
                Text(viewModel.characterName + "-" + viewModel.characterServer)
                    .font(.title)
                HStack {
                    Text("\(info.clas), Item Level \(Int(info.gearscore))")
                }
                
                GeometryReader { geometry in
                    let screenHeight = geometry.size.height
                    VStack {
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
                            ZStack {
                                VStack {
                                    Image(info.faction) // The name of the images in assets correspond to the names found in the API-response
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: geometry.size.height * Constants.factionIconScale)
                                }
                                .opacity(viewModel.highlightedItem == nil ? 1 : 0)
                                
                                if(viewModel.highlightedItem != nil) {
                                    GeometryReader { geometry in
                                        VStack {
                                            Spacer()
                                            highlightedItemInfoBox
                                                .frame(height: geometry.size.width)
                                            Spacer()
                                        }
                                    }
                                }
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
            }
            .padding()
            .onAppear {
                viewModel.fetchCharacterDetailed(characterName: info.name, characterServer: info.server)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(highlightingAnimation) {
                    viewModel.removeHighlighting()
                }
            }
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let info = CharacterShortInfo(name: "Totemancer", server: "Earthshaker", faction: "Horde", clas: "Shaman", gearscore: 123)
        CharacterDetailsView(characterShortInfo: info)
    }
}
