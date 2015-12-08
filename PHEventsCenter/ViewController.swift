//
//  ViewController.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 29.11.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var eventsCenter : PHEventsCenterProtocol = PHEventsCenter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTest()
        
        observingTest()
    }
    
    //MARK: - PHEvents test
    func eventsTest () {
        var test: Test? = Test()
        test!.testExample()
        test = nil
        print("Nothing should happens after this line, however we try to send events")
        testSending()
    }
    
    //MARK: -PHObservable test
    func observingTest() {
        let test = Test()
        test.observingTest()
    }
    
    func testSending() {
        let bobEvent = BobEvent(infoForBob: "aaa")
        let kevinEvent = KevinEvent(infoForKevin: "bbb")
        let commonEvent = CommonEvent(info: "ccc")
        
        eventsCenter.raiseEvent(bobEvent)
        eventsCenter.raiseEvent(kevinEvent)
        eventsCenter.raiseEvent(commonEvent)
    }

}


