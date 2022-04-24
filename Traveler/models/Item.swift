//
//  Item.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/3/22.
//

import Foundation

enum GENDER {
    case FEMALE
    case MALE
}

enum SHIRTS {
    case T_SHIRT
    case DRESS_SHIRT
}

enum CATAGORYS {
    case SOCKS
    case JEANS
    case SHORTS
    case UNDERWEAR
}

struct Item {
    var itemName: String
    var quantity: Int
    var catagory: CATAGORYS
    var shirt: SHIRTS
    var isComplected: Bool
}


/**
 
-----------------------------------
| name | qty | catagory |         |
-----------------------------------
|      |     |          |         |
-----------------------------------

**/
