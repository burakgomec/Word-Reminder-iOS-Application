//
//  AboutViewController.swift
//  WordReminder
//
//  Created by Burak on 18.07.2021.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController{

  
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var sourceCodeInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    private func configureUI(){
        infoTextView.text = "Word Reminder is an open source translation reminder application. \n\nYou can access the entire source code of the application via the link below.\n\nYou can support my development of independent applications and offer suggestions by giving stars to the application on the App Store and Github. \n\nIcons made by www.freepik.com \n\nDeveloper: Burak GÖMEÇ".localizeString()
        
        let buttonAttribute: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
        
        sourceCodeInfoButton.titleLabel?.lineBreakMode = .byWordWrapping
        sourceCodeInfoButton.titleLabel?.numberOfLines = 0
        sourceCodeInfoButton.titleLabel?.textAlignment = .center
        sourceCodeInfoButton.addTarget(self, action: #selector(openGithubRepo), for: UIControl.Event.allTouchEvents)
        sourceCodeInfoButton.sizeToFit()
        
        let attributeString = NSMutableAttributedString(
            string: "You can access the source code of the application by clicking here".localizeString(),
            attributes: buttonAttribute
         )
        sourceCodeInfoButton.setAttributedTitle(attributeString, for: .normal)
    }
        
    @objc func openGithubRepo(){
        let config = SFSafariViewController.Configuration()
        
        let safariVC = SFSafariViewController(url: URL(string: "https://github.com/burakgomec/Word-Reminder-iOS-Application")!, configuration: config)
        present(safariVC, animated: true, completion: nil )
    }

}

