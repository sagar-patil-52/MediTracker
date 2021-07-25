//
//  Router.swift
//  MediTracker
//
//  Created by mmt on 22/07/21.
//

import Foundation
import UIKit

class Router {
    
    func entry() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: Constants.Identifiers.main, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.dashboardVC) as! DashboardViewController
        vc.todayViewModel = TodayViewModel()
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
    
    func start() {
        //1. Request Authorisation for Notification
        //2. Set Notifiaction
        //3. Start UI Flow
    }
}
