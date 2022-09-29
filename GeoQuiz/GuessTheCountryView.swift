//
//  GuessTheCountryView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 24/9/22.
//

import SwiftUI
import MapKit

struct GuessTheCountryView: View {
    @Binding var gameName: GameName?
    @StateObject var game = CityGame()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .tertiary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(spacing: 20) {
                    GameToolbar(game: game, color: .pinkLavender)
                    
                    Spacer()
                    
                    CityMap(region: MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: game.correctAnswer.value.lat,
                            longitude: game.correctAnswer.value.lon
                        ),
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    )
                    .frame(height: geo.size.height * 0.3)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(game.questionCounter) of \(game.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("In what country is \(game.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(Array(game.userChoices.keys), id: \.self) { cityName in
                            Button {
                                game.answer((key: cityName, value: game.data[cityName]!))
                            } label: {
                                AnswerButton(
                                    optionName: game.data[cityName]!.country,
                                    color: .blueBell
                                )
                                .frame(height: geo.size.height * 0.08)
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(game: game, gameName: $gameName))
        .sheet(isPresented: $game.showingBuyLivesView) {
            BuyLivesModalView()
        }
        
        .sheet(isPresented: $game.showingGameStatsView) {
//            GameStatsModalView(game: game)
        }
    }
}

struct GuessTheCountryView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCountryView(gameName: .constant(GameName.guessTheCountry))
    }
}
