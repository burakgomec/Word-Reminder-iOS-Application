//
//  WordDelegate.swift
//  WordReminder
//
//  Created by Burak on 3.07.2021.
//

import Foundation


protocol LanguageDelegate{ //Delegate Design Pattern
    func wordReady(language:String,languageNumber: Int)
}
