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
    
    var body: some View {
        if(viewModel.isFetching) {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        else {
            NavigationView {
                Text(viewModel.character?.name ?? "Unavailable")
                .onAppear {
                    viewModel.fetchCharacterDetailed(characterName: characterName, characterServer: characterServer)
                }
            }
        }
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(characterName: "Totemancer", characterServer: "Earthshaker")
    }
}
