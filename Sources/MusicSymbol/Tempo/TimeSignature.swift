
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
public struct TimeSignature: Codable, Equatable {
    
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
    
        
    /// Compares two Tempo instances and returns if they are identical.
    /// - Parameters:
    ///   - lhs: Left hand side of the equation.
    ///   - rhs: Right hand side of the equation.
    /// - Returns: Returns true if two instances are identical.
    public static func == (lhs: TimeSignature, rhs: TimeSignature) -> Bool {
        return lhs.beats == rhs.beats && lhs.noteTimeValue == rhs.noteTimeValue
    }
}


/// to string from string
extension TimeSignature: ExpressibleByStringLiteral, CustomStringConvertible {
    
    public static func parse(from value: String) -> TimeSignature? {
        let args = value.split(separator: "/")
        if args.count == 2 {
            if let beats = Int(args[0]) {
                if let division = Int(args[1]) {
                    if let ts = TimeSignature(beats: beats, division: division) {
                        return ts
                    }
                }
            }
        }
        return nil
    }
    
    /// Initilizes with a string. For the convenience of use, it is assumed that the string must be valid,
    /// if invalid, the default value will be used (4/4)
    ///
    /// - Parameter value: String representation of type.
    public init(stringLiteral value: String) {
        if let ts = TimeSignature.parse(from: value) {
            self = ts
        } else {
            self = TimeSignature(beats: 4, noteTimeValue: .quarter)
        }
    }
    
    public var description: String {
        return "\(beats)/\(Int(noteTimeValue.rawValue))"
    }
}
