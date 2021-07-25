//
//  HistoryTableViewCell.swift
//  MediTracker
//
//  Created by mmt on 16/07/21.
//


import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var morning: UILabel!
    @IBOutlet weak var afternoon: UILabel!
    @IBOutlet weak var evening: UILabel!
    @IBOutlet weak var cellBg: UIView!
    
    @IBOutlet weak var morningTime: UILabel!
    @IBOutlet weak var afternoonTime: UILabel!
    @IBOutlet weak var eveningTime: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureCell( daily : DailyDose) {
        
        styleCell()
        
        if let date = daily.date {
            dateLabel.text = Utils.formatDate(date: date )
        }
    
        var showNoMedicine = true
        if let morningValue = daily.morning {
            morningTime.text = Utils.getTime(date: morningValue)
            showNoMedicine = false
            morningTime.isHidden = false
            morning.isHidden = false
        } else {
            morningTime.isHidden = true
            morning.isHidden = true
        }
        
        if let afternoonValue = daily.afternoon {
            afternoonTime.text = Utils.getTime(date: afternoonValue)
            showNoMedicine = false
            afternoonTime.isHidden = false
            afternoon.isHidden = false
        } else {
            afternoonTime.isHidden = true
            afternoon.isHidden = true
        }
        
        if let eveningValue = daily.evening {
            eveningTime.text = Utils.getTime(date: eveningValue)
            showNoMedicine = false
            eveningTime.isHidden = false
            evening.isHidden = false
        } else {
            eveningTime.isHidden = true
            evening.isHidden = true
        }
        
        if showNoMedicine {
            self.afternoon.isHidden = false
            self.afternoon.text = Constants.Strings.noMedicineTaken
        } else {
            self.afternoon.text = Constants.Strings.afternoon
        }
        
        scoreLabel.text = "\(daily.score)"
        scoreLabel.textColor = colorForScore(score: daily.score)
    }
    
    func colorForScore(score : Int) -> UIColor {
        
        switch score {
        case 0:
            return UIColor.red
        case 30:
            return UIColor.orange
        case 40:
            return UIColor.orange
        case 70:
            return UIColor.yellow
        case 100:
            return UIColor.green
        default:
            return UIColor.white
        }
        
    }
    
    func styleCell()  {
        
        let gradient = CAGradientLayer()
        gradient.frame = cellBg.bounds
        gradient.startPoint = CGPoint.init(x: 0, y: 0)
        gradient.endPoint = CGPoint.init(x: 1, y: 1)
        gradient.colors = [Constants.Colors.blueColor.cgColor, Constants.Colors.darkBlueColor.cgColor]
        cellBg.layer.insertSublayer(gradient, at: 0)
        
        cellBg.layer.cornerRadius = 15
        gradient.cornerRadius = cellBg.layer.cornerRadius
        cellBg.layer.shadowOpacity = 0.5
        cellBg.layer.shadowColor = UIColor.white.cgColor
        cellBg.layer.masksToBounds = true;
        cellBg.layer.shadowRadius = 3
        cellBg.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        cellBg.layer.borderWidth = 0.5
        cellBg.layer.borderColor = Constants.Colors.blueColor.cgColor
        
    }
}
