//  NoteTimeValueType.swift
//  Created by lively77 on 2022/2/6.

//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation


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
