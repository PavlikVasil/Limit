//
//  LimitController.swift
//  Limit
//
//  Created by Павел on 12.04.2021.
//

import UIKit

final class LimitController: UIViewController {

    var transactionAmount: Double
    var topUpAmount: Double
    var limit: Double
    
    
    
    init(transactionAmount: Double,topUpAmount: Double, limit: Double){
        self.transactionAmount = transactionAmount
        self.topUpAmount = topUpAmount
        self.limit = limit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var declineTransactionView: UIView = {
        let declineTransactionView = DeclineTransactionView(transactionAmount: transactionAmount, limit: limit, transactionView: transactionView, frame: CGRect.zero )
        declineTransactionView.translatesAutoresizingMaskIntoConstraints = false
        return declineTransactionView
    }()
    private lazy var declineTopUpView: UIView = {
        let declineTopUpView = DeclineTopUpView(topUpAmount: topUpAmount, limit: limit, topUpView: topUpView, frame: CGRect.zero)
        declineTopUpView.translatesAutoresizingMaskIntoConstraints = false
        return declineTopUpView
    }()
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
        increaseTo5Button.setTitle("INCREASE LIMIT TO £5,000", for: .normal)
        increaseTo5Button.titleLabel?.font = UIFont(name: "GT America Mono", size: 12)
        increaseTo5Button.setTitleColor(#colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        let image = UIImage(named: "Vector")
        increaseTo5Button.setImage(image, for: .normal)
        increaseTo5Button.imageView?.contentMode = .right
        increaseTo5Button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        increaseTo5Button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        return increaseTo5Button
    }()
    private lazy var increaseTo50Button: UIButton = {
        let increaseTo50Button = UIButton()
        increaseTo50Button.translatesAutoresizingMaskIntoConstraints = false
        increaseTo50Button.backgroundColor = .white
        increaseTo50Button.setTitle("INCREASE LIMIT TO £5,0000", for: .normal)
        increaseTo50Button.titleLabel?.font = UIFont(name: "GT America Mono", size: 12)
        increaseTo50Button.setTitleColor(#colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        let image = UIImage(named: "Vector")
        increaseTo50Button.setImage(image, for: .normal)
        increaseTo50Button.imageView?.contentMode = .right
        increaseTo50Button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        increaseTo50Button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        return increaseTo50Button
    }()
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        view.addSubview(backButton)
        view.addSubview(monthlyLimitsLabel)
        view.addSubview(transactionLimitLabel)
        view.addSubview(transactionView)
        view.addSubview(declineTransactionView)
        view.addSubview(topUpLimitLabel)
        view.addSubview(topUpView)
        view.addSubview(declineTopUpView)
        view.addSubview(renewalLabel)
        view.addSubview(increaseTo5Button)
        view.addSubview(increaseTo50Button)
        
        if transactionAmount == 0{
            transactionView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
        if topUpAmount == 0{
            topUpView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
    
        increaseTo5Button.imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.93).isActive = true
        increaseTo5Button.titleLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        increaseTo5Button.imageView?.centerYAnchor.constraint(equalTo: increaseTo5Button.centerYAnchor).isActive = true
        increaseTo50Button.imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.93).isActive = true
        increaseTo50Button.titleLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        increaseTo50Button.imageView?.centerYAnchor.constraint(equalTo: increaseTo50Button.centerYAnchor).isActive = true

        
        let limitValue = Double(limit)
        switch limitValue{
        case _ where limitValue < 5000:
            print("buttons avaliable")
        case _ where limitValue < 50000:
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
            transactionLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            transactionLimitLabel.widthAnchor.constraint(equalToConstant: 187),
            transactionLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: transactionLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            transactionView.topAnchor.constraint(equalTo: transactionLimitLabel.bottomAnchor, constant: 16),
            transactionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transactionView.heightAnchor.constraint(equalToConstant: 78),
            
            declineTransactionView.topAnchor.constraint(equalTo: transactionView.topAnchor),
            declineTransactionView.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor),
            declineTransactionView.bottomAnchor.constraint(equalTo: transactionView.bottomAnchor),
            declineTransactionView.leadingAnchor.constraint(equalTo: transactionView.leadingAnchor),
            declineTransactionView.heightAnchor.constraint(equalToConstant: 78),
            
            topUpLimitLabel.topAnchor.constraint(equalTo: transactionView.bottomAnchor, constant: 32),
            topUpLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            topUpLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: topUpLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            topUpView.topAnchor.constraint(equalTo: topUpLimitLabel.bottomAnchor, constant: 16),
            topUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topUpView.heightAnchor.constraint(equalToConstant: 78),
            
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
            
            increaseTo50Button.topAnchor.constraint(equalTo: increaseTo5Button.bottomAnchor),
            increaseTo50Button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            increaseTo50Button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            increaseTo50Button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            increaseTo50Button.heightAnchor.constraint(lessThanOrEqualTo: increaseTo5Button.heightAnchor, multiplier: 0.1, constant: 80),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


