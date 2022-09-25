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
