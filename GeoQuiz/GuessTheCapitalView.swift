//
//  GuessTheCapitalView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 14/9/22.
//

import SwiftUI

struct GuessTheCapitalView: View {
    @StateObject var gameController = CountryGameController()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .secondary, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    GameToolbar(gameController: gameController, color: .atomicTangerine)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    /*
                     THE PROBLEM:
                     SwiftUI caches the image when it's shown using the `Image(string)` API.
                     Once the image is not showed anymore, SwiftUI doesn't release memory,
                     so it keeps caching new images until the app crashes
                     UIImage(contentsOfFile: path) doesn't cache the image
                     
                     THE SOLUTION:
                     Using `UIImage(contentsOfFile: path)` images aren't cached.
                     */
                    
                    let flag = gameController.correctAnswer.value.flag
                    let flagPath = Bundle.main.path(forResource: flag, ofType: "png")!
                    Image(uiImage: UIImage(contentsOfFile: flagPath)!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .frame(height: geo.size.height * 0.15)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Question \(gameController.questionCounter) of \(gameController.data.count)")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("What is the capital of \(gameController.correctAnswer.key)?")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 15) {
                            ForEach(Array(gameController.userChoices.keys), id: \.self) { countryName in
                                Button {
                                    gameController.answer(
                                        choice: (key: countryName, value: gameController.data[countryName]!),
                                        wrongMessage: "That's the capital of \(countryName)"
                                    ) {
                                        gameController.selector()
                                    }
                                } label: {
                                    AnswerButton(
                                        name: gameController.data[countryName]!.capital,
                                        color: .chinaPink
                                    )
                                    .frame(height: geo.size.height * 0.08)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: 500)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .modifier(GameAlertsModifier(gameController: gameController, gameType: .guessTheCapital, moc: moc))
    }
}

struct GuessTheCapitalView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheCapitalView()
    }
}
