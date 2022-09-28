//
//  Character.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import Foundation

struct Character: Hashable, Codable {
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
    let Cloak: [Item]
    let Shoulder: [Item]
}

struct Item: Hashable, Codable {
    let id: Int
    let gs: Int
    let rarity: String
    let name: String
}
