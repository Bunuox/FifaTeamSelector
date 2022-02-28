//
//  ContentView.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var teamVM = TeamVM()
    @State private var team1Player1 = ""
    @State private var team1Player2 = ""
    @State private var team2Player1 = ""
    @State private var team2Player2 = ""
    
    @State private var numberOfPlayers = 2
    
    @State private var team1 = Team(name: "Manchester City", league: "Premier League", level: "Champions")
    @State private var team2 = Team(name: "Manchester United", league: "Premier League", level: "Champions")
    
    @State private var disabled = false
    @State private var navigationEnabled = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Stepper(value: $numberOfPlayers, in: 2...4, step: 2) {
                    Text("Oyuncu sayısı: \(numberOfPlayers)")
                }
                .disabled(disabled)
                .padding()
                
                TeamsView(team1: team1, team2: team2)
                    .animation(.default, value: 1)
                
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        if numberOfPlayers == 4 {
                            TextField("Oyuncu 1: ", text: $team1Player1)
                            TextField("Oyuncu 2: ", text: $team1Player2)
                        } else {
                            TextField("Oyuncu 1: ", text: $team1Player1)
                        }
                        
                    }
                    .padding()
                    Spacer()
                    VStack(alignment: .center) {
                        if numberOfPlayers == 4 {
                            TextField("Oyuncu 1: ", text: $team2Player1)
                            TextField("Oyuncu 2: ", text: $team2Player2)
                        } else {
                            TextField("Oyuncu 1: ", text: $team2Player1)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        matchTeams()
                    }
                    
                } label: {
                    Text("Takımları Belirle")
                        .padding()
                        .background(disabled ? .gray : .red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                }
                .disabled(disabled)
                
                
                NavigationLink(destination: MatchResultView(team1: team1, team2: team2, team1Player1: team1Player1, team1Player2: team1Player2, team2Player1: team2Player1, team2Player2: team2Player2), isActive: $navigationEnabled) {
                    Button {
                        navigationEnabled.toggle()
                    } label: {
                        Text("maç kaydet")
                            .padding()
                            .foregroundColor(.primary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(disabled ? .black : .red, lineWidth: 3)
                            )
                    }
                }
                Spacer()
                Spacer()
            }
            .navigationTitle("Fifa")
            .toolbar {
                NavigationLink(destination: MatchesView()) {
                    Text("Button")
                }
            }
        }
        
    }
    
    func matchTeams() {
        disabled = true
        let allTeams = teamVM.teams.shuffled()
        let teamsCount = allTeams.count
        var team1Index = 0
        var team2Index = 0
        
        while(true) {
            
            team1Index = Int.random(in: 0..<teamsCount)
            team2Index = Int.random(in: 0..<teamsCount)
            
            
            if(team1Index != team2Index) {
                break
            }
        }
        
        for val in 0..<teamsCount/2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.25*Double(val))) {
                withAnimation {
                    team2 = allTeams[val]
                    team1 = allTeams[teamsCount/2 - val]
                    
                    if val == teamsCount/2 - 1 {
                        
                        team1 = allTeams[team1Index]
                        team2 = allTeams[team2Index]
                        disabled = false
                    }
                }
            }
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
