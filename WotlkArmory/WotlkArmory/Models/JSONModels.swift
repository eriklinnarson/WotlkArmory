//
//  Character.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import Foundation

struct CharacterShortInfo: Hashable, Codable {
    let name: String
    let server: String
    let faction: String
    let clas: String
    let gearscore: Double
}

struct CharacterData: Hashable, Codable {
    let info: CharacterDetails
    let g: AllItems
}

struct CharacterDetails: Hashable, Codable {
    let name: String
    let server: String
    let faction: String
    let clas: String
    let gearscore: Double
}

struct AllItems: Hashable, Codable {
    let all: ItemSlots
}

struct ItemSlots: Hashable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case MainHand = "Main Hand" // Coding Keys needed because of this property and the one below
        case OffHand = "Off Hand"
        
        case Cloak = "Cloak"
        case Shoulder = "Shoulder"
        case Feet = "Feet"
        case Trinket = "Trinket"
        case Neck = "Neck"
        case Ring = "Ring"
        case Ranged = "Ranged"
        case Waist = "Waist"
        case Chest = "Chest"
        case Hands = "Hands"
        case Head = "Head"
        case Legs = "Legs"
        case Wrist = "Wrist"
    }
    
    let Cloak: [Item]
    let Shoulder: [Item]
    let Feet: [Item]
    let Trinket: [Item]
    let MainHand: [Item]
    let Neck: [Item]
    let Ring: [Item]
    let Ranged: [Item]
    let Waist: [Item]
    let Chest: [Item]
    let Hands: [Item]
    let Head: [Item]
    let Legs: [Item]
    let Wrist: [Item]
    let OffHand: [Item]
}

struct Item: Hashable, Codable {
    let id: Int
    let gs: Int
    let rarity: String
    let name: String
}
