//
//  ViewModel.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published private var model: Model
    var characters: [Character] { model.characters }
    
    init() {
        self.model = Model()
    }
    
    func fetchCharacters(searchString: String) {
        guard let url = URL(string: "https://ironforge.pro/api/players?search=" + searchString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self?.model.characters = characters
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
