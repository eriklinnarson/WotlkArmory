//
//  Model.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import Foundation

struct SearchResultModel {
    var characters: [CharacterShortInfo]
    
    init() {
        self.characters = []
    }
}
