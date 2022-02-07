//
//  AccidentalTests.swift
//

import Foundation
import XCTest
import MusicSymbol

class AccidentalTests: XCTestCase {
    
    func testAccidentals() {
      XCTAssert(Accidental.sharps(amount: 2) - 2 == Accidental.natural)
      XCTAssert(Accidental.flats(amount: 2) + 2 == 0)
    }
}

