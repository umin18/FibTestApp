//
//  FibonacciModel.swift
//  FibTestApp
//
//  Created by Eric Cha on 1/2/20.
//  Copyright © 2020 Eric Cha. All rights reserved.
//

import Foundation

class FibonacciModel {
    
    // Create singleton object for Fibonacci Model
    static var shared = FibonacciModel()
    var results : [(Int, TimeInterval)] = []
    
}
