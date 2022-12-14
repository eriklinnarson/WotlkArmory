//
//  ViewModel.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

class SearchResultViewModel: ObservableObject {
    var characters: [CharacterShortInfo] = []
    
    @Published var isFetching: Bool = false
    @Published var error: Bool = false
    
    func fetchCharacters(searchString: String) {
        
        DispatchQueue.main.async {
            self.isFetching = true
        }
        
        guard let url = URL(string: "https://ironforge.pro/api/players?search=" + searchString) else {
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
                let characters = try JSONDecoder().decode([CharacterShortInfo].self, from: data)
                DispatchQueue.main.async {
                    self?.characters = characters
                    self?.isFetching = false
                }
            }
            catch {
                print(error)
                DispatchQueue.main.async {
                    self?.isFetching = false
                    self?.error = true
                }
            }
        }
        
        task.resume()
    }
}
