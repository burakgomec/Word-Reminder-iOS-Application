//
//  SKStoreExtension.swift
//  WordReminder
//
//  Created by Burak on 6.06.2021.
//

import Foundation
import StoreKit

extension SKStoreReviewController{
    static func requestReviewInCurrentScene(){
        
        var components = URLComponents(url: URL(string: "https://apps.apple.com/app/id1579382430")!, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
          URLQueryItem(name: "action", value: "write-review")]

        guard let writeReviewURL = components!.url else {
          return
        }
        UIApplication.shared.open(writeReviewURL)
        
        /*
        if #available(iOS 14.0, *){
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene{
                requestReview(in: scene)
            }
        }
        else {
            requestReview()
        }*/
    }
}


extension UIViewController{
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK".localizeString(), style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func makeOptionWithButtonAlert(title: String, message: String,firstButton: String,secondButton: String, completion: @escaping (Bool)->()){
            var result = false
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: firstButton.localizeString(), style: .destructive) { _ in
               result = true
                completion(result)
            }
            let cancelButton = UIAlertAction(title: secondButton.localizeString(), style: UIAlertAction.Style.cancel) { _ in
                result = false
                completion(result)
            }
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true,completion: nil)
    }
    func makeOptionAlert(title: String, message: String, completion: @escaping (Bool)->()){
        var result = false
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Delete".localizeString(), style: .destructive) { _ in
           result = true
            completion(result)
        }
        let cancelButton = UIAlertAction(title: "Cancel".localizeString(), style: UIAlertAction.Style.cancel) { _ in
            result = false
            completion(result)
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true,completion: nil)
    }
}

extension UIColor{
    struct Custom {
        static var backgroundBlack: UIColor{
                return UIColor.init { (trait) -> UIColor in
                    return trait.userInterfaceStyle == .dark ? UIColor.black : UIColor.tertiarySystemGroupedBackground
                }
        }
        static var backgroundGrayWhite: UIColor{
                return UIColor.init { (trait) -> UIColor in
                    return trait.userInterfaceStyle == .dark ? UIColor.systemGray4.withAlphaComponent(0.3) : UIColor.white
                }
        }
        static var borderColor : UIColor{
                return UIColor.init { (trait) -> UIColor in
                    return trait.userInterfaceStyle == .dark ? UIColor.white.withAlphaComponent(0.3) : UIColor.black.withAlphaComponent(1)
                }
        }
        static var labelColor : UIColor{
                return UIColor.init{ (trait) ->  UIColor in
                    return trait.userInterfaceStyle == .dark ? .white.withAlphaComponent(0.9) : .black.withAlphaComponent(0.45)
                }
        }

    }
}


extension String{
    func localizeString()->String{
        return NSLocalizedString(self, comment: "")
    }
}
