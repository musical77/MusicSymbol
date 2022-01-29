//
//  KeyTests.swift
//

import MusicSymbol
import XCTest

class KeyTests: XCTestCase {
    
    func testKeyType() {
        
        // c d e f g a b
        let d = KeyType.d
        XCTAssert(d.key(at: -2) == .b)
        XCTAssert(d.key(at: -19) == .f)
        XCTAssert(d.key(at: 12) == .b)
        XCTAssert(d.key(at: 0) == .d)
        XCTAssert(d.key(at: 1) == .e)
        XCTAssert(d.key(at: 2) == .f)
        XCTAssert(d.key(at: -3) == .a)
        XCTAssert(d.key(at: -301) == .d)
        
        let f = KeyType.f
        XCTAssert(f.key(at: -3) == .c)
    }
    
    func testKeyEqual() {
        let b = Key(type: .b, accidental: .natural)
        
        // cb = b
        XCTAssert(Key(type: .c, accidental: .flat) == b)
        XCTAssertFalse(Key(type: .c, accidental: .flat) === b)
        
        // c#(23) = c#(11) = c#(-1) = b
        XCTAssert(Key(type: .c, accidental: .sharps(amount: 23)) == b)
        
        // cb(13) = cb(1) = b
        XCTAssert(Key(type: .c, accidental: .flats(amount: 13)) == b)
        
        // cb(25) = cb(1) = b
        XCTAssert(Key(type: .c, accidental: .flats(amount: 25)) == b)
        XCTAssert(Key(type: .c, accidental: .flats(amount: 24)) != b)
        
        // c## = d
        let d: Key = "d"
        XCTAssert(Key(type: .c, accidental: .doubleSharp) == d)
    }
    
    func testKeysInit() {
        let k1: Key = "a##b"
        XCTAssert(k1.accidental == .sharp && k1.type == .a)
        
        let key1: Key = "c"
        let key2: Key = "c#"
        let key3: Key = "cb"
        let key4: Key = "c##"
        let key5: Key = "cbb"
        print(key1, key2, key3, key4, key5)
        
        XCTAssertEqual(key1.type, .c)
        XCTAssertEqual(key2.type, .c)
        XCTAssertEqual(key3.type, .c)
        XCTAssertEqual(key4.type, .c)
        XCTAssertEqual(key5.type, .c)

        XCTAssertEqual(key1.accidental, .natural)
        XCTAssertEqual(key2.accidental, .sharp)
        XCTAssertEqual(key3.accidental, .flat)
        XCTAssertEqual(key4.accidental, .doubleSharp)
        XCTAssertEqual(key5.accidental, .doubleFlat)
    }
}

