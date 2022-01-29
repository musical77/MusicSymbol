//
//  NoteTest.swift
//

import Foundation
import XCTest
import MusicSymbol

class NoteTests: XCTestCase {
    
    func testNoteInitAndDesc() {
        let note1 = Note(pitch: Pitch("C3")!, timeValue: NoteTimeValue("1/2")!)
        XCTAssertEqual("C3 1/2", note1.description)
        
        let note2 = Note(pitch: Pitch("C#4")!, timeValue: NoteTimeValue("1/4.")!)
        print(note2)
        XCTAssertEqual(note2.pitch.rawValue, 61)
    }
    
    func testNoteFromString() {
        let note = Note("C4 1/2.")!
        XCTAssertEqual(note.pitch, Pitch("C4")!)
        XCTAssertEqual(note.timeValue.modifier, .dotted)
        XCTAssertEqual(note.timeValue.rawValue, 0.75)
    }
}

