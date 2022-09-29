//
//  CharacterSummaryView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

struct CharacterCardView: View {
    
    private var character: CharacterShortInfo
    
    init(character: CharacterShortInfo) {
        self.character = character
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 7
        static let lineWidth: CGFloat = 3
        static let factionIconScale: CGFloat = 0.8
        static let factionIconOpacity: CGFloat = 0.5
        static let padding: CGFloat = 10
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Image(character.clas) // The name of the images in assets correspond to the names found in the API-response
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * Constants.factionIconScale)
                        .opacity(Constants.factionIconOpacity)
                    Spacer()
                    VStack(alignment: .center) {
                        Text("\(character.name) - \(character.server)")
                            .font(.largeTitle)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("Itemlevel \(String(character.gearscore))")
                    }
                    Spacer()
                    Image(character.faction) // The name of the images in assets correspond to the names found in the API-response
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * Constants.factionIconScale)
                        .opacity(Constants.factionIconOpacity)
                }
                .padding(Constants.padding)
                
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct CharacterSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let character = CharacterShortInfo(name: "Toteman", server: "Jindo", faction: "Alliance", clas: "Shaman", gearscore: 123)
        CharacterCardView(character: character)
            .frame(height: 200)
    }
}
