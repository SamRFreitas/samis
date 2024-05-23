//
//  VrauTests.swift
//  SamisTests
//
//  Created by Samuel Ribeiro de Freitas on 19/03/24.
//

import XCTest
@testable import Samis

struct MockDasCalculator: DasCalculatorProtocol {
    func calculate(das: Das) -> Double {
        return 100.0 // Valor fixo para o teste
    }
}

struct MockInssCalculator: InssCalculatorProtocol {
    func calculate(inss: Inss) -> Double {
        return 100.0 // Valor fixo para o teste
    }
}

struct MockIrrfCalculator: IrrfCalculatorProtocol {
    func calculate(inss: Inss) -> Double {
        return 100.0 // Valor fixo para o teste
    }
}

struct MockProLaboreCalculator: ProLaboreCalculatorProtocol {
    func calculate(vrau: Vrau) -> Double {
        return 1000.0 // Valor fixo para o teste
    }
}

final class VrauTests: XCTestCase {

    
    func testGetDla() {
        
        let vrau = Vrau(income: 3950, prolaborePercentage: 11, isNational: true)
        let dla = vrau.calculateDla()
        let expectedDla = 2032.87
        
        XCTAssertEqual(dla, expectedDla)
    }
    
    func testGetDlaMock() {
        
        Vrau.calculateDas = MockDasCalculator()
        Vrau.calculateInss = MockInssCalculator()
        Vrau.calculateIrrf = MockIrrfCalculator()
        Vrau.calculateProLabore = MockProLaboreCalculator()
        
        let vrau = Vrau(income: 3950, prolaborePercentage: 11, isNational: true)
        
        let dla = vrau.calculateDla()
        let expectedDla = 2454.82
        
        XCTAssertEqual(dla, expectedDla)
    }
    
    func testProlaborePercentage() {
        let vrau = Vrau(income: 10000, prolaborePercentage: 28, isNational: true)
        
        XCTAssertEqual(vrau.getProLabore(), 2800)
    }
    
    func testProlaborePercentageMinimumWage() {
        let vrau = Vrau(income: 2000, prolaborePercentage: 28, isNational: true)
        
        XCTAssertEqual(vrau.getProLabore(), 1320)
    }

}
