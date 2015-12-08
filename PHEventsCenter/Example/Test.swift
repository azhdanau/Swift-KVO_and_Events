//
//  Test.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 30.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

class Test {
    
    //MARK:- Events
    let bob  = Bob()
    let kevin = Kevin()
    var eventsCenter: PHEventsCenterProtocol = PHEventsCenter.sharedInstance
    
    func testExample () {
        print("Sending 1")
        //Sending 1
        self.eventsCenter.addObserver(bob)
        self.eventsCenter.addObserver(kevin)
        testSending()
        
        print("Sending 2")
        // Sending 2, Some extra subscription just for test, should change nothing
        self.eventsCenter.addObserver(bob, forEventIdentifiers: [BobEvent.eventIdentifier, CommonEvent.eventIdentifier,KevinEvent.eventIdentifier])
        self.eventsCenter.addObserver(kevin, forEventIdentifiers: [BobEvent.eventIdentifier, CommonEvent.eventIdentifier,KevinEvent.eventIdentifier])
        testSending()
        
        print("Sending 3")
        //Sending 3, remove some of events
        self.eventsCenter.removeObserver(kevin, forEvents: [CommonEvent.eventIdentifier])
        testSending()
        
        print("Sending 4")
        //Sending 3, remove some of events
        self.eventsCenter.removeObserver(kevin)
        self.eventsCenter.removeObserver(bob, forEvents: [BobEvent.eventIdentifier])
        testSending()
    }
    
    func testSending() {
        let bobEvent = BobEvent(infoForBob: "aaa")
        let kevinEvent = KevinEvent(infoForKevin: "bbb")
        let commonEvent = CommonEvent(info: "ccc")
        
        eventsCenter.raiseEvent(bobEvent)
        eventsCenter.raiseEvent(kevinEvent)
        eventsCenter.raiseEvent(commonEvent)
    }
    
    //MARK: -Observing
    func observingTest() {
        //Self can observe stuart
        var stuart: Stuart? = Stuart(someValue: 1);
        let oneMoreStuart = Stuart(someValue: 1);
        
        stuart?.someValue.addObserver(self) { (oldValue, newValue) in
            print("Old value was \(oldValue) new value is \(newValue)");
        }
        stuart?.someOptionalValue.addObserver(self) {(oldValue, newValue) in
            print("Optional Old value was \(oldValue) new value is \(newValue)");
        }
        oneMoreStuart.someValue.addObserver(self) {(oldValue, newValue) -> Void in
            print("Stuart 2 : Old value was \(oldValue) new value is \(newValue)");
        }
        oneMoreStuart.someOptionalValue.addObserver(self) {(oldValue, newValue) -> Void in
            print("Stuart 2 : Old optional value was \(oldValue) new value is \(newValue)");
        }
        
        stuart?.someValue.value = 2
        stuart?.someOptionalValue.value = 2
        stuart?.someOptionalValue.value = nil
        
        
        stuart?.someValue.removeObserver(self)
        stuart?.someValue.value = 3 // will not invoke the block, because observer was removed
        stuart?.someOptionalValue.value = 3 // will invoke the block
        
        stuart = nil;
        
        oneMoreStuart.someValue.value = 2
        oneMoreStuart.someOptionalValue.value = 2
        
        //Optional Bob can observe stuart
        var bob: Bob? = Bob()
        if let bob = bob {
            oneMoreStuart.someValue.addObserver(bob) { (oldValue, newValue) in
                print("Bob still observe stuart")
            }
        }
        oneMoreStuart.someValue.value = 3 // will cause print line
        bob = nil
        oneMoreStuart.someValue.value = 4 // bob is nil, so will not call print
    }
    
}