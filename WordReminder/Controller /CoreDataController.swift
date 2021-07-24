//
//  CoreDataController.swift
//  WordReminder
//
//  Created by Burak on 18.07.2021.
//

import Foundation
import CoreData


class CoreDataController {
    
    static let shared = CoreDataController()
    var delegate : UpdatesDelegate?
    var objectContext : NSManagedObjectContext?

    
    func saveWord(wordParameter: TranslatedWord){
        let word = Words(context: objectContext!)
        word.id = wordParameter.id
        word.code1 = wordParameter.code1
        word.code2 = wordParameter.code2
        word.word1 = wordParameter.word1
        word.word2 = wordParameter.word2
        do{
            try objectContext!.save()
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        Constants.savedWordsArray.append(wordParameter)
        delegate?.didFinishUpdates(finished: true)
    }
    
    
    func getWords(context: NSManagedObjectContext){
        objectContext = context
        let fetchRequest = NSFetchRequest<Words>(entityName: "Words")
        do{
            let savedWords = try context.fetch(fetchRequest)
            if savedWords.isEmpty {
                delegate?.listenedArraySize(cleared: true)
            }
            for savedWord in savedWords{
                let word = TranslatedWord(id: savedWord.id!, word1: savedWord.word1!, word2: savedWord.word2!, code1: savedWord.code1!, code2: savedWord.code2!)
                Constants.savedWordsArray.append(word)
            }
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func deleteWordWithUUID(uuid: UUID){
        let fetchRequest = NSFetchRequest<Words>(entityName: "Words")
    
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
         
        do{
            let matchingWords = try objectContext?.fetch(fetchRequest)
            if matchingWords != nil{
                for deletedWord in matchingWords!{
                    objectContext?.delete(deletedWord)
                }
                do {
                    try objectContext?.save()
                }
                catch let error as NSError{
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        Constants.savedWordsArray.removeAll{ word in
            return word.id == uuid
        }
        delegate?.didFinishUpdates(finished: true)
    }
    
    
    func deleteWordWithModel(word1: String, code1: String, code2: String){
        let fetchRequest = NSFetchRequest<Words>(entityName: "Words")
        do{
            let savedWords = try objectContext!.fetch(fetchRequest)
            for savedWord in savedWords{
                if savedWord.word1 == word1 && savedWord.code1 == code1 && savedWord.code2 == code2{
                    objectContext?.delete(savedWord)
                }
                do {
                    try objectContext?.save()
                }
                catch let error as NSError{
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
        catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        Constants.savedWordsArray.removeAll { word in
            return word.word1 == word1 && word.code1 == code1 && word.code2 == code2
        }
        delegate?.didFinishUpdates(finished: true)
    }
    
    
    
    func clearAllRecords(objectContext: NSManagedObjectContext){
        
        let fetchRequest = NSFetchRequest<Words>(entityName: "Words")
        
        do {
            let savedWords = try objectContext.fetch(fetchRequest)
            for word in savedWords{
                objectContext.delete(word)
            }
            do{
                try objectContext.save()
            }
            catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        Constants.savedWordsArray.removeAll()
        delegate?.didFinishUpdates(finished: true)
        delegate?.listenedArraySize(cleared: true)
    }
    
    func checkWord(word1: String,code1: String, code2: String)->String?{ //Search Algorithm- O(N)
        for word in Constants.savedWordsArray{ //O(N) Time Complexity
            if(word.word1 == word1 && word.code1 == code1 && word.code2 == code2){
                return word.word2
            }
        }
        return nil
    }
    
    
    
    
    
    
    private init(){}
}
