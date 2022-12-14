//
//  ItemIconView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-28.
//

import SwiftUI

struct ItemIconView: View {
    
    private var item: Item?
    
    init(item: Item?) {
        self.item = item
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = GlobalConstants.cornerRadius
        static let lineWidth: CGFloat = GlobalConstants.lineWidth
        static let defaultBackgroundColor: Color = Color.gray
    }
    
    var body: some View {
        if (item != nil) {
            existingItem
        }
        else {
            nullItem
        }
    }
    
    var nullItem: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Constants.defaultBackgroundColor)
    }
    
    var existingItem: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(UIColor.systemBackground))
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .strokeBorder(lineWidth: Constants.lineWidth)
                    .foregroundColor(itemRarityColor(rarity: item!.rarity))
                AsyncImage(url: URL(string: "https://ironforge.pro/media/\(item!.id).jpg")) { image in
                    image
                        .resizable()
                } placeholder: {
                    Constants.defaultBackgroundColor
                }
                .frame(
                    width: geometry.size.width - Constants.lineWidth * 2,
                    height: geometry.size.height - Constants.lineWidth * 2
                )
            }
        }
    }
}

struct ItemIconView_Previews: PreviewProvider {
    static var previews: some View {
        let item1 = Item(id: 30098, gs: 128, rarity: "epic", name: "Razor-Scale Battlecloak")
        let item2 = Item(id: 28373, gs: 115, rarity: "rare", name: "Cloak of Scintillating Auras")
        let item3 = Item(id: 31820, gs: 102, rarity: "uncommon", name: "Blessed Signet Ring")
        VStack {
            ItemIconView(item: item1)
                .frame(width: 100, height: 100)
            ItemIconView(item: item2)
                .frame(width: 100, height: 100)
            ItemIconView(item: item3)
                .frame(width: 100, height: 100)
            ItemIconView(item: nil)
                .frame(width: 100, height: 100)
        }
    }
}
