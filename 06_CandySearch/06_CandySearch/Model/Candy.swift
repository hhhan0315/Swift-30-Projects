//
//  Candy.swift
//  06_CandySearch
//
//  Created by rae on 2021/12/02.
//

import Foundation

struct Candy {
    var name: String
    var category: String
}

extension Candy {
    static var testData: [Candy] = [
        Candy(name:"Chocolate Bar", category:"Chocolate"),
        Candy(name:"Chocolate Chip", category:"Chocolate"),
        Candy(name:"Dark Chocolate", category:"Chocolate"),
        Candy(name:"Lollipop", category:"Hard"),
        Candy(name:"Candy Cane", category:"Hard"),
        Candy(name:"Jaw Breaker", category:"Hard"),
        Candy(name:"Caramel", category:"Other"),
        Candy(name:"Sour Chew", category:"Other"),
        Candy(name:"Gummi Bear", category:"Other"),
    ]
}
