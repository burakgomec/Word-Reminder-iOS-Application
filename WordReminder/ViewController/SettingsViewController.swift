//
//  SettingsViewController.swift
//  WordReminder
//
//  Created by Burak on 6.06.2021.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    
    let settingRowArray : [String] = ["About".localizeString(),"Notifications".localizeString(),"Feedback".localizeString()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews(){
        settingsTableView.frame = CGRect(x: settingsTableView.frame.origin.x, y: settingsTableView.frame.origin.y, width: settingsTableView.frame.size.width, height: settingsTableView.contentSize.height)
    }
    

    @IBAction func deleteAllTranslatedWords(_ sender: Any) {
        makeOptionAlert(title: "Clear Translation History".localizeString(), message: "All translation history will be cleared from this application".localizeString()) { result in
            if result{
                guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
                let context = delegate.persistentContainer.viewContext
                CoreDataController.shared.clearAllRecords(objectContext: context)
            }
        }
    }
}

extension SettingsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingRowArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.settingRowArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .tertiarySystemBackground
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        let rowIndex = indexPath.row
        switch rowIndex {
        case 0:
            performSegue(withIdentifier: "toAboutVC", sender: nil)
        case 1:
            performSegue(withIdentifier: "toNotificationVC", sender: nil)
            break
        case 2:
            SKStoreReviewController.requestReviewInCurrentScene()
            break
        default:
            break
        }
    }

}

