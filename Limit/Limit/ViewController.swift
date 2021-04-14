//
//  ViewController.swift
//  Limit
//
//  Created by Павел on 12.04.2021.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    var cells = ["Without verification", "Partial verification", "Full verification"]

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    
    var without = ["5.43", "0", "129.00"]
    var partial = ["5000.00", "100.43", "5000.00"]
    var full = ["22135.43", "100.43", "50000.00"]

    
}


//MARK: -Table View

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let limitController = LimitController()
        limitController.modalPresentationStyle = .fullScreen
        
        
        switch indexPath.row{
            case 0:
                limitController.transactionAmount = self.without[0]
                limitController.topUpAmount = self.without[1]
                limitController.limit = self.without[2]
            case 1:
                limitController.transactionAmount = self.partial[0]
                limitController.topUpAmount = self.partial[1]
                limitController.limit = self.partial[2]
            case 2:
                limitController.transactionAmount = self.full[0]
                limitController.topUpAmount = self.full[1]
                limitController.limit = self.full[2]
            default:
                break
            }
        
        self.present(limitController, animated: true)
        
    }
    
    
    
    
}

