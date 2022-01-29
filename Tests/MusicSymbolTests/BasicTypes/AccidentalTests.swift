//
//  AccidentalTests.swift
//

import Foundation
import XCTest
import MusicSymbol

class AccidentalTests: XCTestCase {
    
    func testAccidentals() {
      XCTAssert(Accidental.flat * 2 == Accidental.doubleFlat)
      XCTAssert(Accidental.doubleFlat / 2 == Accidental.flat)
      XCTAssert(Accidental.sharps(amount: 2) - 2 == Accidental.natural)
      XCTAssert(Accidental.flats(amount: 2) + 2 == 0)
      XCTAssert(Accidental.sharps(amount: 2) + Accidental.sharps(amount: 1) == Accidental.sharps(amount: 3))
      XCTAssert(Accidental(integerLiteral: -3) + Accidental(rawValue: 3)! == 0)
    }
}

