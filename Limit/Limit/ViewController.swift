//
//  ViewController.swift
//  Limit
//
//  Created by Павел on 12.04.2021.
//

import UIKit

final class ViewController: UIViewController {

    var values = Values()
    
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
        let limitController = LimitController()
        limitController.modalPresentationStyle = .fullScreen
        
        switch indexPath.row{
            case 0:
                limitController.transactionAmount = values.transactionWithout
                limitController.topUpAmount = values.topUpWithout
                limitController.limit = values.limitWithout
            case 1:
                limitController.transactionAmount = values.transactionPartial
                limitController.topUpAmount = values.topUpPartial
                limitController.limit = values.limitPartial
            case 2:
                limitController.transactionAmount = values.transactionFull
                limitController.topUpAmount = values.topUpFull
                limitController.limit = values.limitFull
            default:
                break
        }
        
        self.present(limitController, animated: true)
    }
}

