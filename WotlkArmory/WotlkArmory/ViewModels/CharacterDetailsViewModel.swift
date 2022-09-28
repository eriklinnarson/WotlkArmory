//
//  CharacterDetailsViewModel.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-28.
//

import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    
    @Published private var model: CharacterDetailsModel
    var character: CharacterDetails? { model.characterDetails }
    
    @Published var isFetching: Bool = false
    
    init() {
        self.model = CharacterDetailsModel()
    }
    
    func fetchCharacterDetailed(characterName: String, characterServer: String) {
        
        DispatchQueue.main.async {
            self.isFetching = true
        }
        
        guard let url = URL(string: "https://ironforge.pro/api/players?player=" + characterName + "-" + characterServer) else {
            DispatchQueue.main.async {
                self.isFetching = false
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.isFetching = false
                }
                return
            }
            
            do {
                let characterData = try JSONDecoder().decode(CharacterData.self, from: data)
                DispatchQueue.main.async {
                    self?.model.characterDetails = characterData.info
                    self?.isFetching = false
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
