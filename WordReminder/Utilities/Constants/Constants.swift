//
//  Constants.swift
//  WordReminder
//
//  Created by Burak on 7.06.2021.
//

import Foundation


class Constants  {
    
    
    static var delegate : UpdatesDelegate?
   
    static let languages : [String] = ["Türkçe","İngilizce","Almanca","Fransızca","Fransızca-Kanada","Hintçe","İbranice","Portekizce","Geleneksel Çince","Hırvatça","Macarca","Karadağca","Endonezya Dili","İtalyanca","Basitleştirilmiş Çince","Japonca","Felemenkçe","Fince","İrlandaca","Guceratça","Lehçe","Danca","Litvanca","Letonca","Ukraynaca","Urduca","Malayalamca","Malayca",
        "Malta Dili","Yunanca","İspanyolca","Estonyaca","Norveççe","Vietnamca","Nepalce","Romence","Rusça","Bulgarca","Bengalce","Boşnakça","Slovakça","Slovence","Sırpça",
        "Korece","İsveççe","Tamil","Çekçe","Telugu Dili","Tay Dili","Galce","Katalanca","Baskça"]
    
    
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

    
    static let languagesCodes : [String] = ["tr","en","de","fr","fr-CA","hi","he","pt","zh-TW","hr","hu","cnr","id","it","zh","ja","nl","fi","ga","gu","pl","da","lt","lv","uk","ur","ml","ms",
        "mt","el","es","et","nb","vi","ne","ro","ru","bg","bn","bs","sk","sl","sr",
        "ko","sv","ta","cs","te","th","cy","ca","eu"]
 
    
    static var savedWordsArray : [TranslatedWord] = [] {
        didSet{
            if savedWordsArray.count == 0{
                delegate?.listenedArraySize(cleared: true)
            }

        }
    }
    
    static let languagesDictionary : [String : String] = ["Türkçe":"tr","İngilizce":"en","Almanca":"de" ,"Fransızca":"fr","Fransızca-Kanada":"fr-CA"
                                                          ,"Hintçe":"hi",
                                                          "İbranice":"he"
                                                          ,"Portekizce":"pt" ,
                                                          "Geleneksel Çince":"zh-TW"
                                                          ,"Hırvatça":"hr",
                                                           "Macarca":"hu",
                                                           "Karadağca":"cnr",
                                                           "Endonezya Dili":"id",
                                                           "İtalyanca":"it",
                                                           "Basitleştirilmiş Çince":"zh",
                                                           "Japonca":"ja",
                                                           "Felemenkçe":"nl",
                                                           "Fince":"fi",
                                                           "İrlandaca":"ga",
                                                           "Guceratça":"gu",
                                                           "Lehçe":"pl",
                                                           "Danca":"da",
                                                           "Litvanca":"lt",
                                                           "Letonca":"lv",
                                                           "Ukraynaca":"uk",
                                                           "Urduca":"ur",
                                                           "Malayalamca":"ml",
                                                           "Malayca":"ms",
                                                           "Malta Dili":"mt",
                                                           "Yunanca":"el",
                                                           "İspanyolca":"es",
                                                           "Estonyaca":"et",
                                                           "Norveççe":"nb",
                                                           "Vietnamca":"vi",
                                                           "Nepalce":"ne",
                                                           "Romence":"ro",
                                                           "Rusça":"ru",
                                                           "Bulgarca":"bg",
                                                           "Bengalce":"bn",
                                                           "Boşnakça":"bs",
                                                           "Slovakça":"sk",
                                                           "Slovence":"sl",
                                                           "Sırpça":"sr",
                                                           "Korece":"ko",
                                                           "İsveççe":"sv",
                                                           "Tamil":"ta",
                                                           "Çekçe":"cs",
                                                           "Telugu Dili":"te",
                                                           "Tay Dili":"th",
                                                           "Galce":"cy",
                                                           "Katalanca":"ca"
                                                           ,"Baskça":"eu"]
    
        

    private init(){}
}
