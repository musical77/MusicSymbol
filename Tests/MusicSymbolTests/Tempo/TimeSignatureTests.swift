//
//  TimeSignatureTests.swift
//

import Foundation

import MusicSymbol
import XCTest

class TimeSignatureTests: XCTestCase {
    
    func testSignature() {
        let timeSignature1 = TimeSignature(beats: 4, noteTimeValue: .eighth)
        let timeSignature2: TimeSignature = "4/8"
        
        XCTAssertEqual(timeSignature1, timeSignature2)
    }
 
}

