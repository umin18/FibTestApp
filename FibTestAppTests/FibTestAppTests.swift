//
//  FibTestAppTests.swift
//  FibTestAppTests
//
//  Created by Eric Cha on 1/3/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import XCTest
@testable import FibTestApp

class FibTestAppTests: XCTestCase {
    var vc: ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(identifier: "ViewController") as? ViewController
        _ = vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vc = nil
    }

    func testFibonacci() {
        vc.calculateFibonacci(5)
        let result = vc.fibArr.last
        XCTAssertEqual(result, 5, "Fibonnaci(5) = 5")
    }
    
    func testFibonacciZero() {
        vc.calculateFibonacci(0)
        let result = vc.fibArr.last
        XCTAssertEqual(result, 0, "Fibonnaci(0) = 0")
    }
    
    func testFibonacciOverflow() {
        vc.calculateFibonacci(95)
        let result = vc.fibArr.count
        XCTAssertEqual(result, 0)
    }

    func testPerformanceExample() {
        measure {
            vc.calculateFibonacci(93)
        }
    }

}
