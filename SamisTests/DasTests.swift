//
//  DasTests.swift
//  SamisTests
//
//  Created by Samuel Ribeiro de Freitas on 14/03/24.
//

import XCTest
@testable import Samis

final class DasTests: XCTestCase {
    
    func testCalculateTaxWithDefaultIsNational() {
        
        let das = Das(amount: 100)
        
        let expectedValue = 6.5
        let taxValue = das.calculateTax()
        
        XCTAssertEqual(taxValue, expectedValue)
        
    }
    
    func testCalculateTax() {
        
        let das = Das(amount: 100, isNational: false)
        
        let expectedValue = 3.05
        let taxValue = das.calculateTax()
        
        XCTAssertEqual(taxValue, expectedValue)
        
    }
    
}
