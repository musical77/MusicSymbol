//  KeySignature.swift
//
//  Created by lively77 on 2022/2/8.

import Foundation

/// any of several combinations of sharps or flats after the clef at the beginning of each stave, indicating the key of a composition.
public struct KeySignature {
    public init(accidental: Accidental = .natural, type: KeySignatureType = .major) {
        self.accidental = accidental
        self.type = type
    }
    
    public var accidental: Accidental = .natural
    
    public var type: KeySignatureType = .major
}

public enum KeySignatureType: String {
    case major = "Major"
    case minor = "minor"
}
