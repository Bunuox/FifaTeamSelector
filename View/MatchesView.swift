//
//  MatchesView.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import SwiftUI

struct MatchesView: View {
    @StateObject private var matchVM = MatchVM()
    
    private var match = [Match(team1: Team(name: "Manchester City", league: "Premier League", level: "Champions"), team2: Team(name: "Manchester United", league: "Premier League", level: "Champions"), team1Player1: "Bünyamin", team2Player1: "Yusuf",team1Result: 5, team2Result: 2)]
    
    var body: some View {
        VStack {
            List {
                ForEach(matchVM.matches) { m in
                    HStack {
                        Spacer()
                        VStack {
                            Text(m.team1Player1)
                            Text(m.team1Player2 ?? "")
                        }
                        
                        Image(m.team1.name)
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text(String(m.team1Result))
                        Text("-")
                        Text(String(m.team2Result))
                        Image(m.team2.name)
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        VStack {
                            Text(m.team2Player1)
                            Text(m.team2Player2 ?? "")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
