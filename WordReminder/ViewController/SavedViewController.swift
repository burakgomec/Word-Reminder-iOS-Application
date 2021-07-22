//
//  SavedViewController.swift
//  WordReminder
//
//  Created by Burak on 6.06.2021.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var recordedTableView: UITableView!
    
    var navigationBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordedTableView.dataSource = self
        recordedTableView.delegate = self
        navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        Constants.delegate = self
        CoreDataController.shared.delegate = self //Delegate Design Pattern
        
    }

    override func viewDidLayoutSubviews() {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let labelY = height * 0.5 - height * 0.5 / 2 - navigationBarHeight!
        label.frame = CGRect(x: width * 0.5 - width * 0.9 / 2, y: labelY, width: width * 0.9, height: height * 0.5)
        label.numberOfLines = 0
        view.addSubview(label)
        if Constants.savedWordsArray.isEmpty {
            label.isHidden = false
            //recordedTableView.isHidden = true
        }
        else{
            label.isHidden = true
        }
    }
    
     var label : UILabel = {
        let label = UILabel()
        label.text = "Star a translation to see it here".localizeString()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont(name: "Arial", size:19)
        return label
    }()
}


//Mark: TableView Operations
extension SavedViewController : UITableViewDataSource,UITabBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //Each saved word is a section
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell",for: indexPath) as! SavedCell
        cell.word1Label.text =  Constants.savedWordsArray[indexPath.section].word1
        cell.word2Label.text = Constants.savedWordsArray[indexPath.section].word2
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.savedWordsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}


//Mark: Protocol-Listener Operation
extension SavedViewController : UpdatesDelegate{
    
    func listenedArraySize(cleared: Bool) {
        if cleared{
            label.isHidden = false
            //self.recordedTableView.isHidden = true ?
        }
    }
    
    func didFinishUpdates(finished: Bool) {
        if finished{
            self.recordedTableView.reloadData()
            if !label.isHidden {
                label.isHidden = true
            }

        }
    }
    
}
