//
//  Bob.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 30.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

class Bob : PHObserverProtocol {
    
    //MARK:- PHObserverProtocol
    func supportedEventsIdentifiers() -> [String] {
        return [BobEvent.eventIdentifier, CommonEvent.eventIdentifier]
    }
    
    func processEvent(event: PHBasicEvent) {
        if let event = event as? BobEvent {
            print("Bob got \(event.info)")
        } else if let event = event as? CommonEvent {
            print("Bob got \(event.info)")
        } else if event is KevinEvent {
            fatalError("KevinEvent can't appear here, see supportedEventsIdentifiers() method")
        }
    }
    
}
