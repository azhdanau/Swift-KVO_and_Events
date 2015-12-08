//
//  PHEventsCenter.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 29.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

/* This class provide opportunity to add and remove event listeners
 * You should create separate class for each kind of event
 * You can also use this class to raise event. All subscribers will get it.
 * All observers must conform to PHObserverProtocol
 */
class PHEventsCenter : PHEventsCenterProtocol {
    static let sharedInstance = PHEventsCenter()
    private init() {}
    
    private var weakObservers: [ObserverContainer] = []
    
    //MARK:- Public
    func raiseEvent(event: PHBasicEvent) {
        for observerContainer in self.weakObservers {
            observerContainer.processEvent(event)
        }
    }
    
    func addObserver(observer: PHObserverProtocol) {
        self.addObserver(observer, forEventIdentifiers: observer.supportedEventsIdentifiers())
    }
    
    func addObserver(observer: PHObserverProtocol, forEventIdentifiers events: [String]) {
        cleanObserversContainers()
        if let container = containerForObserver(observer)?.element {
            container.addEvents(events)
        } else {
            let newContainer = ObserverContainer(observer: observer, events: events)
            self.weakObservers.append(newContainer)
        }
    }
    
    func removeObserver(observer: PHObserverProtocol) {
        if let index = containerForObserver(observer)?.index {
            self.weakObservers.removeAtIndex(index)
        }
        cleanObserversContainers()
    }
    
    func removeObserver(observer: PHObserverProtocol, forEvents events: [String]) {
        if let container = containerForObserver(observer)?.element {
            container.removeEvents(events)
        }
        cleanObserversContainers()
    }
    
    //MARK:- Private
    private func containerForObserver(observer: PHObserverProtocol) -> (element: ObserverContainer, index: Int)? {
        for (index, container) in self.weakObservers.enumerate() {
            if (container.observer === observer) {
                return (container, index)
            }
        }
        return nil
    }
    
    private func cleanObserversContainers() {
        var containerIndexesToRemove: [Int] = []
        
        for (index, container) in self.weakObservers.enumerate() {
            if (container.observer == nil) {
                containerIndexesToRemove.append(index)
            }
        }
        for index in containerIndexesToRemove {
            self.weakObservers.removeAtIndex(index)
        }
    }
    
    //MARK:- ObserverContainer
    private class ObserverContainer {
        weak var observer: PHObserverProtocol?
        var events: Set<String>
        
        init (observer: PHObserverProtocol, events: [String]) {
            self.observer = observer
            self.events = Set(events)
        }
        
        func addEvents(events: [String]) {
            if let observer = observer {
                let supportedIdentifiers = observer.supportedEventsIdentifiers()
                for event in events where supportedIdentifiers.contains(event) {
                    self.events.insert(event)
                }
            }
        }
        
        func removeEvents(events: [String]) {
            for event in events {
                self.events.remove(event)
            }
        }
        
        func processEvent(event: PHBasicEvent) {
            if let observer = self.observer where self.events.contains(event.eventIdentifier) {
                observer.processEvent(event)
            }
        }
    }
    
}

