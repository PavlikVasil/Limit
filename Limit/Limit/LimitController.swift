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
    
    
    init(transactionAmount: Double, topUpAmount: Double, limit: Double){
        self.transactionAmount = transactionAmount
        self.topUpAmount = topUpAmount
        self.limit = limit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private lazy var declineTransactionView: DeclineTransactionView = {
        let declineTransactionView = DeclineTransactionView(transactionAmount: transactionAmount, limit: limit)
        declineTransactionView.translatesAutoresizingMaskIntoConstraints = false
        declineTransactionView.layer.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.8196078431, alpha: 1)
        return declineTransactionView
    }()
    private lazy var topUpLimitLabel: UILabel = {
        let topUpLimitLabel = UILabel()
        topUpLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        topUpLimitLabel.text = "Top-up limit:"
        topUpLimitLabel.font = UIFont(name: "Suisse Intl", size: 24)
        topUpLimitLabel.textColor = #colorLiteral(red: 0.5215686275, green: 0.5294117647, blue: 0.5411764706, alpha: 1)
        return topUpLimitLabel
    }()
    private lazy var declineTopUpView: DeclineTransactionView = {
        let declineTopUpView = DeclineTransactionView(transactionAmount: topUpAmount, limit: limit)
        declineTopUpView.translatesAutoresizingMaskIntoConstraints = false
        declineTopUpView.layer.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.8196078431, alpha: 1)
        return declineTopUpView
    }()
    private lazy var renewalLabel: UILabel = {
        let renewalLabel = UILabel()
        renewalLabel.translatesAutoresizingMaskIntoConstraints = false
        renewalLabel.text = "Next Renewal: 31/10/2021"
        renewalLabel.font = UIFont(name: "Suisse Intl", size: 24)
        renewalLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        return renewalLabel
    }()
    private lazy var increaseTo5Button: CustomButton = {
        let increaseTo5Button = CustomButton()
        increaseTo5Button.setTitle("INCREASE LIMIT TO £5,000", for: .normal)
        return increaseTo5Button
    }()
    private lazy var increaseTo50Button: CustomButton = {
        let increaseTo50Button = CustomButton()
        increaseTo50Button.setTitle("INCREASE LIMIT TO £50,000", for: .normal)
        return increaseTo50Button
    }()
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        view.addSubview(backButton)
        view.addSubview(monthlyLimitsLabel)
        view.addSubview(transactionLimitLabel)
        view.addSubview(declineTransactionView)
        view.addSubview(topUpLimitLabel)
        view.addSubview(declineTopUpView)
        view.addSubview(renewalLabel)
        view.addSubview(increaseTo5Button)
        increaseTo5Button.setup()
        view.addSubview(increaseTo50Button)
        increaseTo50Button.setup()
        
        if transactionAmount == 0{
            declineTransactionView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
        if topUpAmount == 0{
            declineTopUpView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }

        
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
            monthlyLimitsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            monthlyLimitsLabel.widthAnchor.constraint(equalToConstant: 312),
            monthlyLimitsLabel.heightAnchor.constraint(equalToConstant: 38),
            
            transactionLimitLabel.topAnchor.constraint(equalTo: monthlyLimitsLabel.bottomAnchor, constant: 32),
            transactionLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            transactionLimitLabel.widthAnchor.constraint(equalToConstant: 187),
            transactionLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: transactionLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            declineTransactionView.topAnchor.constraint(equalTo: transactionLimitLabel.bottomAnchor, constant: 16),
            declineTransactionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            declineTransactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            declineTransactionView.heightAnchor.constraint(equalToConstant: 78),
            
            topUpLimitLabel.topAnchor.constraint(equalTo: declineTransactionView.bottomAnchor, constant: 32),
            topUpLimitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            topUpLimitLabel.heightAnchor.constraint(lessThanOrEqualTo: topUpLimitLabel.heightAnchor, multiplier: 0.5, constant: 31),
            
            declineTopUpView.topAnchor.constraint(equalTo: topUpLimitLabel.bottomAnchor, constant: 16),
            declineTopUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            declineTopUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            declineTopUpView.heightAnchor.constraint(equalToConstant: 78),
            
            renewalLabel.topAnchor.constraint(equalTo: declineTopUpView.bottomAnchor, constant: 32),
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.declineTransactionView.animate()
            self.declineTopUpView.animate()
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


