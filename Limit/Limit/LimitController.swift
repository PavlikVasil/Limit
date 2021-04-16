//
//  LimitController.swift
//  Limit
//
//  Created by Павел on 12.04.2021.
//

import UIKit

final class LimitController: UIViewController {

    var transactionAmount: String?
    var topUpAmount: String?
    var limit: String?
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("BACK", for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        backButton.titleLabel?.font = UIFont(name: "GT America Mono", size: 12)
        backButton.titleLabel?.adjustsFontSizeToFitWidth = true
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return backButton
    }()
    private lazy var monthlyLimitsLabel: UILabel = {
        let monthlyLimitsLabel = UILabel()
        monthlyLimitsLabel.translatesAutoresizingMaskIntoConstraints = false
        monthlyLimitsLabel.text = "Monthly limits"
        monthlyLimitsLabel.font = UIFont(name: "Suisse Intl", size: 32)
        monthlyLimitsLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        return monthlyLimitsLabel
    }()
    private lazy var transactionLimitLabel: UILabel = {
        let transactionLimitLabel = UILabel()
        transactionLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionLimitLabel.text = "Transaction limit:"
        transactionLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        transactionLimitLabel.textColor = #colorLiteral(red: 0.5215686275, green: 0.5294117647, blue: 0.5411764706, alpha: 1)
        return transactionLimitLabel
    }()
    private lazy var transactionView: UIView = {
        let transactionView = UIView()
        transactionView.translatesAutoresizingMaskIntoConstraints = false
        transactionView.layer.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.8196078431, alpha: 1)
        transactionView.frame.size.width = UIScreen.main.bounds.width
        return transactionView
    }()
    private lazy var upperTransactionLimitLabel: UILabel = {
        let upperTransactionLimitLabel = UILabel()
        upperTransactionLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        upperTransactionLimitLabel.text = "\(limit!.doubleValue.currency)"
        upperTransactionLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        upperTransactionLimitLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        upperTransactionLimitLabel.layer.zPosition = 2
        return upperTransactionLimitLabel
    }()
    var declineTransactionView: UIProgressView!
    var transactionAmountLabel: UILabel!
    
    private lazy var topUpLimitLabel: UILabel = {
        let topUpLimitLabel = UILabel()
        topUpLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        topUpLimitLabel.text = "Top-up limit:"
        topUpLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        topUpLimitLabel.textColor = #colorLiteral(red: 0.5215686275, green: 0.5294117647, blue: 0.5411764706, alpha: 1)
        return topUpLimitLabel
    }()
    private lazy var topUpView: UIView = {
        let topUpView = UIView()
        topUpView.translatesAutoresizingMaskIntoConstraints = false
        topUpView.layer.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.8196078431, alpha: 1)
        topUpView.frame.size.width = UIScreen.main.bounds.width
        return topUpView
    }()
    private lazy var upperTopUpLimitLabel: UILabel = {
        let upperTopUpLimitLabel = UILabel()
        upperTopUpLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        upperTopUpLimitLabel.text = "\(limit!.doubleValue.currency)"
        upperTopUpLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        upperTopUpLimitLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        upperTopUpLimitLabel.layer.zPosition = 2
        return upperTopUpLimitLabel
    }()
    var declineTopUpView: UIProgressView!
    var topUpAmountLabel: UILabel!
    
    private lazy var renewalLabel: UILabel = {
        let renewalLabel = UILabel()
        renewalLabel.translatesAutoresizingMaskIntoConstraints = false
        renewalLabel.text = "Next Renewal: 31/10/2021"
        renewalLabel.font = UIFont(name: "Suisse Intl", size: 24)
        renewalLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        return renewalLabel
    }()
    private lazy var increaseTo5Button: UIButton = {
        let increaseTo5Button = UIButton()
        increaseTo5Button.translatesAutoresizingMaskIntoConstraints = false
        increaseTo5Button.backgroundColor = .white
        return increaseTo5Button
    }()
    private lazy var increaseTo5Label: UILabel = {
        let increaseTo5Label = UILabel()
        increaseTo5Label.translatesAutoresizingMaskIntoConstraints = false
        increaseTo5Label.text = "INCREASE LIMIT TO £5,000"
        increaseTo5Label.font = UIFont(name: "GT America Mono", size: 12)
        increaseTo5Label.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        return increaseTo5Label
    }()
    private lazy var vector5Image: UIImageView = {
        let vector5Image = UIImageView()
        vector5Image.translatesAutoresizingMaskIntoConstraints = false
        vector5Image.image = UIImage(named: "Vector")
        return vector5Image
    }()
    private lazy var increaseTo50Button: UIButton = {
        let increaseTo50Button = UIButton()
        increaseTo50Button.translatesAutoresizingMaskIntoConstraints = false
        increaseTo50Button.backgroundColor = .white
        return increaseTo50Button
    }()
    private lazy var increaseTo50Label: UILabel = {
        let increaseTo50Label = UILabel()
        increaseTo50Label.translatesAutoresizingMaskIntoConstraints = false
        increaseTo50Label.text = "INCREASE LIMIT TO £50,000"
        increaseTo50Label.font = UIFont(name: "GT America Mono", size: 12)
        increaseTo50Label.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        return increaseTo50Label
    }()
    private lazy var vector50Image: UIImageView = {
        let vector50Image = UIImageView()
        vector50Image.translatesAutoresizingMaskIntoConstraints = false
        vector50Image.image = UIImage(named: "Vector")
        return vector50Image
    }()
    
    var declineTransactionViewWidthConstraint: NSLayoutConstraint!
    var declineTopUpViewWidthConstraint: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        view.addSubview(backButton)
        view.addSubview(monthlyLimitsLabel)
        view.addSubview(transactionLimitLabel)
        view.addSubview(transactionView)
        transactionView.addSubview(upperTransactionLimitLabel)
        
        declineTransactionView = UIProgressView()
        declineTransactionView.translatesAutoresizingMaskIntoConstraints = false
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
        declineTransactionView.tintColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
        transactionView.addSubview(declineTransactionView)
    
        transactionAmountLabel = UILabel()
        transactionAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        transactionAmountLabel.text = "\(transactionAmount!.doubleValue.currency)"
        transactionAmountLabel.font = UIFont(name: "Suisse Intl", size: 24)
        transactionAmountLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        transactionAmountLabel.layer.zPosition = 2
        if transactionAmount != limit{
            self.transactionView.addSubview(transactionAmountLabel)
            
            let transactionAmountValue = Double(transactionAmount!)
            let limitValue = Double(limit!)
            //let result: CGFloat = CGFloat(transactionAmountValue!/limitValue!)
            let transactionViewWidth = transactionView.frame.size.width
            
            let progress = CGFloat(1 - Float(transactionAmountValue!/limitValue!))
            let actualWidth = transactionViewWidth * progress
            let leftWidth = UIScreen.main.bounds.width - actualWidth
            let progressWidth = UIScreen.main.bounds.width - leftWidth
            print("leftWidth", leftWidth)
            print("progressWidth", progressWidth)
            
            let constraint = transactionAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor , constant: -progressWidth - 8)
            
            let constraintLeft = transactionAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 25)
            
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
        
        view.addSubview(topUpLimitLabel)
        view.addSubview(topUpView)
        topUpView.addSubview(upperTopUpLimitLabel)
        
        declineTopUpView = UIProgressView()
        declineTopUpView.translatesAutoresizingMaskIntoConstraints = false
        declineTopUpView.tintColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9098039216, alpha: 1)
        topUpView.addSubview(declineTopUpView)
        
        topUpAmountLabel = UILabel()
        topUpAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        topUpAmountLabel.text = "\(topUpAmount!.doubleValue.currency)"
        topUpAmountLabel.font = UIFont(name: "Suisse Intl", size: 24)
        topUpAmountLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        topUpAmountLabel.layer.zPosition = 2
        if topUpAmount != limit{
            topUpView.addSubview(topUpAmountLabel)
            let topUpAmountValue = Double(topUpAmount!)
            let limitValue = Double(limit!)
            let topUpViewWidth = topUpView.frame.size.width
            let progress = CGFloat(1 - Float(topUpAmountValue!/limitValue!))
            let actualWidth = topUpViewWidth * progress
            let leftWidth = UIScreen.main.bounds.width - actualWidth
            let progressWidth = UIScreen.main.bounds.width - leftWidth
            print("leftWidth", leftWidth)
            let constraint = topUpAmountLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor , constant: -progressWidth - 8)
            
            let constraintLeft = topUpAmountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 25)
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
        if Int(topUpAmount ?? "0") == 0{
            topUpAmountLabel.isHidden = true
            topUpView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
        if Int(transactionAmount ?? "0") == 0{
            transactionView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            transactionAmountLabel.isHidden = true
        }
        view.addSubview(renewalLabel)
        view.addSubview(increaseTo5Button)
        increaseTo5Button.addSubview(increaseTo5Label)
        increaseTo5Button.addSubview(vector5Image)
        view.addSubview(increaseTo50Button)
        increaseTo50Button.addSubview(increaseTo50Label)
        increaseTo50Button.addSubview(vector50Image)

        
        let limitValue = Double(limit!)
        switch limitValue{
        case _ where limitValue! < 5000:
            print("buttons avaliable")
        case _ where limitValue! < 50000:
            increaseTo5Button.isHidden = true
            increaseTo5Button.isUserInteractionEnabled = false
        default:
            increaseTo5Button.isHidden = true
            increaseTo5Button.isUserInteractionEnabled = false
            increaseTo50Button.isHidden = true
            increaseTo50Button.isUserInteractionEnabled = false
        }

        
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 31),
            backButton.heightAnchor.constraint(equalToConstant: 16),
            
            monthlyLimitsLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            //monthlyLimitsLabel.bottomAnchor.constraint(greaterThanOrEqualTo: transactionLimitLabel.topAnchor, constant: -12),
            monthlyLimitsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            monthlyLimitsLabel.widthAnchor.constraint(equalToConstant: 312),
            monthlyLimitsLabel.heightAnchor.constraint(equalToConstant: 38),
            
            transactionLimitLabel.topAnchor.constraint(equalTo: monthlyLimitsLabel.bottomAnchor, constant: 32),
            //transactionConstraint,
            transactionLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            transactionLimitLabel.widthAnchor.constraint(equalToConstant: 187),
            transactionLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: transactionLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            transactionView.topAnchor.constraint(equalTo: transactionLimitLabel.bottomAnchor, constant: 16),
            transactionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transactionView.heightAnchor.constraint(equalToConstant: 78),
            
            upperTransactionLimitLabel.bottomAnchor.constraint(equalTo: transactionView.bottomAnchor, constant: -8),
            upperTransactionLimitLabel.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor,constant: -24),
            upperTransactionLimitLabel.heightAnchor.constraint(equalToConstant: 31),
            
            declineTransactionView.topAnchor.constraint(equalTo: transactionView.topAnchor),
            declineTransactionView.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor),
            declineTransactionView.bottomAnchor.constraint(equalTo: transactionView.bottomAnchor),
            declineTransactionView.leadingAnchor.constraint(equalTo: transactionView.leadingAnchor),
            
            topUpLimitLabel.topAnchor.constraint(equalTo: transactionView.bottomAnchor, constant: 32),
            topUpLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            topUpLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: topUpLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            topUpView.topAnchor.constraint(equalTo: topUpLimitLabel.bottomAnchor, constant: 16),
            topUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topUpView.heightAnchor.constraint(equalToConstant: 78),
            
            upperTopUpLimitLabel.bottomAnchor.constraint(equalTo: topUpView.bottomAnchor, constant: -8),
            upperTopUpLimitLabel.trailingAnchor.constraint(equalTo: topUpView.trailingAnchor,constant: -24),
            upperTopUpLimitLabel.heightAnchor.constraint(equalToConstant: 31),
            
            declineTopUpView.topAnchor.constraint(equalTo: topUpView.topAnchor),
            declineTopUpView.trailingAnchor.constraint(equalTo: topUpView.trailingAnchor),
            declineTopUpView.bottomAnchor.constraint(equalTo: topUpView.bottomAnchor),
            declineTopUpView.leadingAnchor.constraint(equalTo: topUpView.leadingAnchor),
            
            renewalLabel.topAnchor.constraint(equalTo: topUpView.bottomAnchor, constant: 32),
            renewalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            renewalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 69),
            renewalLabel.heightAnchor.constraint(lessThanOrEqualTo: renewalLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            increaseTo5Button.topAnchor.constraint(lessThanOrEqualTo: renewalLabel.bottomAnchor, constant: 70),
            increaseTo5Button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            increaseTo5Button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            increaseTo5Button.heightAnchor.constraint(lessThanOrEqualTo: increaseTo50Button.heightAnchor, multiplier: 0.1, constant: 80),
            
            increaseTo5Label.centerYAnchor.constraint(equalTo: increaseTo5Button.centerYAnchor),
            increaseTo5Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            increaseTo5Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            
            increaseTo50Button.topAnchor.constraint(equalTo: increaseTo5Button.bottomAnchor),
            increaseTo50Button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            increaseTo50Button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            increaseTo50Button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            increaseTo50Button.heightAnchor.constraint(lessThanOrEqualTo: increaseTo5Button.heightAnchor, multiplier: 0.1, constant: 80),
            
            increaseTo50Label.centerYAnchor.constraint(equalTo: increaseTo50Button.centerYAnchor),
            increaseTo50Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            increaseTo50Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            
            vector5Image.trailingAnchor.constraint(equalTo: increaseTo5Button.trailingAnchor, constant: -25.93),
            vector5Image.centerYAnchor.constraint(equalTo: increaseTo5Button.centerYAnchor),
            vector5Image.widthAnchor.constraint(equalToConstant: 13.07),
            vector5Image.heightAnchor.constraint(equalToConstant: 8.95),
            
            vector50Image.trailingAnchor.constraint(equalTo: increaseTo50Button.trailingAnchor, constant: -25.93),
            vector50Image.centerYAnchor.constraint(equalTo: increaseTo50Button.centerYAnchor),
            vector50Image.widthAnchor.constraint(equalToConstant: 13.07),
            vector50Image.heightAnchor.constraint(equalToConstant: 8.95)
        ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //animate()
    }
    
    
    func animate() {
        let transactionAmountValue = Double(self.transactionAmount!)
        let limitValue = Double(self.limit!)
        let progress = 1 - Float(transactionAmountValue!/limitValue!)
        print("progress", progress)
        
        let topUpAmountValue = Double(self.topUpAmount!)
        let progressTopUp = 1 - Float(topUpAmountValue!/limitValue!)
        transactionAmountLabel.isHidden = true
        topUpAmountLabel.isHidden = true
        self.declineTransactionView.progress = 0
        self.declineTopUpView.progress = 0
        declineTransactionView.semanticContentAttribute = .forceRightToLeft
        declineTopUpView.semanticContentAttribute = .forceRightToLeft
        UIView.animate(withDuration: 0.0, animations: {
                self.declineTransactionView.layoutIfNeeded()
                self.declineTopUpView.layoutIfNeeded()
            }, completion: { finished in
                if transactionAmountValue != 0 {
                    self.declineTransactionView.progress = progress
                }
                if topUpAmountValue != 0{
                    self.declineTopUpView.progress = progressTopUp
                }
                UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveLinear], animations: {
                    self.declineTransactionView.layoutIfNeeded()
                    self.declineTopUpView.layoutIfNeeded()
                }, completion: { finished in
                    if Int(self.transactionAmount ?? "0") != 0{
                        self.transactionAmountLabel.isHidden = false
                    }
                    if Int(self.topUpAmount ?? "0") != 0{
                        self.topUpAmountLabel.isHidden = false
                    }
                    print("animation completed")
                })
            })
    }
    
    
    @objc func backTapped(){
        self.dismiss(animated: true)
    }
}


//MARK: -Number Formatter

extension NumberFormatter {
    convenience init(style: Style) {
        self.init()
        self.numberStyle = style
    }
}

extension Formatter {
    static let currency = NumberFormatter(style: .currency)
}

extension FloatingPoint {
    var currency: String {
        Formatter.currency.locale = Locale(identifier: "en_UK")
        return Formatter.currency.string(for: self) ?? ""
    }
}


