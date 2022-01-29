//
//  TempoTests.swift
//

import Foundation

import MusicSymbol
import XCTest

class TempoTests: XCTestCase {
    
    func testDurations() {
        let timeSignature = TimeSignature(beats: 4, noteTimeValue: .quarter) // 4/4
        let tempo = Tempo(timeSignature: timeSignature, bpm: 120) // 120BPM
        
        var noteValue = NoteTimeValue(type: .quarter)
        var duration = tempo.duration(of: noteValue)
        XCTAssertEqual(duration, 0.5)
        XCTAssertEqual(tempo.durationPerBeat, 0.5)
        
        noteValue.modifier = .dotted
        duration = tempo.duration(of: noteValue)
        XCTAssertEqual(duration, 0.75)
        
        noteValue.type = .sixteenth
        noteValue.modifier = .default
        duration = tempo.duration(of: noteValue)
        XCTAssertEqual(duration, 0.125)
        
        noteValue.type = .whole
        duration = tempo.duration(of: noteValue)
        XCTAssertEqual(duration, 2.0)
    }
    
    func testBeats() {
        let timeSignature = TimeSignature(beats: 4, noteTimeValue: .quarter) // 4/4
        let tempo = Tempo(timeSignature: timeSignature, bpm: 120) // 120BPM
        
        let beats = tempo.beats(of: Note(pitch: Pitch("C4")!, timeValue: .init(type: .half)))
        XCTAssertEqual(beats, 2)
    }
    
    func testTempoEqualable() {
        let t1 = Tempo(timeSignature: TimeSignature(beats: 1, noteTimeValue: .whole), bpm: 1)
        var t2 = Tempo(timeSignature: TimeSignature(beats: 2, noteTimeValue: .half), bpm: 2)
        XCTAssertNotEqual(t1.timeSignature.noteTimeValue, t2.timeSignature.noteTimeValue)
        XCTAssertNotEqual(t1.timeSignature, t2.timeSignature)
        
        t2.timeSignature = TimeSignature(beats: 1, noteTimeValue: .whole)
        t2.bpm = 1
        XCTAssertEqual(t1.timeSignature.noteTimeValue, t2.timeSignature.noteTimeValue)
        XCTAssertEqual(t1.timeSignature, t2.timeSignature)
    }
}
