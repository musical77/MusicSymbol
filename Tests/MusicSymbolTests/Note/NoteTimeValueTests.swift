//
//  NoteValueTests.swift
//

import Foundation
import XCTest
import MusicSymbol

class NoteTimeValueTests: XCTestCase {
    
    func testNoteValueConversions() {
        // 0.5 * 1.5 = 0.75
        let noteValue = NoteTimeValue(type: .half, modifier: .dotted)
        
        // 12/16 = 3/4 = 0.75
        XCTAssertEqual(noteValue / NoteTimeValueType.sixteenth, 12)
        XCTAssertEqual(noteValue / NoteTimeValueType.whole, 0.75)
        
        // 0.5 * 1.25 = 0.625 1/2 * 5/4 = 5/8
        let noteValue2 = NoteTimeValue(type: .half, modifier: .doubleDotted)
        
        XCTAssertEqual(noteValue2 / NoteTimeValueType.sixteenth, 10)
        XCTAssertEqual(noteValue2 / NoteTimeValueType.whole, 0.625)
        
        XCTAssertEqual(noteValue2.timesOfQuarterNote, 2.5)
    }
    
    func testNoteValueString() {
        let noteValue1 = NoteTimeValue("1/32(2/3)")
        XCTAssertEqual(noteValue1?.type, .thirtysecond)
        XCTAssertEqual(noteValue1?.modifier, .triplet)
        
        let noteValue2 = NoteTimeValue("1/4.")
        XCTAssertEqual(noteValue2?.type, .quarter)
        XCTAssertEqual(noteValue2?.modifier, .dotted)

        let noteValueNil = NoteTimeValue("2...")
        XCTAssertNil(noteValueNil)
    }
    
    func testNoteTimeValueTimes() {
        let base = NoteTimeValueType.quarter
        
        let note1 = base * 1
        XCTAssertEqual(note1?.description, "1/4")
        
        let note2 = base * 2
        XCTAssertEqual(note2?.description, "1/2")

        let note3 = base * 1.5
        XCTAssertEqual(note3?.description, "1/4.")
        
        let note4 = base * 5
        XCTAssertEqual(note4?.description, "1..")
        
        let note5 = base * 6
        XCTAssertEqual(note5?.description, "1.")
        
        let note6 = base * 1.97
        XCTAssertEqual(note6?.description, "1/2")
    }
    
    func testSampleLengthCalcuation() {
      let rates = [
          NoteTimeValue(type: .whole, modifier: .default),
          NoteTimeValue(type: .half, modifier: .default),
          NoteTimeValue(type: .half, modifier: .dotted),
          NoteTimeValue(type: .half, modifier: .triplet),
          NoteTimeValue(type: .quarter, modifier: .default),
          NoteTimeValue(type: .quarter, modifier: .dotted),
          NoteTimeValue(type: .quarter, modifier: .triplet),
          NoteTimeValue(type: .eighth, modifier: .default),
          NoteTimeValue(type: .eighth, modifier: .dotted),
          NoteTimeValue(type: .sixteenth, modifier: .default),
          NoteTimeValue(type: .sixteenth, modifier: .dotted),
          NoteTimeValue(type: .thirtysecond, modifier: .default),
          NoteTimeValue(type: .sixtyfourth, modifier: .default),
      ]

      let tempo = Tempo()
      let sampleLengths = rates
        .map({ tempo.sampleLength(of: $0) })
        .map({ round(100 * $0) / 100 })

      let expected: [Double] = [
        88200.0,
        44100.0,
        66150.0,
        29401.47,
        22050.0,
        33075.0,
        14700.73,
        11025.0,
        16537.5,
        5512.5,
        8268.75,
        2756.25,
        1378.13,
      ]

      XCTAssertEqual(sampleLengths, expected)
    }
}
