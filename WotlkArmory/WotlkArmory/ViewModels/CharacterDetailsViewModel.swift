//
//  CharacterDetailsViewModel.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-28.
//

import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    
    @Published private var model: CharacterDetailsModel
    var characterData: CharacterData? { model.characterData }
    
    @Published var isFetching: Bool = false
    @Published var error: Bool = false
    
    @Published var highlightedItem: Item?
    
    var characterName: String { characterData?.info.name ?? "Name not available" }
    var characterServer: String { characterData?.info.server ?? "Server not available" }
    var characterFaction: String { characterData?.info.faction ?? "Faction not available" }
    var characterClass: String { characterData?.info.clas ?? "Class unavailable" }
    
    var defaultItem: Item = Item(id: 0, gs: 0, rarity: "", name: "No item")
    var Head: Item { characterData?.g.all.Head?[0] ?? defaultItem }
    var Neck: Item { characterData?.g.all.Neck?[0] ?? defaultItem }
    var Shoulder: Item { characterData?.g.all.Shoulder?[0] ?? defaultItem }
    var Cloak: Item { characterData?.g.all.Cloak?[0] ?? defaultItem }
    var Chest: Item { characterData?.g.all.Chest?[0] ?? defaultItem }
    var Shirt: Item { defaultItem } // Shirt info not included in API
    var Tabard: Item { defaultItem } // Tabard info not included in API
    var Wrist: Item { characterData?.g.all.Wrist?[0] ?? defaultItem }
    var Hands: Item { characterData?.g.all.Hands?[0] ?? defaultItem }
    var Waist: Item { characterData?.g.all.Waist?[0] ?? defaultItem }
    var Legs: Item { characterData?.g.all.Legs?[0] ?? defaultItem }
    var Feet: Item { characterData?.g.all.Feet?[0] ?? defaultItem }
    var Ring1: Item { characterData?.g.all.Ring?[0] ?? defaultItem }
    var Ring2: Item { characterData?.g.all.Ring?[1] ?? defaultItem }
    var Trinket1: Item { characterData?.g.all.Trinket?[0] ?? defaultItem }
    var Trinket2: Item { characterData?.g.all.Trinket?[1] ?? defaultItem }
    var MainHand: Item { characterData?.g.all.MainHand?[0] ?? defaultItem }
    var OffHand: Item { characterData?.g.all.OffHand?[0] ?? defaultItem }
    var Ranged: Item { characterData?.g.all.Ranged?[0] ?? defaultItem }
    
    init() {
        self.model = CharacterDetailsModel()
    }
    
    /// Select an item to be highlighted.
    /// - Parameter item: the item to be highlighted.
    func highlightItem(item: Item) {
        if(highlightedItem == item) {
            highlightedItem = nil
        }
        else if(item.id != 0) {
            highlightedItem = item
        }
    }
    
    /// Make the item currently selected not highlighted anymore.
    func removeHighlighting() {
        highlightedItem = nil
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
                    self?.model.characterData = characterData
                    self?.isFetching = false
                }
            }
            catch {
                print(error)
                print("abow knas mannen")
                DispatchQueue.main.async {
                    self?.isFetching = false
                    self?.error = true
                }
            }
        }
        task.resume()
    }
}
