//
//  PlayedGame+CoreDataProperties.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 19/10/22.
//
//

import Foundation
import CoreData


extension PlayedGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayedGame> {
        return NSFetchRequest<PlayedGame>(entityName: "PlayedGame")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: GameType
    @NSManaged public var score: Int32
    @NSManaged public var date: Date
    @NSManaged public var correctAnswers: [String]?
    @NSManaged public var wrongAnswers: [String]?

}

extension PlayedGame : Identifiable {

}
