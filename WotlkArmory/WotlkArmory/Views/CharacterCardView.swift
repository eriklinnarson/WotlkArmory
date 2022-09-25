//
//  CharacterSummaryView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

struct CharacterCardView: View {
    
    private var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 5
        static let factionIconScale: CGFloat = 0.5
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(.white)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .strokeBorder(lineWidth: Constants.lineWidth)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(character.name), \(character.server)")
                            .font(.largeTitle)
                        Spacer()
                        Image(character.faction) // The name of the images in assets correspond to the names found in the API-response
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * Constants.factionIconScale)
                    }
                    Text("\(character.clas), ItemLevel \(String(character.gearscore))")
                }
                .padding()
                
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct CharacterSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(name: "Toteman", server: "Jindo", faction: "Alliance", clas: "Shaman", gearscore: 123)
        CharacterCardView(character: character)
            .frame(height: 200)
    }
}
