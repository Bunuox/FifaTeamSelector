//
//  Team.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import Foundation

struct Team: Codable, Identifiable{
    var id = UUID()
    var name : String
    var league : String
    var level : String // Anadolu, UEFA, Champions League maybe Exotic (Argentina, Brazil vs.)
}
