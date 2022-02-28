//
//  TeamsView.swift
//  Fifa
//
//  Created by Bünyamin Kılıçer on 27.02.2022.
//

import SwiftUI

struct TeamsView: View {
    var team1: Team
    var team2: Team
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Takım 1")
                Spacer()
                Spacer()
                Text("Takım 2")
                Spacer()
            }
            
            
            HStack {
                VStack {
                    Image(team1.name)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    Text(team1.name)
                        .font(.subheadline)
                    
                    Text(team1.league)
                        .font(.footnote)
                }
                .padding()
                
                VStack {
                    Image(team2.name)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    Text(team2.name)
                        .font(.subheadline)
                    
                    Text(team2.league)
                        .font(.footnote)
                }
                .padding()
            }
        }
    }
}


/*
 struct TeamsView_Previews: PreviewProvider {
 static var previews: some View {
 TeamsView()
 }
 }*/
