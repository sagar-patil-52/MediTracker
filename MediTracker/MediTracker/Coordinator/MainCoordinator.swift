//
//  MainCoordinator.swift
//  MediTracker
//
//  Created by mmt on 25/07/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
    }

    func start() {
        let vc = DashboardViewController.instantiate()
        vc.coordinator = self
        vc.notificationHandler = NotificationHandler()
        vc.todayViewModel = TodayViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showHistory() {
        let vc = HistoryViewController.instantiate()
        vc.historyViewModel = HistoryViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
}
