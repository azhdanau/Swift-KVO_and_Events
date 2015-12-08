//
//  Events.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 29.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

/* You should enherit your events from this class
 * Event identifier will have value of class name by default
 */
class PHBasicEvent : PHEventProtocol {
    /*
     * This variable is used for implementing Hashable protocol
     */
    var eventIdentifier: String {
        return  self.dynamicType.eventIdentifier
    }
    /*
     * Can be used other classes to return array of supported event identifiers
     */
    static var eventIdentifier: String {
        return String(self).componentsSeparatedByString(".").last!
    }
    /*
     * Hashable protocol implementation
     */
    var hashValue: Int {
        return self.eventIdentifier.hashValue
    }
}

/*
 * Equatable protocol implementation
 */
func ==(lhs: PHBasicEvent, rhs: PHBasicEvent) -> Bool {
    return lhs.eventIdentifier == rhs.eventIdentifier
}
