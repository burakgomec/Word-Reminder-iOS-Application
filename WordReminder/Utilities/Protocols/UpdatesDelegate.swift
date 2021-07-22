//
//  UpdatesDelegate.swift
//  WordReminder
//
//  Created by Burak on 18.07.2021.
//

import Foundation


protocol UpdatesDelegate{ //Delegate Design Pattern
    func didFinishUpdates(finished: Bool)
    func listenedArraySize(cleared: Bool)
}
