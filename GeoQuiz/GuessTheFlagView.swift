//
//  GuessTheFlagView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 20/9/22.
//

import SwiftUI

struct GuessTheFlagView: View {
    @StateObject var gameController = CountryGameController()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .main, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(gameController: gameController, color: .mayaBlue)
                        .padding(.bottom)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Question \(gameController.questionCounter) of \(gameController.data.count)")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text("What is the flag of")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("\(gameController.correctAnswer.key)?")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                    }
                    
                    Spacer()
                    VStack(spacing: 30) {
                        ForEach(Array(gameController.userChoices.keys), id: \.self) { countryName in
                            Button {
                                gameController.answer(
                                    choice: (key: countryName, value: gameController.data[countryName]!),
                                    wrongMessage: "That's the flag of \(countryName)"
                                ) {
                                    gameController.selector()
                                }
                            } label: {
                                
                                /*
                                 THE PROBLEM:
                                 SwiftUI caches the image when it's shown using the `Image(string)` API.
                                 Once the image is not showed anymore, SwiftUI doesn't release memory,
                                 so it keeps caching new images until the app crashes
                                 UIImage(contentsOfFile: path) doesn't cache the image
                                 
                                 THE SOLUTION:
                                 Using `UIImage(contentsOfFile: path)` images aren't cached.
                                 */
                                
                                let flag = gameController.data[countryName]!.flag
                                let flagPath = Bundle.main.path(forResource: flag, ofType: "png")!
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white.opacity(0.5))
                                    .frame(width: geo.size.height * 0.3, height: geo.size.height * 0.15)
                                    .overlay(
                                        Image(uiImage: UIImage(contentsOfFile: flagPath)!)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(20)
                                            .shadow(radius: 10)
                                            .padding()
                                    )
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(gameController: gameController, gameType: .guessTheFlag, moc: moc))
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView()
    }
}
