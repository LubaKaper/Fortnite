//
//  Unit3_PersonalProject_FortniteTests.swift
//  Unit3-PersonalProject-FortniteTests
//
//  Created by Liubov Kaper  on 1/4/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import XCTest
@testable import Unit3_PersonalProject_Fortnite

class Unit3_PersonalProject_FortniteTests: XCTestCase {
    
    
    func testModel() {
        let json = """
        [{
        "imageUrl": "https://trackercdn.com/legacycdn/fortnite/17AB12781_large.png",
        "manifestId": 12781,
        "name": "Daredevil",
        "rarity": "marvel",
        "storeCategory": "BRSpecialFeatured",
        "vBucks": 0
        },
        {
        "imageUrl": "https://trackercdn.com/legacycdn/fortnite/7F5C982_large.png",
        "manifestId": 982,
        "name": "Ghoul Trooper",
        "rarity": "Quality",
        "storeCategory": "BRSpecialFeatured",
        "vBucks": 1500
        }
        ]
        """.data(using: .utf8)!
        
        let expectedFirstName = "Daredevil"
        //act
        do {
            let names = try JSONDecoder().decode([Item].self, from: json)
            XCTAssertEqual(expectedFirstName, names[0].name)
        } catch {
            XCTFail("decoding error: \(error)")
        }
        
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
