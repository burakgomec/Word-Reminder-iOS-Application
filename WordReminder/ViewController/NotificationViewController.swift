//
//  NotificationViewController.swift
//  WordReminder
//
//  Created by Burak on 29.07.2021.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var timeTextField: UITextField!
    
    let toolBar = UIToolbar()
    let timePicker  = UIDatePicker()
    var hour, minute : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedTimeZoneFromUserDefaults()
        configureUI()
    }
    
    
    func getSavedTimeZoneFromUserDefaults(){
        let defaults = UserDefaults.standard
        let defaultHour = defaults.object(forKey: "hour") as? String
        let defaultMinute = defaults.object(forKey: "minute") as? String
        hour = defaultHour ?? "17"
        minute = defaultMinute ?? "00"
    }

    func configureUI(){
        infoTextView.text = "Word Reminder notifies the saved translations every day at the specified time. \n\nYou can change your notification preference from Settings-Word Reminder-Notifications. \n\nYou can change the time zone of notifications by clicking the field below.".localizeString()
        configureTimePicker()
        configureTextField()
    }
    
    private func configureTimePicker(){
        let toolBar = UIToolbar()
        let timePicker  = UIDatePicker()
        
        toolBar.sizeToFit()
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "en_GB")
        
        let flexibleSpace   = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNewNotificationTime))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeTimePicker))
        toolBar.setItems([cancelButton, flexibleSpace, doneButton] , animated: true)
        
        timePicker.addTarget(self, action: #selector(getTimeZoneFromDatePicker(sender:)), for: UIControl.Event.valueChanged)
        timeTextField.inputView = timePicker
        timeTextField.inputAccessoryView = toolBar
    }
    
    private func configureTextField(){
        timeTextField.text = "Selected Time =".localizeString() + " \(hour!):\(minute!)"
        timeTextField.textColor = .red
        timeTextField.textAlignment = .center
        timeTextField.addTarget(self, action: #selector(checkPermissionOfNotifications), for: .touchDown)
    }
    
    @objc func checkPermissionOfNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { result, _ in
            if !result{
                DispatchQueue.main.async {
                    self.makeAlert(title: "Error".localizeString(), message: "Please change the notification preferences of the app".localizeString())
                }
            }
        }
    }
    
    @objc func saveNewNotificationTime(){
        view.endEditing(true)
        timeTextField.text = "Selected Time =".localizeString() + " \(hour!):\(minute!)"
        let defaults = UserDefaults.standard
        defaults.setValue(hour!, forKey: "hour")
        defaults.setValue(minute!, forKey: "minute")
        NotificationController.shared.scheduleNotification()
    }
    
    @objc func getTimeZoneFromDatePicker(sender: UIDatePicker){
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        let componentsHour = components.hour!
        let componentsMinute = components.minute!
        
        hour = String(componentsHour)
        minute = String(componentsMinute)
    }
    
    @objc func closeTimePicker(){
        view.endEditing(true)
    }
    
    
  
    
}
