//
//  PHObservable.swift
//  PHEventsCenter
//
//  Created by Andrew Zhdanov on 03.12.15.
//  Copyright © 2015 Andrew Zhdanov. All rights reserved.
//

import Foundation

/* Simple wrapper to observe values
 * You can easily add and remove observers if needed
 * The main idea of this class is to replace Obj-C KVO
 * You can add observers, and don't worry about removing them
 * You can add multiple observers for each wrapper
 */
class PHObservable<T> {
    typealias PHObservableCallback = (T, T) -> Void
    private var didChangeCallbackContainers: [PHObserverCallbackContainer<T>] = []
    var value: T {
        didSet {
            cleanObservers()
            for callbackContainer in self.didChangeCallbackContainers {
                callbackContainer.callback(oldValue, value)
            }
        }
    }
    
    //MARK: -Public methods
    init (value: T) {
        self.value = value
    }

    func addObserver(observer: AnyObject, withCallback callback: PHObservableCallback) {
        let container = PHObserverCallbackContainer<T>(observer: observer, callback: callback)
        self.didChangeCallbackContainers.append(container)
    }
    
    func removeObserver(observer: AnyObject) {
        self.didChangeCallbackContainers.cleanWithMatchClosure { (container: PHObserverCallbackContainer<T>) -> Bool in
            return container.observer === observer
        }
    }
    
    //MARK: - Private methods
    private func cleanObservers () {
        self.didChangeCallbackContainers.cleanWithMatchClosure { (container: PHObserverCallbackContainer<T>) -> Bool in
            return container.observer == nil
        }
    }
}

private struct PHObserverCallbackContainer<T> {
    weak var observer: AnyObject?
    var callback: (T, T) -> Void
}


private extension Array {
    
   mutating func cleanWithMatchClosure (matchClosure: (Element) -> Bool) {
        var indexesToRemove = [Int]()
        for (index, callbackContainer) in self.enumerate() {
            if matchClosure(callbackContainer) {
                indexesToRemove.append(index)
            }
        }
        for index in indexesToRemove {
            self.removeAtIndex(index)
        }
    }
}
