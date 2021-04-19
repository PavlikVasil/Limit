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
        var limitController: LimitController?
        switch indexPath.row{
            case 0:
                limitController = LimitController(transactionAmount: 75.43, topUpAmount: 0, limit: 120.00)
                limitController!.modalPresentationStyle = .fullScreen
            case 1:
                limitController = LimitController(transactionAmount: 5000.00, topUpAmount: 1000.43, limit: 5000.00)
                limitController!.modalPresentationStyle = .fullScreen
            case 2:
                limitController = LimitController(transactionAmount: 22135.43, topUpAmount: 100.43, limit: 50000.00)
                limitController!.modalPresentationStyle = .fullScreen
            default:
                break
        }
        self.present(limitController!, animated: true)
    }
}

