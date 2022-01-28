//
//  Time.swift
//

import Foundation

/// time duration in music (measured in beat)
public typealias MusicDuration = Float64

/// timestamp in music (measured in beat)
public typealias MusicTimeStamp = Float64

/// physical timestamp , measured in seconds since 1970
public typealias PhysicalTimeStamp = TimeInterval

/// physical time duration, measured in seconds
public typealias PhysicalDuration = TimeInterval


/// toString
extension PhysicalTimeStamp {
    public var asPhysicalTimeDscription: String {
        let date = Date(timeIntervalSince1970: self)
        return String(date.description.prefix(19))
    }
}

extension MusicTimeStamp {
    public var asMusicTimeDescription: String {
        return "🎼: " + String(format: "%.3f", self)
    }
}
