//
//  TeamVM.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import Foundation

class TeamVM: ObservableObject {
    var teams : [Team] = {
        if let data = UserDefaults.standard.value(forKey: "teams") as? Data {
            if let teamsData = try? PropertyListDecoder().decode([Team].self, from: data){
                return teamsData
            }
        }
        
        return [Team]()
    }()
    
    init(){
        if teams.isEmpty {
            writeData()
        }
        teams = loadTeams()
    }
    
    func loadTeams() -> [Team] {
        if let data = UserDefaults.standard.value(forKey: "teams") as? Data {
            if let teamsData = try? PropertyListDecoder().decode([Team].self, from: data){
                return teamsData
            }
        }
        
        return [Team]()
    }
    
    func writeData() {
        var teams = [Team]()
        //Premier League League (Champions)
        teams.append(Team(name: "Manchester City", league: "Premier League", level: "Champions"))
        teams.append(Team(name: "Liverpool", league: "Premier League", level: "Champions"))
        teams.append(Team(name: "Chelsea", league: "Premier League", level: "Champions"))
        teams.append(Team(name: "Manchester United", league: "Premier League", level: "Champions"))
        teams.append(Team(name: "Arsenal", league: "Premier League", level: "Champions"))
        teams.append(Team(name: "Tottenham", league: "Premier League", level: "Champions"))
        //Premier League League (UEFA)
        teams.append(Team(name: "WestHam United", league: "Premier League", level: "UEFA"))
        teams.append(Team(name: "Leicester", league: "Premier League", level: "UEFA"))
        teams.append(Team(name: "Southampton", league: "Premier League", level: "UEFA"))
        teams.append(Team(name: "Everton", league: "Premier League", level: "UEFA"))
        
        //Bundesliga (Champions)
        teams.append(Team(name: "Bayern Munchen", league: "Bundesliga", level: "Champions"))
        teams.append(Team(name: "Borussia Dortmund", league: "Bundesliga", level: "Champions"))
        teams.append(Team(name: "Bayer Leverkusen", league: "Bundesliga", level: "Champions"))
        
        //Bundesliga (UEFA)
        teams.append(Team(name: "Freiburg", league: "Bundesliga", level: "UEFA"))
        teams.append(Team(name: "Leipzig", league: "Bundesliga", level: "UEFA"))
        teams.append(Team(name: "Hoffenheim", league: "Bundesliga", level: "UEFA"))
        
        //La Liga (Champions)
        teams.append(Team(name: "Real Madrid", league: "La Liga", level: "Champions"))
        teams.append(Team(name: "Barcelona", league: "La Liga", level: "Champions"))
        teams.append(Team(name: "Sevilla", league: "La Liga", level: "Champions"))
        teams.append(Team(name: "Atletico Madrid", league: "La Liga", level: "Champions"))
        
        //La Liga (UEFA)
        teams.append(Team(name: "Real Betis", league: "La Liga", level: "UEFA"))
        teams.append(Team(name: "Villarreal", league: "La Liga", level: "UEFA"))
        teams.append(Team(name: "Valencia", league: "La Liga", level: "UEFA"))
        
        //League 1 (Champions)
        teams.append(Team(name: "PSG", league: "League 1", level: "Champions"))
        teams.append(Team(name: "Nice", league: "League 1", level: "Champions"))
        teams.append(Team(name: "Marsilya", league: "League 1", level: "Champions"))
        
        //League 1  (UEFA)
        teams.append(Team(name: "Lyon", league: "League 1", level: "UEFA"))
        teams.append(Team(name: "Lille", league: "League 1", level: "UEFA"))
        teams.append(Team(name: "Monaco", league: "League 1", level: "UEFA"))
        
        //SerieA (Champions)
        teams.append(Team(name: "Milan", league: "Serie A", level: "Champions"))
        teams.append(Team(name: "Inter", league: "Serie A", level: "Champions"))
        teams.append(Team(name: "Napoli", league: "Serie A", level: "Champions"))
        teams.append(Team(name: "Juventus", league: "Serie A", level: "Champions"))
        
        //SeriA (UEFA)
        teams.append(Team(name: "Lazio", league: "Serie A", level: "UEFA"))
        teams.append(Team(name: "Fiorentina", league: "Serie A", level: "UEFA"))
        teams.append(Team(name: "Roma", league: "Serie A", level: "UEFA"))
        teams.append(Team(name: "Atalanta", league: "Serie A", level: "UEFA"))
        
        //Eredivisie (Champions)
        teams.append(Team(name: "Ajax", league: "Eredivisie", level: "Champions"))
        
        //Eredivisie (UEFA)
        teams.append(Team(name: "PSV", league: "Eredivisie", level: "UEFA"))
        teams.append(Team(name: "Feyenoord", league: "Eredivisie", level: "UEFA"))
        
        //Portugal (Champions)
        teams.append(Team(name: "Porto", league: "Portugal", level: "Champions"))
        teams.append(Team(name: "Sporting Lisbon", league: "Portugal", level: "Champions"))
        
        //Portugal (UEFA)
        teams.append(Team(name: "Benfica", league: "Portugal", level: "UEFA"))
        teams.append(Team(name: "Braga", league: "Portugal", level: "UEFA"))
        teams.append(Team(name: "Gil Vicente", league: "Portugal", level: "UEFA"))
        

        //Save Data
        UserDefaults.standard.set(try? PropertyListEncoder().encode(teams), forKey: "teams")
    }
}
