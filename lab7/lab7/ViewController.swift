//
//  ViewController.swift
//  lab7
//
//  Created by Nicole Milmine on 2025-02-19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var tableData: [String] = []
    
    @IBAction func timesTable(_ sender: UIButton) {
        guard let numStr = textField.text, let num = Int(numStr) else { return }
        tableData = (1...10).map {
            ("\(num) x \($0) = \(num * $0)")
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
