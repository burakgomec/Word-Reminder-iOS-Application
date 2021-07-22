//
//  LanguagesViewController.swift
//  WordReminder
//
//  Created by Burak on 6.06.2021.
//

import UIKit

class LanguagesViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var languageTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var firstLangCode : String?
    var bufferSegueText : String?
    var bufferTableArray = [String]()
    var languagesArray = [String]()
    var control = true
    var searchBarControl = true
    
    var delegate : LanguageDelegate?
    
    var languageNumber : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLabelText()
        searchBar.delegate = self
        languageTableView.dataSource = self
        languageTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBarControl = true
    }
    
    func prepareLabelText(){
        if let text = bufferSegueText {
            if text == "1" {
                infoLabel.text = "Translate From:".localizeString()
                languageNumber = 1
            }
            else{
                infoLabel.text = "Translate To:".localizeString()
                languageNumber = 2
                if let code = firstLangCode{
                    let value = Constants.modelDictionary[code]
                    let languages = value?.components(separatedBy: ",")
                    for language in languages!{
                        let dictionary = Dictionary(uniqueKeysWithValues: Constants.languagesDictionary.map({ ($1, $0)})) //reverse dictionary
                        let regexLanguage = dictionary[language]
                        languagesArray.append(regexLanguage!)
                    }
                }
            }
        }
    }
    
    
    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
//Mark: SearchBar Operation
extension LanguagesViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if bufferSegueText == "1"{
                for i in 0..<Constants.languages.count{
                    control = false
                    if Constants.languages[i].contains(text){
                        bufferTableArray.removeAll()
                        bufferTableArray.append(Constants.languages[i])
                        languageTableView.reloadData()
                    }
                }
        }
        else{
            for language in self.languagesArray{
                print(language)
                control = false
                if language.contains(text){
                    bufferTableArray.removeAll()
                    bufferTableArray.append(language)
                    languageTableView.reloadData()
                }
            }
        }
        self.view.endEditing(true)
    }
    
    private func splitToString(language: String)->[Character]{
        return Array(language)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { //Called when text changes (including clear)
        if searchBar.text == ""{
            searchBarControl = true
            control = true
            bufferTableArray.removeAll()
            languageTableView.reloadData()
        }
        else if(searchBarControl){
            guard let text = searchBar.text?.lowercased() else { return}
            if bufferSegueText == "1"{ //First language
                for i in 0..<Constants.languages.count{
                    control = false
                    let splittedLanguage = splitToString(language: Constants.languages[i].lowercased())
                    let splittedText = splitToString(language: text)
                    var count = 0
                    if splittedText.count<splittedLanguage.count{
                        count = splittedText.count
                    }
                    else {
                        count = splittedLanguage.count
                    }
                    for w in 0..<count{
                        if splittedLanguage[w] == splittedText[w]{
                                bufferTableArray.append(Constants.languages[i])
                                languageTableView.reloadData()
                                searchBarControl = false
                        }
                    }
                    if(searchBarControl){
                        bufferTableArray.removeAll()
                        languageTableView.reloadData()
                    }
                }
            }
            else{ //Second language
                for language in self.languagesArray{
                    control = false
                    let splittedLanguage = splitToString(language:language.lowercased())
                    let splittedText = splitToString(language: text)
                    var count = 0
                    if splittedText.count<splittedLanguage.count{
                        count = splittedText.count
                    }
                    else {
                        count = splittedLanguage.count
                    }
                    for w in 0..<count{
                        if splittedLanguage[w] == splittedText[w]{
                                bufferTableArray.append(language)
                                languageTableView.reloadData()
                                searchBarControl = false
                        }
                    }
                    if(searchBarControl){
                        bufferTableArray.removeAll()
                        languageTableView.reloadData()
                    }
                }
            }
            
        }
    }
}


extension LanguagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bufferSegueText == "1"{
            if control{
                return Constants.languages.count
            }
            else{
                return bufferTableArray.count
            }
        }
        else{
            if control{
                return languagesArray.count
            }
            else{
                return bufferTableArray.count
            }
           
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if bufferSegueText == "1"{ //First language
            if control{
                cell.textLabel?.text = Constants.languages[indexPath.row]
            }
            else{
                cell.textLabel?.text = self.bufferTableArray[indexPath.row]
            }
        }
        else{ //Second Language
            
            if control{
                cell.textLabel?.text = self.languagesArray[indexPath.row]
            }
            else{
                cell.textLabel?.text = self.bufferTableArray[indexPath.row]
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if control && bufferSegueText == "1"{ //?
            print("1")
            delegate?.wordReady(language: Constants.languages[indexPath.row], languageNumber: languageNumber!)
        }
        else if control && bufferSegueText == "2"{
            print("2, \(indexPath.row), size:\(bufferTableArray.count)")
            delegate?.wordReady(language: self.languagesArray[indexPath.row], languageNumber: languageNumber!)
        }
        else if !control && bufferSegueText == "1"{
            print("3")
            delegate?.wordReady(language: self.bufferTableArray[indexPath.row], languageNumber: languageNumber!) 
        }
        else{
            print("4")
            delegate?.wordReady(language: self.bufferTableArray[indexPath.row], languageNumber: languageNumber!)
        }
        self.dismiss(animated: true)
    }
}
