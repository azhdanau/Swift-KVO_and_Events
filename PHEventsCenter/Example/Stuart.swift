
//
//  Stuart.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 07.12.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

class Stuart {
    
    var someValue: PHObservable<Int>
    var someOptionalValue: PHObservable<Int?>
    
    init(someValue: Int) {
        self.someValue = PHObservable<Int>(value: someValue)
        self.someOptionalValue = PHObservable<Int?>(value: nil)
    }
}