//
//  DeclineTransactionView.swift
//  Limit
//
//  Created by Павел on 17.04.2021.
//

import UIKit

class DeclineTransactionView: UIView {

    var transactionAmount: Double
    var limit: Double
    
    init(transactionAmount: Double, limit: Double){
        self.transactionAmount = transactionAmount
        self.limit = limit
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var declineTransactionView: UIProgressView = {
        let declineTransactionView = UIProgressView()
        declineTransactionView.translatesAutoresizingMaskIntoConstraints = false
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
        declineTransactionView.tintColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
        return declineTransactionView
    }()
    private lazy var upperTransactionLimitLabel: UILabel = {
        let upperTransactionLimitLabel = UILabel()
        upperTransactionLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        upperTransactionLimitLabel.text = "\(String(limit).doubleValue.currency)"
        upperTransactionLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        upperTransactionLimitLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        upperTransactionLimitLabel.layer.zPosition = 2
        return upperTransactionLimitLabel
    }()
    private lazy var transactionAmountLabel: UILabel = {
        let transactionAmountLabel = UILabel()
        transactionAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionAmountLabel.text = "\(String(transactionAmount).doubleValue.currency)"
        transactionAmountLabel.font = UIFont(name: "Suisse Intl", size: 24)
        transactionAmountLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        transactionAmountLabel.layer.zPosition = 2
        return transactionAmountLabel
    }()
    
    func setup(){
        self.addSubview(declineTransactionView)
        self.addSubview(upperTransactionLimitLabel)
        if transactionAmount == 0{
            transactionAmountLabel.isHidden = true
        }
        if transactionAmount != limit{
            declineTransactionView.addSubview(transactionAmountLabel)
            self.transactionAmountLabel.isHidden = true
            let progress = CGFloat(1 - Float(transactionAmount/limit))
            
            let progressWidth = UIScreen.main.bounds.width * progress
            let leftWidth = UIScreen.main.bounds.width - progressWidth
            print("leftWidth", leftWidth)
            print("progressWidth", progressWidth)
            let constraint = transactionAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor , constant: -progressWidth-8)
            
            let constraintLeft = transactionAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 25)
            
            if leftWidth > transactionAmountLabel.intrinsicContentSize.width + 25{
                constraint.isActive = true
                constraintLeft.isActive = false
                print("constraint -progress")
            } else {
                constraint.isActive = false
                constraintLeft.isActive = true
                print("constraint -25")
            }
            
            NSLayoutConstraint.activate([
                transactionAmountLabel.topAnchor.constraint(equalTo: declineTransactionView.topAnchor, constant: 8)
            ])
        }
        
        
        NSLayoutConstraint.activate([
            upperTransactionLimitLabel.bottomAnchor.constraint(equalTo: declineTransactionView.bottomAnchor, constant: -8),
            upperTransactionLimitLabel.trailingAnchor.constraint(equalTo: declineTransactionView.trailingAnchor,constant: -24),
            
            declineTransactionView.topAnchor.constraint(equalTo: self.topAnchor ),
            declineTransactionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            declineTransactionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            declineTransactionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    func animate() {
        let progress = 1 - Float(transactionAmount/limit)
        self.transactionAmountLabel.isHidden = true
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
        declineTransactionView.setProgress(0, animated: false)
        if self.transactionAmount != 0 {
            self.declineTransactionView.layoutIfNeeded()
            self.declineTransactionView.setProgress(progress, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.transactionAmountLabel.isHidden = false
            }
        }
    }

}
