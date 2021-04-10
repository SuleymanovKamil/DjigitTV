//
//  Channel.swift
//  DjigitTV
//
//  Created by Камиль Сулейманов on 09.04.2021.
//

import SwiftUI

struct channel: Codable, Hashable{
    let name: String
    let img: String
    let url: String
}


let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width
let small = UIScreen.main.bounds.height < 750
