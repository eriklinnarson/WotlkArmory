//
//  ViewHelperFunctions.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-29.
//

import SwiftUI

/**
 This file contains functions and structs that is shared between views.
 */

struct GlobalConstants {
    static let cornerRadius: CGFloat = 5
    static let lineWidth: CGFloat = 5
    
    static let progressViewScaleEffect: CGFloat = 1.5
}

func itemRarityColor(rarity: String) -> Color {
    switch rarity {
    case "uncommon": return Color.green
    case "rare": return Color.blue
    case "epic": return Color.purple
    case "legendary": return Color.orange
    default: return Color.gray
    }
}
