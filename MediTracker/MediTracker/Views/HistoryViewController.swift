//
//  HistoryViewController.swift
//  MediTracker
//
//  Created by mmt on 16/07/21.
//

import UIKit

class HistoryViewController: UIViewController, Storyboarded {
    
    var historyViewModel : HistoryViewModel?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cosmeticUI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        spinner.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyViewModel?.getHistory()
        spinner.stopAnimating()
        self.errorLabel.text = historyViewModel?.getErrorMessage() ?? ""
        tableView.reloadData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyViewModel?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.historyTableViewCell, for: indexPath) as? HistoryTableViewCell {
            if historyViewModel?.history.count ?? 0 > indexPath.row, let dailyDose = historyViewModel?.history[indexPath.row] {
                cell.configureCell(daily: dailyDose)
                return cell
            }
        }
        return HistoryTableViewCell.init()
    }
}

extension HistoryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension HistoryViewController {
    func cosmeticUI()  {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        gradient.colors = [Constants.Colors.blueColor.cgColor, Constants.Colors.darkBlueColor.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
