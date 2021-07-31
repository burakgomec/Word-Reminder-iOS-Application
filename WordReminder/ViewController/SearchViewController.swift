//
//  ViewController.swift
//  WordReminder
//
//  Created by Burak on 5.06.2021.
//

import UIKit
import UserNotifications

class SearchViewController: UIViewController,LanguageDelegate {
    
    @IBOutlet weak var firstLangButton: UIButton!
    @IBOutlet weak var secondLangButton: UIButton!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var firstGroupView: UIView!
    @IBOutlet weak var secondGroupView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var firstLangLabel: UILabel!
    @IBOutlet weak var secondLangLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var languagesStackView: UIStackView!
    @IBOutlet weak var firstGroupStackView: UIView!
    @IBOutlet weak var secondGroupStackView: UIView!
    
    var code1, code2, word1, word2 : String?
    var lang1, lang2 : String?
    var activityIndicator = UIActivityIndicatorView()
    var selectLanguageControl = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextView.delegate = self
        prepareForView()
        hideKeyboard()
        prepareForViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let defaultCode1 = defaults.object(forKey: "code1") as? String
        let defaultCode2 = defaults.object(forKey: "code2") as? String
        let defaultLanguage1  = defaults.object(forKey: "lang1") as? String
        let defaultLanguage2 = defaults.object(forKey: "lang2") as? String
        
        code1 = defaultCode1 ?? "en"
        code2 = defaultCode2 ?? "tr"
        lang1 = defaultLanguage1?.localizeString() ?? "English".localizeString()
        lang2 = defaultLanguage2?.localizeString() ?? "Turkish".localizeString()
        
        firstLangButton.setTitle(lang1, for: .normal)
        secondLangButton.setTitle(lang2, for: .normal)
        firstLangLabel.text = lang1
        secondLangLabel.text = lang2
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if selectLanguageControl{
            let defaults = UserDefaults.standard
            defaults.setValue(code1, forKey: "code1")
            defaults.setValue(code2, forKey: "code2")
            defaults.setValue(lang1, forKey: "lang1")
            defaults.setValue(lang2, forKey: "lang2")
        }
    }
    func prepareForView(){
        firstGroupView.layer.borderWidth = 1.5
        firstGroupView.layer.cornerRadius = 16
        secondGroupView.layer.borderWidth = 1.5
        secondGroupView.layer.cornerRadius = 16
        
        
        self.view.backgroundColor = UIColor.Custom.backgroundBlack
        self.firstGroupStackView.backgroundColor = UIColor.Custom.backgroundGrayWhite
        self.secondGroupStackView.backgroundColor = UIColor.Custom.backgroundGrayWhite
        firstGroupView.layer.borderColor = UIColor.Custom.borderColor.cgColor
        secondGroupView.layer.borderColor = UIColor.Custom.borderColor.cgColor
    }
    
    func prepareForViewAnimation(){
        UIView.animate(withDuration: 0.4, delay: 0.10, options: UIView.AnimationOptions.curveLinear, animations: {
            self.languagesStackView.frame.origin.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.20, options: UIView.AnimationOptions.curveLinear, animations: {
            self.firstGroupStackView.frame.origin.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.40, options: UIView.AnimationOptions.curveLinear, animations: {
            self.secondGroupStackView.frame.origin.x += self.view.bounds.width
        }, completion: nil)
    }
    

    
    func wordReady(language: String,languageNumber:Int) {
        if(languageNumber == 1){
            firstLangButton.setTitle(language, for: .normal)
            firstLangLabel.text = language
            secondLangButton.setTitle("Choose a language".localizeString(), for: .normal)
            secondLangLabel.text = "Choose a language".localizeString()
            code1 = Constants.languagesDictionary[language]
            selectLanguageControl = false
            lang1 = language
        }
        else{
            secondLangButton.setTitle(language, for: .normal)
            secondLangLabel.text = language
            code2 = Constants.languagesDictionary[language]
            selectLanguageControl = true
            lang2 = language
        }
    }
    
    func getTranslateResult(word: String,code1: String, code2: String){
            WebService.shared.translateWord(word1: word, code1: code1, code2: code2, completion: { result in
                if let labelResult = result{
                    DispatchQueue.main.async {
                        self.secondTextView.isHidden = false
                        self.secondTextView.text = labelResult
                        self.indicatorView.stopAnimating()
                        self.word2 = labelResult
                    }
                }
            })
    }

    @IBAction func reverseLanguages(_ sender: Any) {
        if selectLanguageControl{
            var bufferString = code2
            code2 = code1
            code1 = bufferString
            bufferString = lang2
            lang2 = lang1
            lang1 = bufferString
            firstLangButton.setTitle(lang1, for: .normal)
            secondLangButton.setTitle(lang2, for: .normal)
            firstLangLabel.text = lang1
            secondLangLabel.text = lang2
            
            guard let text = secondTextView.text else { return }
            if text != ""{
                firstTextView.text = text
                word1 = text
                
                let result = CoreDataController.shared.checkWord(word1:text, code1: code1!, code2: code2!)
            
                if (starButton.imageView?.tag == 1){ //Starred translation
                    if result == nil{
                        starButton.imageView?.tag = 0
                        setStarImage()
                        getTranslateResult(word: text, code1: code1!, code2: code2!)
                    }
                    else {
                        self.secondTextView.text = result
                        self.word2 = result
                    }
                }
                else { //Not-starred translation
                    if result == nil{
                        starButton.imageView?.tag = 0
                        setStarImage()
                        getTranslateResult(word: text, code1: code1!, code2: code2!)
                    }
                    else {
                        self.secondTextView.text = result
                        self.word2 = result
                        setStarFillImage()
                        self.starButton.imageView?.tag = 1
                    }
                }
            }
        }
    }
    
    @IBAction func segueToFirstLang(_ sender: Any) {
        firstTextView.text = ""
        secondTextView.text = ""
        self.performSegue(withIdentifier: "toPickLangVC", sender: "1")
    }
    
    @IBAction func segueToSecondLang(_ sender: Any) {
        firstTextView.text = ""
        secondTextView.text = ""
        self.performSegue(withIdentifier: "toPickLangVC", sender: "2")
    }
    
    @IBAction func clearTextView(_ sender: Any) {
        if firstTextView.text != ""{
            firstTextView.text = ""
        }
        secondTextView.text = ""
        if starButton.imageView?.tag  == 1 {
            setStarImage()
            starButton.imageView?.tag = 0
        }
        word1 = nil
        word2 = nil
    }
    
    
    
    @IBAction func saveTranslatedWord(_ sender: Any) {
        if word1 != nil && word2 != nil && code1 != nil && code2 != nil{
            if starButton.imageView?.tag == 0 {
                    setStarFillImage()
                    starButton.imageView?.tag = 1
                    let word = TranslatedWord(id: UUID(), word1: word1!, word2: word2!, code1: code1!, code2: code2!)
                    CoreDataController.shared.saveWord( wordParameter: word)
            }
            else{
                setStarImage()
                starButton.imageView?.tag = 0
                CoreDataController.shared.deleteWordWithModel(word1: word1!, code1: code1!, code2: code2!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPickLangVC"{
            if let vc = segue.destination as? LanguagesViewController{
                vc.delegate = self //Delegate Design Pattern
                if let sender = sender as? String{
                    if sender == "1"{
                        vc.bufferSegueText = "1"
                    }
                    else if sender == "2"{
                        vc.bufferSegueText = "2"
                        vc.firstLangCode = code1
                    }
                }
            }
        }
    }
    
    func setStarImage(){
        starButton.setImage(UIImage(systemName: "star"), for: .normal)

    }
    func setStarFillImage(){
         starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }

}

//Mark: TextView Operations
extension SearchViewController : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        clearTextButton.isHidden = false
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        clearTextButton.isHidden = true
        return true
    }
    
    func checkWordFromCoreData(word: String, code1: String, code2: String)->Bool{ //If available in core data return true else return false
        if let result = CoreDataController.shared.checkWord(word1: word, code1: code1, code2: code2){
            setStarFillImage()
            starButton.imageView?.tag = 1
            self.secondTextView.text = result
            self.word2 = result
            return true
        }
        return false
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        firstTextView.enablesReturnKeyAutomatically = false
        if text == "\n"{ //While pressed in search button in keyboard
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                if selectLanguageControl{
                    if let code1 = code1, let code2 = code2{
                        if starButton.imageView?.tag == 1 {
                            starButton.imageView?.tag = 0
                            setStarImage()
                        }
                        self.word1 = textView.text
                        if(!checkWordFromCoreData(word: textView.text, code1: code1, code2: code2)){
                            getTranslateResult(word: textView.text, code1: code1, code2: code2)
                            secondTextView.isHidden = true
                            self.indicatorView.startAnimating()
                        }
                    }
                    else{
                        self.makeAlert(title: "Error".localizeString(), message: "Select second language".localizeString())
                    }
                }
                else{
                    self.makeAlert(title: "Error".localizeString(), message: "Select second language".localizeString())
                }
            }
            textView.resignFirstResponder()
            return false
        }
        return true

    }
    
    func hideKeyboard(){
        let endTapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(endTapGesture)
    }
    @objc func endEditing(){
        view.endEditing(true)
    }
}

