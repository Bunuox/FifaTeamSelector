//
//  ContentView.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    enum TeamLevels: String, Identifiable, CaseIterable {
        case Champions, UEFA
        var id: Self {self}
    }
    
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
    
    @State private var teamLevel: TeamLevels = .Champions
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Stepper(value: $numberOfPlayers, in: 2...4, step: 2) {
                    Text("Oyuncu sayısı: \(numberOfPlayers)")
                }
                .disabled(disabled)
                .padding()
                .onChange(of: numberOfPlayers) { _ in
                    if numberOfPlayers == 2 {
                        team1Player2 = ""
                        team2Player2 = ""
                    }
                }
                
                Section("Takımların Seviyesi") {
                    Picker("Takımların Seviyesi", selection: $teamLevel) {
                        ForEach(TeamLevels.allCases) { level in
                            Text(level.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: teamLevel) { newValue in
                        if teamLevel == .Champions {
                            team1 = Team(name: "Manchester City", league: "Premier League", level: "Champions")
                            team2 = Team(name: "Manchester United", league: "Premier League", level: "Champions")
                        }
                        
                        if teamLevel == .UEFA {
                            team1 = Team(name: "WestHam United", league: "Premier League", level: "UEFA")
                            team2 = Team(name: "Southampton", league: "Premier League", level: "UEFA")
                        }
                    }
                    .disabled(disabled)
                }

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
                    Text("Kayıtlı Maçlar")
                }
            }
        }
        
    }
    
    func matchTeams() {
        disabled = true
        //let allTeams = teamVM.teams.shuffled()
        
        let filteredTeams = teamVM.teams.shuffled().filter { team in
            team.level == teamLevel.rawValue
        }
        
        let teamsCount = filteredTeams.count
        var team1Index = 0
        var team2Index = 0
        
        while(true) {
            
            team1Index = Int.random(in: 0..<teamsCount)
            team2Index = Int.random(in: 0..<teamsCount)
            
            
            if(team1Index != team2Index) {
                break
            }
        }
        
        for val in 0..<teamsCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + (0.2*Double(val))) {
                withAnimation {
                    team2 = filteredTeams[val]
                    team1 = filteredTeams[(teamsCount-1) - val]
                    
                    if val == teamsCount - 1 {
                        
                        team1 = filteredTeams[team1Index]
                        team2 = filteredTeams[team2Index]
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
