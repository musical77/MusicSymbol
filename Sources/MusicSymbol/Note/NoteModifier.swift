//  NoteModifier.swift

import Foundation

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
