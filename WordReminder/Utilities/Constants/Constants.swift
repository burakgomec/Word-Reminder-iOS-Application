//
//  Constants.swift
//  WordReminder
//
//  Created by Burak on 7.06.2021.
//

import Foundation


class Constants  {
    
    
    static var delegate : UpdatesDelegate?
   
    static let languages : [String] = ["English".localizeString(),"Turkish".localizeString(),"German".localizeString(),"French".localizeString(),"French-Canada".localizeString(),"Hindi".localizeString(),"Hebrew".localizeString(),"Portuguese".localizeString(),"Traditional Chinese".localizeString(),"Croatian".localizeString(),"Hungarian".localizeString(),"Montenegrin".localizeString(),"Indonesian".localizeString(),"Italian".localizeString(),"Simplified Chinese".localizeString(),"Japanese".localizeString(),"Dutch".localizeString(),"Finnish".localizeString(),"Irish".localizeString(),"Gujarati".localizeString(),"Polish".localizeString(),"Danish".localizeString(),"Lithuanian".localizeString(),"Latvian".localizeString(),"Ukrainian".localizeString(),"Urdu".localizeString(),"Malayalam".localizeString(),"Malay".localizeString(),
                                       "Maltese".localizeString(),"Greek".localizeString(),"Spanish".localizeString(),"Estonian".localizeString(),"Norwegian".localizeString(),"Vietnamese".localizeString(),"Nepali".localizeString(),"Romanian".localizeString(),"Russian".localizeString(),"Bulgarian".localizeString(),"Bengali".localizeString(),"Bosnian".localizeString(),"Slovakian".localizeString(),"Slovenian".localizeString(),"Serbian".localizeString(),
                                       "Korean".localizeString(),"Swedish".localizeString(),"Tamil".localizeString(),"Czech".localizeString(),"Telugu".localizeString(),"Thai".localizeString(),"Welsh".localizeString(),"Catalan".localizeString(),"Basque".localizeString()]
    
    //Ibm translation language models
    static let modelDictionary = ["en":"tr,de,fr,fr-CA,it,pt,zh-TW,hr,hu,cnr,id,zh,ja,nl,fi,ga,gu,pl,da,lt,lv,uk,ur,ml,ms,mt,el,es,et,nb,vi,ne,ro,ru,bg,bn,bs,sk,sl,sr,ko,sv,ta,cs,te,th,he,hi,cy"
                                  ,"he":"en",
                                  "hi":"en",
                                  "pt":"en",
                                  "zh-TW":"en"
                                  ,"hr":"en",
                                  "hu":"en",
                                  "cnr":"en",
                                  "id":"en",
                                  "zh":"en",
                                  "ja":"en",
                                  "nl":"en",
                                  "fi":"en",
                                  "ga":"en",
                                  "gu":"en",
                                  "pl":"en",
                                  "tr":"en",
                                  "da":"en",
                                  "lt":"en",
                                  "lv":"en",
                                  "uk":"en",
                                  "ms":"en",
                                  "fr-CA":"en",
                                  "ur":"en",
                                  "ml":"en",
                                  "mt":"en",
                                  "el":"en",
                                  "et":"en",
                                  "nb":"en",
                                  "vi":"en",
                                  "ne":"en",
                                  "ro":"en",
                                  "ru":"en","bg":"en","bn":"en","bs":"en","sk":"en","sl":"en","sr":"en","ko":"en","sv":"en","ta":"en","cs":"en","te":"en","th":"en",
                                  "cy":"en","ca":"es","eu":"es","de":"fr,it,en","es":"fr,eu,en,ca","it":"en,de","fr":"en,de,es"]


    static let languagesDictionary : [String : String] = ["English".localizeString():"en","Turkish".localizeString():"tr","German".localizeString():"de" ,"French".localizeString():"fr","French-Canada".localizeString():"fr-CA"
                                                          ,"Hindi".localizeString():"hi",
                                                          "Hebrew".localizeString():"he"
                                                          ,"Portuguese".localizeString():"pt" ,
                                                          "Traditional Chinese".localizeString():"zh-TW"
                                                          ,"Croatian".localizeString():"hr",
                                                          "Hungarian".localizeString():"hu",
                                                          "Montenegrin".localizeString():"cnr",
                                                          "Indonesian".localizeString():"id",
                                                          "Italian".localizeString():"it",
                                                          "Simplified Chinese".localizeString():"zh",
                                                          "Japanese".localizeString():"ja",
                                                          "Dutch".localizeString():"nl",
                                                          "Finnish".localizeString():"fi",
                                                          "Irish".localizeString():"ga",
                                                          "Gujarati".localizeString():"gu",
                                                          "Polish".localizeString():"pl",
                                                          "Danish".localizeString():"da",
                                                          "Lithuanian".localizeString():"lt",
                                                          "Latvian".localizeString():"lv",
                                                          "Ukrainian".localizeString():"uk",
                                                          "Urdu".localizeString():"ur",
                                                          "Malayalam".localizeString():"ml",
                                                          "Malay".localizeString():"ms",
                                                          "Maltese".localizeString():"mt",
                                                          "Greek".localizeString():"el",
                                                          "Spanish".localizeString():"es",
                                                          "Estonian".localizeString():"et",
                                                          "Norwegian".localizeString():"nb",
                                                          "Vietnamese".localizeString():"vi",
                                                          "Nepali".localizeString():"ne",
                                                          "Romanian".localizeString():"ro",
                                                          "Russian".localizeString():"ru",
                                                          "Bulgarian".localizeString():"bg",
                                                          "Bengali".localizeString():"bn",
                                                          "Bosnian".localizeString():"bs",
                                                          "Slovakian".localizeString():"sk",
                                                          "Slovenian".localizeString():"sl",
                                                          "Serbian".localizeString():"sr",
                                                          "Korean".localizeString():"ko",
                                                          "Swedish".localizeString():"sv",
                                                          "Tamil".localizeString():"ta",
                                                          "Czech".localizeString():"cs",
                                                          "Telugu".localizeString():"te",
                                                          "Thai".localizeString():"th",
                                                          "Welsh".localizeString():"cy",
                                                          "Catalan".localizeString():"ca"
                                                           ,"Basque".localizeString():"eu"]
    
    static var savedWordsArray : [TranslatedWord] = [] {
        didSet{
            if savedWordsArray.count == 0{
                delegate?.listenedArraySize(cleared: true)
            }
        }
    }
    
        

    private init(){}
}
