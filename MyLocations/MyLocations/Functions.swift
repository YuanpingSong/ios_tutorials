//
//  Functions.swift
//  MyLocations
//
//  Created by imac on 2017/7/9.
//  Copyright © 2017年 songyp. All rights reserved.
//

import Foundation
import Dispatch

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()

let MyManagedObjectContextSavedDidFailNotification = Notification.Name(rawValue: "MyManagedObjectContextSaveDidFailNotification")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name:MyManagedObjectContextSavedDidFailNotification, object: nil)
}

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) { // @escaping label is neccessary for closures that are not executed immediately
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}

