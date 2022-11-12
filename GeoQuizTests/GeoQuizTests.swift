//
//  GeoQuizTests.swift
//  GeoQuizTests
//
//  Created by Dennis Concepción Martín on 12/11/22.
//

import XCTest
@testable import GeoQuiz

final class GeoQuizTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

final class CountryGameControllerTests: XCTestCase {
    var game: CountryGameController!
    
    @MainActor override func setUpWithError() throws {
        game = CountryGameController()
    }

    @MainActor func testAsk() throws {
        for _ in game.data {
            game.ask()
            XCTAssertEqual(game.userChoices.count, 3)
            XCTAssertEqual(Set(game.userChoices.keys).count, 3)
        }
        
        XCTAssertEqual(game.dataAsked.count, game.data.count)
    }
}

final class CityGameControllerTests: XCTestCase {
    var game: CityGameController!
    
    @MainActor override func setUpWithError() throws {
        game = CityGameController()
    }

    @MainActor func testAsk() throws {
        for _ in game.data {
            game.ask()
            XCTAssertEqual(game.userChoices.count, 3)
            XCTAssertEqual(Set(game.userChoices.keys).count, 3)
        }
        
        XCTAssertEqual(game.dataAsked.count, game.data.count)
    }
}
