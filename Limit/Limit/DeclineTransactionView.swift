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
    var transactionView: UIView
    
    init(transactionAmount: Double, limit: Double, transactionView: UIView, frame: CGRect){
        self.transactionAmount = transactionAmount
        self.limit = limit
        self.transactionView = transactionView
        super.init(frame: frame)
        setup()
        animate()
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
        transactionView.addSubview(declineTransactionView)
        transactionView.addSubview(upperTransactionLimitLabel)
        if transactionAmount == 0{
            transactionAmountLabel.isHidden = true
        }
        if transactionAmount != limit{
            self.transactionView.addSubview(transactionAmountLabel)
            let transactionViewWidth = transactionView.frame.size.width
            let progress = CGFloat(1 - Float(transactionAmount/limit))
            let actualWidth = transactionViewWidth * progress
            let leftWidth = UIScreen.main.bounds.width - actualWidth
            let progressWidth = UIScreen.main.bounds.width - leftWidth
            print("leftWidth", leftWidth)
            print("progressWidth", progressWidth)
            let constraint = transactionAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: transactionView.trailingAnchor , constant: -progressWidth - 8)
            
            let constraintLeft = transactionAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: transactionView.leadingAnchor, constant: 25)
            
            if leftWidth > transactionAmountLabel.intrinsicContentSize.width + 25{
                constraint.isActive = true
                constraintLeft.isActive = false
            } else {
                constraint.isActive = false
                constraintLeft.isActive = true
            }
            
            NSLayoutConstraint.activate([
                transactionAmountLabel.topAnchor.constraint(equalTo: transactionView.topAnchor, constant: 8),
                transactionAmountLabel.heightAnchor.constraint(equalToConstant: 31)
            ])
        }
        
        NSLayoutConstraint.activate([
            upperTransactionLimitLabel.bottomAnchor.constraint(equalTo: transactionView.bottomAnchor, constant: -8),
            upperTransactionLimitLabel.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor,constant: -24),
            upperTransactionLimitLabel.heightAnchor.constraint(equalToConstant: 31),
            
            declineTransactionView.topAnchor.constraint(equalTo: transactionView.topAnchor),
            declineTransactionView.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor),
            declineTransactionView.bottomAnchor.constraint(equalTo: transactionView.bottomAnchor),
            declineTransactionView.leadingAnchor.constraint(equalTo: transactionView.leadingAnchor),
            declineTransactionView.heightAnchor.constraint(equalToConstant: 78),
        ])
    }
    
    func animate() {
        let progress = 1 - Float(transactionAmount/limit)
        print("progress", progress)
        self.transactionAmountLabel.isHidden = true
        self.declineTransactionView.progress = 0
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
        UIView.animate(withDuration: 0.0, animations: {
                self.declineTransactionView.layoutIfNeeded()
            }, completion: { finished in
                if self.transactionAmount != 0 {
                    self.declineTransactionView.progress = progress
                }
                UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveLinear], animations: {
                    self.declineTransactionView.layoutIfNeeded()
                }, completion: { finished in
                    if self.transactionAmount != 0{
                       self.transactionAmountLabel.isHidden = false
                    }
                    print("animation completed")
                })
            })
    }

}
