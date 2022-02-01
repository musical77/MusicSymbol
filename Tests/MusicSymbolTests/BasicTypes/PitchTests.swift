//
//  PitchTests.swift
//

import Foundation
import XCTest
import MusicSymbol

class PitchTests: XCTestCase {
    
    func testPitchMidiNote() {
        
        // C0 = 12, C1 = 24, C2 = 36, C4 = 48, C5 = 60
        let c0: Pitch = 12
        XCTAssert(c0.octave == 0 && c0.key.accidental == .natural && c0.key.type == .c)
        XCTAssert(c0 - 12 == 0)
        
        let c4: Pitch = 60
        XCTAssertEqual(c4.key.type, KeyType.c)
        XCTAssertEqual(c4.octave, 4)
        
        var pitch = Pitch(midiNote: 127)
        XCTAssert(pitch.key == Key(type: .g))
        pitch = Pitch(midiNote: 0)
        XCTAssert(pitch.key == Key(type: .c))
        pitch = Pitch(midiNote: 66, preferSharps: false)
        XCTAssert(pitch.key == Key(type: .g, accidental: .flat))
        
    }
    
    func testPitchInit() {
        let p: Pitch = "f#-5"
        XCTAssert(p.key === Key(type: .f, accidental: .sharp))
        XCTAssert(p.octave == -5)
        
        let uppercasePitch: Pitch = "A#3"
        XCTAssert(uppercasePitch.key === Key(type: .a, accidental: .sharp))
        XCTAssert(uppercasePitch.octave == 3)
        
        let uppercasePitch2: Pitch = "F4"
        XCTAssert(uppercasePitch2.key === Key(type: .f, accidental: .natural))
        XCTAssert(uppercasePitch2.octave == 4)
    }
    
    func testFrequency() {
        let note = Pitch(key: Key(type: .a), octave: 4)
        XCTAssertEqual(note.frequency, 440.0)
        
        let a4 = Pitch.nearest(frequency: 440.0)
        XCTAssertEqual(note, a4)
    }
    
    func testPitchRange() {
        let pitch: Pitch = "C4"
        
        XCTAssertGreaterThan(pitch, Pitch("B3"))
        XCTAssertGreaterThanOrEqual(pitch, Pitch("C4"))

        XCTAssertLessThan(pitch, Pitch("C#4"))
        
        XCTAssertTrue(pitch >= Pitch("B#3"))
    }
}

