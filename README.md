This project contains two compact and convenient mechanisms.
1) Implementing KVO via PHObservable class. This class is some kind of wrapper which can be used to get behaviour similar to Obj-C KVO. The main benefit of this class, that you don't need to worry about removing observers.
2) PHEventsCenter class provide extended mechanism of sending events in application similar like NSNotificationCenter do. Each of events in this approach represented with separate class. 
    Each observer should provide list of supported events.

You can find examples of usage in Test.swift file.

Cheers