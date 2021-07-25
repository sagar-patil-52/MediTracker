//
//  ViewController.swift
//  MediTracker
//
//  Created by mmt on 15/07/21.
//

import UIKit


class DashboardViewController: UIViewController {
    
    //    let viewModel : MedicinHistoryViewModel
    @IBOutlet weak var btnMedicineTaken: UIButton!
    
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    var todayViewModel = TodayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        greetingLabel.text = todayViewModel.getGreetingMessage()
        //based on time set gm/gm/ge label
        
        scoreLabel.text = "\(todayViewModel.getScore())"
        
        cosmeticUI()
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        //TODO:
        //Packages
        //Core data - 1 hr
        //Local Notification - 1 hr
        //UI/UX - color coding score - 2 hr
        //Util class, constants, strings
        //Use to enums
        //ErrorHandling -
        //Unit test case - 1 hr
        //Unit testing
        
    }
    
    @IBAction func medicineTakenTapped(_ sender: Any) {
        //        based on time set value for medicine taken
        
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["ID"])
        
        
        todayViewModel.medicineTaken()
        scoreLabel.text = "\(todayViewModel.getScore())"
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Title"
        notificationContent.body = "This is a test"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        
        var datComp = DateComponents()
        datComp.hour = 23
        datComp.minute = 43
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
        
        
    }
}

extension DashboardViewController {
    
    func cosmeticUI()  {
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        gradient.colors = [Constants.Colors.blueColor.cgColor, Constants.Colors.darkBlueColor.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
        btnMedicineTaken.layer.cornerRadius = 5
        btnMedicineTaken.layer.shadowOpacity = 1
        btnMedicineTaken.layer.shadowColor = UIColor.black.cgColor
        btnMedicineTaken.layer.masksToBounds = false;
        btnMedicineTaken.layer.shadowOffset = CGSize.init(width: 0, height: 1.0)
        
        btnHistory.layer.cornerRadius = 5
        btnHistory.layer.shadowOpacity = 1
        btnHistory.layer.shadowColor = UIColor.black.cgColor
        btnHistory.layer.masksToBounds = false;
        btnHistory.layer.shadowOffset = CGSize.init(width: 0, height: 1.0)
        
    }
}
