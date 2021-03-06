//
//  DeclineTransactionView.swift
//  Limit
//
//  Created by Павел on 17.04.2021.
//

import UIKit

class DeclineTransactionView: UIView {
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var declineTransactionView: UIProgressView = {
		let declineTransactionView = UIProgressView(progressViewStyle: .bar)
        declineTransactionView.translatesAutoresizingMaskIntoConstraints = false
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
		declineTransactionView.trackTintColor = #colorLiteral(red: 0, green: 1, blue: 0.8196078431, alpha: 1)
		declineTransactionView.progressTintColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
        return declineTransactionView
    }()
    private lazy var upperTransactionLimitLabel: UILabel = {
        let upperTransactionLimitLabel = UILabel()
        upperTransactionLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        upperTransactionLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        upperTransactionLimitLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        upperTransactionLimitLabel.layer.zPosition = 2
        return upperTransactionLimitLabel
    }()
    private lazy var transactionAmountLabel: UILabel = {
        let transactionAmountLabel = UILabel()
        transactionAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionAmountLabel.font = UIFont(name: "Suisse Intl", size: 24)
        transactionAmountLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        transactionAmountLabel.layer.zPosition = 2
        return transactionAmountLabel
    }()
    
    func setup(){
        self.addSubview(declineTransactionView)
        self.addSubview(upperTransactionLimitLabel)
        declineTransactionView.addSubview(transactionAmountLabel)
        
        NSLayoutConstraint.activate([
            upperTransactionLimitLabel.bottomAnchor.constraint(equalTo: declineTransactionView.bottomAnchor, constant: -8),
            upperTransactionLimitLabel.trailingAnchor.constraint(equalTo: declineTransactionView.trailingAnchor,constant: -24),
            declineTransactionView.topAnchor.constraint(equalTo: self.topAnchor ),
            declineTransactionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            declineTransactionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            declineTransactionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            transactionAmountLabel.topAnchor.constraint(equalTo: declineTransactionView.topAnchor, constant: 8)
        ])
    }
    
    func fill(transactionAmount: Double, limit: Double, animated: Bool){
        if transactionAmount == 0{
            transactionAmountLabel.isHidden = true
            declineTransactionView.progressTintColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
        self.upperTransactionLimitLabel.text = "\(String(limit).doubleValue.currency)"
        
        if transactionAmount != limit{
            self.transactionAmountLabel.text = "\(String(transactionAmount).doubleValue.currency)"
            self.transactionAmountLabel.isHidden = true
            let progress = CGFloat(1 - Float(transactionAmount/limit))
            
            let progressWidth = UIScreen.main.bounds.width * progress
            let leftWidth = UIScreen.main.bounds.width - progressWidth
            print("leftWidth", leftWidth)
            print("progressWidth", progressWidth)
            let constraint = transactionAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor , constant: -progressWidth-8)
            
            let constraintLeft = transactionAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 25)
            
            if leftWidth > self.transactionAmountLabel.intrinsicContentSize.width + 25{
                print(self.transactionAmountLabel.intrinsicContentSize.width + 25)
                constraint.isActive = true
                constraintLeft.isActive = false
                print("constraint -progress")
            } else {
                constraint.isActive = false
                constraintLeft.isActive = true
                print("constraint -25")
            }
        }
        
        
        let progress = 1 - Float(transactionAmount/limit)
        self.transactionAmountLabel.isHidden = true
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
		self.declineTransactionView.layoutIfNeeded()
		self.declineTransactionView.progress = progress
		UIView.animate(
			withDuration: 1.0,
			delay: 0.0,
			options: [],
			animations: {
				self.declineTransactionView.layoutIfNeeded()
			}, completion: { (_) in
				self.transactionAmountLabel.isHidden = false
			})
    }

    
    
    
}


