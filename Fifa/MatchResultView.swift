//
//  MatchResultView.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import SwiftUI

struct MatchResultView: View {
    @StateObject private var matchVM = MatchVM()
    var team1: Team
    var team2: Team
    var team1Player1: String
    var team1Player2: String?
    var team2Player1: String
    var team2Player2: String?
    
    @FocusState var isInputActive: Bool
    
    @State private var team1Result = ""
    @State private var team2Result = ""
    
    var body: some View {
        VStack {
            Image("swords")
                .resizable()
                .frame(width: 100, height: 100)
            TeamsView(team1: team1, team2: team2)
            
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text(team1Player1)
                    Text(team1Player2 ?? "")
                }
                .padding()
                Spacer()
                VStack(alignment: .center) {
                    Text(team2Player1)
                    Text(team2Player2 ?? "")
                }
                .padding()
                Spacer()
                
            }
            HStack(alignment: .center) {
                TextField("Sonuç", text: $team1Result)
                    .keyboardType(.decimalPad)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Text("-")
                TextField("Sonuç", text: $team2Result)
                    .keyboardType(.decimalPad)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .focused($isInputActive)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            
            Button {
                matchVM.saveMatches(match: Match(team1: team1, team2: team2, team1Player1: team1Player1, team1Player2: team1Player2, team2Player1: team2Player1, team2Player2: team2Player2, team1Result: Int(team1Result)!, team2Result: Int(team2Result)!))
            } label: {
                Text("Sonucu Kaydet")
                    .padding()
                    .overlay(
                        Capsule()
                            .stroke(.red, lineWidth: 5)
                    )
                    .foregroundColor(.primary)
            }
            
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct MatchResultView_Previews: PreviewProvider {
    static var previews: some View {
        MatchResultView(team1: Team(name: "Manchester City", league: "Premier League", level: "Champions"), team2: Team(name: "Manchester United", league: "Premier League", level: "Champions"), team1Player1: "ss", team2Player1: "ff")
    }
}
