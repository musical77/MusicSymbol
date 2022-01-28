//
//  TimeTests.swift
//

import XCTest
import MusicSymbol

class BaseTypesTimeTests: XCTestCase {
    
    func testTimeDescription() {
        let time: PhysicalTimeStamp = Date().timeIntervalSince1970
        print(time.asPhysicalTimeDscription)
        XCTAssertEqual("2020-05-01 10:38:05".count, time.asPhysicalTimeDscription.count)
    }
    
    func testMusicTimeDescription() {
        let time: MusicTimeStamp = 1.0
        print(time.asMusicTimeDescription)
        XCTAssertEqual("🎼: 1.000", time.asMusicTimeDescription)
    }
}


