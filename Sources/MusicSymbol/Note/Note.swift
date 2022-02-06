//
//  Created by Cem Olcay on 21.06.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//
//  https://github.com/cemolcay/MusicTheory
//

import Foundation

/// Note: musical note, composed of pitch and note duration(timeValue)
public struct Note: Codable {
    
    /// - Parameters:
    ///   - pitch:
    ///   - timeValue:
    public init(pitch: Pitch, timeValue: NoteTimeValue) {
        self.pitch = pitch
        self.timeValue = timeValue
    }
    
    /// pitch
    public var pitch: Pitch

    /// note time value
    public var timeValue: NoteTimeValue
    
}

// MARK: equtable
extension Note: Equatable {
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.pitch.rawValue == rhs.pitch.rawValue
            && lhs.timeValue.rawValue == rhs.timeValue.rawValue
    }
    
}

// MARK: toString, fromString

extension Note: CustomStringConvertible {
    public var description: String {
        return "\(pitch) \(timeValue)"
    }
    
    public init?(_ value: String) {
        let segs = value.split(separator: " ")
        if segs.count == 2 {
            let pitch = Pitch.parse(from : String(segs[0]))
            let timeValue = NoteTimeValue(String(segs[1]))

            if pitch != nil && timeValue != nil {
                self.pitch = pitch!
                self.timeValue = timeValue!
                return
            }
        }
        return nil
    }
}

