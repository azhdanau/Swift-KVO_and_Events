//
//  Kevin.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 30.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

class Kevin : PHObserverProtocol {
    
    //MARK:- PHObserverProtocol
    func supportedEventsIdentifiers() -> [String] {
        return [KevinEvent.eventIdentifier, CommonEvent.eventIdentifier]
    }
    
    func processEvent(event: PHBasicEvent) {
        if let event = event as? KevinEvent {
            print("Kevin got \(event.info)")
        } else if let event = event as? CommonEvent {
            print("Kevin got \(event.info)")
        } else if event is BobEvent {
            fatalError("BobEvent can't appear here, see supportedEventsIdentifiers() method")
        }
    }
    
}