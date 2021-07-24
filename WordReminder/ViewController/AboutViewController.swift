//
//  AboutViewController.swift
//  WordReminder
//
//  Created by Burak on 18.07.2021.
//

import UIKit

class AboutViewController: UIViewController {

  
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        infoTextView.text = "Word Reminder is an open source translation reminder application. \n\nYou can access the entire source code of the application via the link below.\n\nYou can support my development of independent applications and offer suggestions by giving stars to the application on the App Store and Github. \n\nIcons made by www.freepik.com \n\nDeveloper: Burak GÖMEÇ"
    }

}
