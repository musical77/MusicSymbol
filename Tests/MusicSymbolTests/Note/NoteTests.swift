//
//  NoteTest.swift
//

import Foundation
import XCTest
import MusicSymbol

class NoteTests: XCTestCase {
    
    func testNoteInitAndDesc() {
        let note1 = Note(pitch: "C3", timeValue: NoteTimeValue("1/2")!)
        XCTAssertEqual("C3 1/2", note1.description)
        
        let note2 = Note(pitch: "C#4", timeValue: NoteTimeValue("1/4.")!)
        print(note2)
        XCTAssertEqual(note2.pitch.rawValue, 61)
    }
    
    func testNoteFromString() {
        let note = Note("C4 1/2.")!
        XCTAssertEqual(note.pitch, Pitch("C4"))
        XCTAssertEqual(note.timeValue.modifier, .dotted)
        XCTAssertEqual(note.timeValue.rawValue, 0.75)
    }
    
    func testNoteEqutable() {
        let note1 = Note("C4 1/2")!
        let note2 = Note(pitch: .C4, timeValue: .init(type: .half, modifier: .default))
        XCTAssertEqual(note1, note2)
        
        let note3 = Note("C5 1/4")!
        XCTAssertNotEqual(note1, note3)
    }
}

