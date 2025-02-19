//
//  ViewController.swift
//  lab7
//
//  Created by Nicole Milmine on 2025-02-19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var tableData = [""]
    
    @IBAction func timesTable(_ sender: UIButton) {
        let number = Int(textField.text ?? "1")
        tableData = (1...10).map {
            ("\(number ?? 1) x \($0) = \((number ?? 1) * $0)")
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        textField.keyboardType = .numberPad
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }

}
