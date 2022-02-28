//
//  Match.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import Foundation

struct Match: Identifiable, Codable {
    var id = UUID()
    var team1: Team
    var team2: Team
    var team1Player1: String
    var team1Player2: String?
    var team2Player1: String
    var team2Player2: String?
    var team1Result: Int
    var team2Result: Int
}
