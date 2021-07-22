//
//  WebService.swift
//  WordReminder
//
//  Created by Burak on 6.06.2021.
//

import Foundation
import IBMSwiftSDKCore
import LanguageTranslator
import AuthenticationServices

class WebService{
    
    static let shared = WebService()
    let authenticator = WatsonIAMAuthenticator(apiKey: Keys.apiKey)
    
    func translateWord(word1: String,code1: String, code2:String,completion:@escaping (String?) -> ()){
            let languageTranslator = LanguageTranslator(version: "2018-05-01", authenticator: authenticator)
            languageTranslator.serviceURL = Keys.serviceURL
            
            let modelID = "\(code1)-\(code2)"
            languageTranslator.translate(text: [word1], modelID: modelID) { response, error in
                if  let translation = response?.result {
                  completion(translation.translations[0].translation)
              }
              else{
                completion(error?.localizedDescription ?? "An error occurred")
              }
            }
    }
    


    private init(){}
}
