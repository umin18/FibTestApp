//
//  ViewController.swift
//  FibTestApp
//
//  Created by Eric Cha on 1/2/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InputTextFieldProtocol{

    @IBOutlet weak var inputTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calculationTimeLabel: UILabel!
    
    private let maxValue32 = 47
    private let maxValue64 = 93
    
    var fibArr: [UInt] = []
    var fibOf: Int?
    var timeExec: Double?
    let inputHandler = InputDelegateHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTf.delegate = inputHandler
        inputHandler.delegate = self
        inputTf.addDoneButtonOnKeyboard()
    }

    // Navigation bar button to push summary page to view
    @IBAction func showSummary(_ sender: UIBarButtonItem) {
        guard let summaryVC = storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController else { return }
        navigationController?.pushViewController(summaryVC, animated: true)
    }
    
    // Show warning for invalid input
    func maxNAlert() {
        let alert = UIAlertController(title: "n is too large", message: "Please use a smaller number", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Function for Calculation of Fibonacci
    func calculateFibonacci(_ number: Int) {
        // Prevent users from entering n value that is too large to calculate depeding on device cpu architecture
        if MemoryLayout<Int>.size == MemoryLayout<Int32>.size && number > maxValue32 {
            maxNAlert()
            return
        } else if MemoryLayout<Int>.size == MemoryLayout<Int64>.size && number > maxValue64{
            maxNAlert()
            return
        }
        // clear previous array values for new f(n) calculation
        fibArr.removeAll(keepingCapacity: false)
        
        // Start recording time
        let start = DispatchTime.now()
        
        // Calculate Fibonacci for 0 ... n
        for i in 0...number {
            if i < 2 {
                fibArr.append(UInt(i))
            } else {
                let lastIndex = fibArr.count - 1
                fibArr.append(fibArr[lastIndex-1] + fibArr[lastIndex])
            }
        }
        
        // Stop recording time
        let end = DispatchTime.now()
        // Measure time for Fibonacci calculations
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        let timeInterval = Double(nanoTime) / 1_000_000 // Technically could overflow for long running tests
        
        FibonacciModel.shared.results.append((number, timeInterval))
        fibOf = number
        timeExec = timeInterval
        
        calculationTimeLabel.text = "Fibonacci(\(fibOf!)) in \(timeExec!) microseconds"
        tableView.reloadData()
    }
}

//MARK: TableView methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ViewTableViewCell else { return UITableViewCell() }
        cell.nLabel?.text = "\(indexPath.row)"
        cell.resultLabel?.text = "\(fibArr[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fibArr.count
    }
}

