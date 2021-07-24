//
//  SavedCell.swift
//  WordReminder
//
//  Created by Burak on 17.07.2021.
//

import UIKit

class SavedCell: UITableViewCell{

    
    @IBOutlet weak var word1Label: UILabel!
    @IBOutlet weak var word2Label: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    
    @IBOutlet weak var wordsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let starTapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteTranslatedWord))
        starImage.addGestureRecognizer(starTapGesture)
        starImage.isUserInteractionEnabled = true
    }

    @objc func deleteTranslatedWord(){
        guard let index = getIndexPath()?.section else{return}
        CoreDataController.shared.deleteWordWithUUID(uuid: Constants.savedWordsArray[index].id)
    }
    
    
    func getIndexPath()->IndexPath? {
        let tableView : UITableView? = self.superview?.superview as? UITableView
        guard let path = tableView?.indexPath(for: self) else {return nil}
        return path
    }

}
