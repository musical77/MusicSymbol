//
//  Pitch.swift
//  MusicTheory
//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation

/// Pitch object with a `Key` and an octave.
/// Could be initilized with MIDI note number and preferred accidental type.
public struct Pitch: RawRepresentable, Codable, Equatable,
                     Comparable, CustomStringConvertible {
    
    /// Key of the pitch like C, D, A, B with accidentals.
    public var key: Key
    
    /// Octave of the pitch.
    /// In theory this must be zero or a positive integer.
    /// But `Note` does not limit octave and calculates every possible octave including the negative ones.
    public var octave: Int
    
    /// Calculates and returns the frequency of note on octave based on its location of piano keys.
    /// Bases A4 note of 440Hz frequency standard.
    public var frequency: Float {
        let fn = powf(2.0, Float(rawValue - 69) / 12.0)
        return fn * 440.0
    }
    
    // MARK: RawRepresentable
    
    public typealias RawValue = Int
    
    /// Returns midi note number.
    /// In theory, this must be in range [0 - 127].
    /// But it does not limits the midi note value.
    /// middle C is C4 is 60
    public var rawValue: Int {
        let semitones = key.type.rawValue + key.accidental.rawValue
        return semitones + ((octave + 1) * 12)
    }
    
    /// This function returns the nearest pitch to the given frequency in Hz.
    ///
    /// - Parameter frequency: The frequency in Hz
    /// - Returns: The nearest pitch for given frequency
    public static func nearest(frequency: Float) -> Pitch? {
        let allPitches = Array((1 ... 7).map { octave -> [Pitch] in
            Key.keysWithSharps.map { key -> Pitch in
                Pitch(key: key, octave: octave)
            }
        }.joined())
        
        var results = allPitches.map { pitch -> (pitch: Pitch, distance: Float) in
            (pitch: pitch, distance: abs(pitch.frequency - frequency))
        }
        
        results.sort { $0.distance < $1.distance }
        return results.first?.pitch
    }
    
    /// Initilizes the `Pitch` with MIDI note number.
    ///
    /// - Parameter midiNote: Midi note in range of [0 - 127].
    /// - Parameter preferSharps: Make it true if preferred accidentals is sharps. Defaults true.
    public init(midiNote: Int, preferSharps: Bool = true) {
        octave = (midiNote / 12) - 1
        let keyIndex = midiNote % 12
        key = (preferSharps ? Key.keysWithSharps : Key.keysWithFlats)[keyIndex]
    }
    
    /// Initilizes the `Pitch` with `Key` and octave
    ///
    /// - Parameters:
    ///   - key: Key of the pitch.
    ///   - octave: Octave of the pitch.
    public init(key: Key, octave: Int) {
        self.key = key
        self.octave = octave
    }
    
    /// Initilizes the pitch with an integer value that represents the MIDI note number of the pitch.
    ///
    /// - Parameter rawValue: MIDI note number of the pitch.
    public init(rawValue: Pitch.RawValue) {
        self = Pitch(midiNote: rawValue)
    }
    
    /// sugars
    public static var C4 : Pitch { return Pitch("C4") }
}


/// ExpressibleByIntegerLiteral
extension Pitch: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = Int
    
    /// Initilizes the pitch with an integer value that represents the MIDI note number of the pitch.
    ///
    /// - Parameter value: MIDI note number of the pitch.
    public init(integerLiteral value: Pitch.IntegerLiteralType) {
        self = Pitch(midiNote: value)
    }
    
}

extension Pitch: ExpressibleByStringLiteral {
    
    public static func parse(from value: String) -> Pitch? {
        var keyType = KeyType.c
        var accidental = Accidental.natural
        var octave = 0
        let pattern = "([A-Ga-g])([#♯♭b]*)(-?)(\\d+)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        if let regex = regex,
           let match = regex.firstMatch(in: value, options: [], range: NSRange(0 ..< value.count)),
           let keyTypeRange = Range(match.range(at: 1), in: value),
           let accidentalRange = Range(match.range(at: 2), in: value),
           let signRange = Range(match.range(at: 3), in: value),
           let octaveRange = Range(match.range(at: 4), in: value),
           match.numberOfRanges == 5 {
            // key type
            keyType = KeyType(stringLiteral: String(value[keyTypeRange]))
            // accidental
            accidental = Accidental(stringLiteral: String(value[accidentalRange]))
            // sign
            let sign = String(value[signRange])
            // octave
            octave = (Int(String(value[octaveRange])) ?? 0) * (sign == "-" ? -1 : 1)
            
            return Pitch(key: Key(type: keyType, accidental: accidental), octave: octave)
        } else {
            return nil
        }
    }
    
    /// Initilizes with a string. For the convenience of use, it is assumed that the string must be valid,
    /// if invalid, the default value will be used (C4)
    ///
    /// - Parameter value: String representation of type.
    public init(stringLiteral value: String) {
        if let pitch = Pitch.parse(from: value) {
            self = pitch
        } else {
            self = Pitch.C4
        }
    }
    
    // MARK: CustomStringConvertible
    
    /// Converts `Pitch` to string with its key and octave.
    public var description: String {
        return "\(key)\(octave)"
    }
}

/// Calculates the `Pitch` above halfsteps.
///
/// - Parameters:
///   - note: The pitch that is being added halfsteps.
///   - halfstep: Halfsteps above.
/// - Returns: Returns `Pitch` above halfsteps.
public func + (pitch: Pitch, halfstep: Int) -> Pitch {
    return Pitch(midiNote: pitch.rawValue + halfstep)
}

/// Calculates the `Pitch` below halfsteps.
///
/// - Parameters:
///   - note: The pitch that is being calculated.
///   - halfstep: Halfsteps below.
/// - Returns: Returns `Pitch` below halfsteps.
public func - (pitch: Pitch, halfstep: Int) -> Pitch {
    return Pitch(midiNote: pitch.rawValue - halfstep)
}

/// Compares the equality of two pitches by their MIDI note value.
/// Alternative notes passes this equality. Use `===` function if you want to check exact equality in terms of exact keys.
///
/// - Parameters:
///   - left: Left handside `Pitch` to be compared.
///   - right: Right handside `Pitch` to be compared.
/// - Returns: Returns the bool value of comparisation of two pitches.
public func == (left: Pitch, right: Pitch) -> Bool {
    return left.rawValue == right.rawValue
}

/// Compares the exact equality of two pitches by their keys and octaves.
/// Alternative notes not passes this equality. Use `==` function if you want to check equality in terms of MIDI note value.
///
/// - Parameters:
///   - left: Left handside `Pitch` to be compared.
///   - right: Right handside `Pitch` to be compared.
/// - Returns: Returns the bool value of comparisation of two pitches.
public func === (left: Pitch, right: Pitch) -> Bool {
    return left.key == right.key && left.octave == right.octave
}

/// Compares two `Pitch`es in terms of their semitones.
///
/// - Parameters:
///   - lhs: Left hand side of the equation.
///   - rhs: Right hand side of the equation.
/// - Returns: Returns true if left hand side `Pitch` lower than right hand side `Pitch`.
public func < (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func <= (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

public func > (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

public func >= (lhs: Pitch, rhs: Pitch) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

/// hashable
extension Pitch: Hashable {
    public var hashValue: Int {
        return self.rawValue
    }
}
