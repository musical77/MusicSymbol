//
//  TimeSignature.swift
//  MusicTheory iOS
//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation

/// Defines how many beats in a measure with which note value.
public struct TimeSignature: Codable, Equatable, CustomStringConvertible {
    
    /// Note value per beat.
    public var noteTimeValue: NoteTimeValueType
    
    /// Beats per measure.
    public var beats: Int
    
    
    /// Initilizes the time signature with beats per measure and the value of the notes in beat.
    ///
    /// - Parameters:
    ///   - beats: Number of beats in a measure
    ///   - noteTimeValue: Note value of the beats.
    public init(beats: Int = 4, noteTimeValue: NoteTimeValueType = .quarter) {
        self.beats = beats
        self.noteTimeValue = noteTimeValue
    }
    
    /// Initilizes the time signature with beats per measure and the value of the notes in beat. Returns nil if a division is not match a `NoteValue`.
    ///
    /// - Parameters:
    ///   - beats: Number of beats in a measure
    ///   - division: Number of the beats.
    public init?(beats: Int, division: Int) {
        guard let noteTimeValue = NoteTimeValueType(rawValue: Double(division)) else {
            return nil
        }
        
        self.beats = beats
        self.noteTimeValue = noteTimeValue
    }
    
    // MARK: CustomStringConvertible
    
    public var description: String {
        return "\(beats)/\(Int(noteTimeValue.rawValue))"
    }
    
    
    /// Compares two Tempo instances and returns if they are identical.
    /// - Parameters:
    ///   - lhs: Left hand side of the equation.
    ///   - rhs: Right hand side of the equation.
    /// - Returns: Returns true if two instances are identical.
    public static func == (lhs: TimeSignature, rhs: TimeSignature) -> Bool {
        return lhs.beats == rhs.beats && lhs.noteTimeValue == rhs.noteTimeValue
    }
}

