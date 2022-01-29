//
//  NoteValue.swift
//  MusicTheory iOS
//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation

/// Defines the duration of a note beatwise.
public struct NoteTimeValue: Codable {
    
    /// Type that represents the duration of note.
    public var type: NoteTimeValueType
    
    /// Modifier for `NoteType` that modifies the duration.
    public var modifier: NoteModifier
    
    /// Initilize the NoteValue with its type and optional modifier.
    ///
    /// - Parameters:
    ///   - type: Type of note value that represents note duration.
    ///   - modifier: Modifier of note value. Defaults `default`.
    public init(type: NoteTimeValueType, modifier: NoteModifier = .default) {
        self.type = type
        self.modifier = modifier
    }
    
    /// how many quarter notes this note time value equals
    public var timesOfQuarterNote: Double {
        return self / .quarter
    }
    
    /// how many whole notes this notes time value equals
    public var rawValue: Double {
        return self / .whole
    }
}

// MARK: - NoteTimeValueType
/// Defines the types of note values.
public enum NoteTimeValueType: Double, Codable, CaseIterable, Hashable {
    /// Two whole notes.
    case doubleWhole = 0.5
    /// Whole note.
    case whole = 1
    /// Half note.
    case half = 2
    /// Quarter note.
    case quarter = 4
    /// Eighth note.
    case eighth = 8
    /// Sixteenth note.
    case sixteenth = 16
    /// Thirtysecond note.
    case thirtysecond = 32
    /// Sixtyfourth note.
    case sixtyfourth = 64
}

// MARK: - NoteModifier

/// Defines the length of a `NoteValue`
public enum NoteModifier: Double, Codable, CaseIterable {
    /// No additional length.
    case `default` = 1
    
    /// Adds half of its own value.
    case dotted = 1.5
    
    /// double dotted
    case doubleDotted = 1.25
    
    /// Three notes of the same value.
    case triplet = 0.6667
    
    /// Five of the indicated note value total the duration normally occupied by four.
    case quintuplet = 0.8
}

// MARK: - NoteValue

/// Calculates how many notes of a single `NoteValueType` is equivalent to a given `NoteValue`.
///
/// - Parameters:
///   - noteValue: The note value to be measured.
///   - noteValueType: The note value type to measure the length of the note value.
/// - Returns: Returns how many notes of a single `NoteValueType` is equivalent to a given `NoteValue`.
public func / (noteValue: NoteTimeValue, noteValueType: NoteTimeValueType) -> Double {
    return noteValue.modifier.rawValue * noteValueType.rawValue / noteValue.type.rawValue
}

/// - Parameters:
///   - noteTimeValueType:
///   - times:
/// - Returns:
public func * (noteTimeValueType: NoteTimeValueType, times: Double) -> NoteTimeValue? {
    let rawValue = times / noteTimeValueType.rawValue
    var minDist = 1e10
    var result: NoteTimeValue? = nil
    
    for timeValueType in NoteTimeValueType.allCases {
        for modify in NoteModifier.allCases {
            let candidate = NoteTimeValue(type: timeValueType, modifier: modify)
            if abs(candidate.rawValue - rawValue) < minDist {
                minDist = abs(candidate.rawValue - rawValue)
                result = candidate
            }
        }
    }
    return result
}


// MARK: Extensions

extension NoteTimeValueType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .quarter:
            return "1/4"
        case .half:
            return "1/2"
        case .eighth:
            return "1/8"
        case .doubleWhole:
            return "2"
        case .whole:
            return "1"
        case .sixteenth:
            return "1/16"
        case .thirtysecond:
            return "1/32"
        case .sixtyfourth:
            return "1/64"
        }
    }
}

extension NoteModifier: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return ""
        case .dotted:
            return "."
        case .doubleDotted:
            return ".."
        case .triplet:
            return "(2/3)"
        case .quintuplet:
            return "(4/5)"
        }
    }
}

extension NoteTimeValue: CustomStringConvertible {
    public var description: String {
        return "\(type)\(modifier)"
    }
}

extension NoteTimeValue {
    public init?(_ value: String) {
        for type in NoteTimeValueType.allCases {
            for mod in NoteModifier.allCases {
                let result = "\(type)\(mod)"
                if result == value {
                    self = NoteTimeValue(type: type, modifier: mod)
                    return
                }
            }
        }
        return nil
    }
}

