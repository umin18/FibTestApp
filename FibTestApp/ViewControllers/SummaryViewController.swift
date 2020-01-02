//
//  SummaryViewController.swift
//  FibTestApp
//
//  Created by Eric Cha on 1/2/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    // Obtain all the results from prior fibonacci calculations
    var data: [(Int, TimeInterval)] = FibonacciModel.shared.results
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: TableView methods
extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SummaryTableViewCell else { return UITableViewCell() }
        let fib = data[indexPath.row]
        cell.nLabel?.text = "\(fib.0)"
        cell.timeLabel?.text = "\(fib.1) milliseconds"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
