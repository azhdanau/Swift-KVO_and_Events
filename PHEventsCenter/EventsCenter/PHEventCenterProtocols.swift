//
//  File.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 30.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

protocol PHEventsCenterProtocol : class {
    /*
     * Add observer for providede events, if they are supported by observer
     */
    func addObserver(observer: PHObserverProtocol, forEventIdentifiers events: [String])
    /*
     * Add observer for all supported events
     */
    func addObserver(observer: PHObserverProtocol)
    /*
     * Send event for all weakObservers, that are currently waiting for it
     */
    func raiseEvent(event: PHBasicEvent)
    /*
     * Remove observer and stop listening for all events
     */
    func removeObserver(observer: PHObserverProtocol)
    /*
     * Stop listening for provided events
     */
    func removeObserver(observer: PHObserverProtocol, forEvents events: [String])
}

protocol PHEventProtocol : class, Hashable {
    var eventIdentifier: String {get}
}

protocol PHObserverProtocol : class {
    /*
     * Return list of event identifiers, that can be hold by class
     */
    func supportedEventsIdentifiers() -> [String]
    /*
     * Process event
     */
    func processEvent(event: PHBasicEvent)
}