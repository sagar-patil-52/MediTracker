//
//  DashboardViewController.swift
//  MediTracker
//
//  Created by mmt on 15/07/21.
//

import UIKit


class DashboardViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var btnMedicineTaken: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    weak var coordinator: MainCoordinator?

    //TODO:Remove forced unwrapping
    var todayViewModel: TodayViewModel?
    var notificationHandler: NotificationHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        todayViewModel?.delegate = self
        setupUI()
        cosmeticUI()
        
        notificationHandler?.requestAuthorisationForLocalNotifications()
        
        //TODO:
        //Use to enums
        //ErrorHandling - 1 hr
        //Unit test case - 1 hr
    }
    
    // MARK: Private Methods
    private func setupUI() {
        greetingLabel.text = todayViewModel?.getGreetingMessage()
        scoreLabel.text = "\(todayViewModel?.getScore() ?? 0)"
    }
    
    // MARK: IBActions
    @IBAction func medicineTakenTapped(_ sender: Any) {
        //        based on time set value for medicine taken
        todayViewModel?.medicineTaken()
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        coordinator?.showHistory()
    }
}

extension DashboardViewController: MedicineScheduleDelegate {
    
    func didTakeMedicine(time: String, hasTaken: Bool) {
        DispatchQueue.main.async { [weak self] in
            if hasTaken {
                guard let score = self?.todayViewModel?.getScore() else { return }
                self?.scoreLabel.text = "\(score)"
                self?.notificationHandler?.cancelNotifications(notificationID: time)
            } else {
                let alert = UIAlertController(title: Constants.Error.invalidMedicineTimeErrorTitle,
                                              message: Constants.Error.invalidMedicineTimeErrorMessage,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:Constants.Strings.ok,
                                              style: .default,
                                              handler: nil))
                self?.present(alert, animated: true, completion: nil)
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
