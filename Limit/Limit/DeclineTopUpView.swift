//
//  DeclineTopUpView.swift
//  Limit
//
//  Created by Павел on 19.04.2021.
//

import UIKit

class DeclineTopUpView: UIView {

    var topUpAmount: Double
    var limit: Double
    var topUpView: UIView
    
    init(topUpAmount: Double, limit: Double, topUpView: UIView, frame: CGRect){
        self.topUpAmount = topUpAmount
        self.limit = limit
        self.topUpView = topUpView
        super.init(frame: frame)
        setup()
        animate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var upperTopUpLimitLabel: UILabel = {
        let upperTopUpLimitLabel = UILabel()
        upperTopUpLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        upperTopUpLimitLabel.text = "\(String(limit).doubleValue.currency)"
        upperTopUpLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        upperTopUpLimitLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        upperTopUpLimitLabel.layer.zPosition = 2
        return upperTopUpLimitLabel
    }()
    private lazy var declineTopUpView: UIProgressView = {
        let declineTopUpView = UIProgressView()
        declineTopUpView.translatesAutoresizingMaskIntoConstraints = false
        declineTopUpView.tintColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
        return declineTopUpView
    }()
    private lazy var topUpAmountLabel: UILabel = {
        let topUpAmountLabel = UILabel()
        topUpAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        topUpAmountLabel.text = "\(String(topUpAmount).doubleValue.currency)"
        topUpAmountLabel.font = UIFont(name: "Suisse Intl", size: 24)
        topUpAmountLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        topUpAmountLabel.layer.zPosition = 2
        return topUpAmountLabel
    }()
    
    func setup(){
        topUpView.addSubview(declineTopUpView)
        topUpView.addSubview(upperTopUpLimitLabel)
        if topUpAmount == 0{
            topUpAmountLabel.isHidden = true
        }
        if topUpAmount != limit{
            topUpView.addSubview(topUpAmountLabel)
            let topUpAmountValue = Double(topUpAmount)
            let limitValue = Double(limit)
            let topUpViewWidth = topUpView.frame.size.width
            let progress = CGFloat(1 - Float(topUpAmountValue/limitValue))
            let actualWidth = topUpViewWidth * progress
            let leftWidth = UIScreen.main.bounds.width - actualWidth
            let progressWidth = UIScreen.main.bounds.width - leftWidth
            print("leftWidth", leftWidth)
            let constraint = topUpAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: topUpView.trailingAnchor , constant: -progressWidth - 8)
            
            let constraintLeft = topUpAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: topUpView.leadingAnchor, constant: 25)
            if leftWidth > topUpAmountLabel.intrinsicContentSize.width + 25{
                constraint.isActive = true
                constraintLeft.isActive = false
            } else {
                constraint.isActive = false
                constraintLeft.isActive = true
            }
            
            NSLayoutConstraint.activate([
                topUpAmountLabel.topAnchor.constraint(equalTo: topUpView.topAnchor, constant: 8),
                topUpAmountLabel.heightAnchor.constraint(equalToConstant: 31),
            ])
        }
        
        NSLayoutConstraint.activate([
            upperTopUpLimitLabel.bottomAnchor.constraint(equalTo: topUpView.bottomAnchor, constant: -8),
            upperTopUpLimitLabel.trailingAnchor.constraint(equalTo: topUpView.trailingAnchor,constant: -24),
            upperTopUpLimitLabel.heightAnchor.constraint(equalToConstant: 31),
            
            declineTopUpView.topAnchor.constraint(equalTo: topUpView.topAnchor),
            declineTopUpView.trailingAnchor.constraint(equalTo: topUpView.trailingAnchor),
            declineTopUpView.bottomAnchor.constraint(equalTo: topUpView.bottomAnchor),
            declineTopUpView.leadingAnchor.constraint(equalTo: topUpView.leadingAnchor),
            declineTopUpView.heightAnchor.constraint(equalToConstant: 78),
        ])
    }
    
    func animate() {
        let progressTopUp = 1 - Float(topUpAmount/limit)
        topUpAmountLabel.isHidden = true
        self.declineTopUpView.progress = 0
        declineTopUpView.semanticContentAttribute = .forceRightToLeft
        UIView.animate(withDuration: 0.0, animations: {
                self.declineTopUpView.layoutIfNeeded()
            }, completion: { finished in
                if self.topUpAmount != 0{
                    self.declineTopUpView.progress = progressTopUp
                }
                UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveLinear], animations: {
                    self.declineTopUpView.layoutIfNeeded()
                }, completion: { finished in
                    if self.topUpAmount != 0{
                        self.topUpAmountLabel.isHidden = false
                    }
                    print("animation completed")
                })
            })
    }
    
    
    
    
    
    
    
    
    
    
    
}
