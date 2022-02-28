//
//  MatchVM.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import Foundation

class MatchVM: ObservableObject {
    @Published var matches = [Match]()
    
    init(){
        matches = loadMatches()
        print(matches)
    }
    
    func loadMatches() -> [Match] {
        if let data = UserDefaults.standard.value(forKey: "matches") as? Data {
            if let matchesData = try? PropertyListDecoder().decode([Match].self, from: data){
                return matchesData
            }
        }
        return [Match]()
    }
    
    func saveMatches(match: Match) {
        matches.append(match)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(matches), forKey: "matches")
    }
}
