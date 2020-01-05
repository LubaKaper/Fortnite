//
//  ItemModel.swift
//  Unit3-PersonalProject-Fortnite
//
//  Created by Liubov Kaper  on 1/5/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Item: Decodable {
    let imageUrl: String
    let name: String
    let rarity: String
    let vBucks: Int
}

