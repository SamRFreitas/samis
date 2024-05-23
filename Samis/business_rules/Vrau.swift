//
//  Vrau.swift
//  Samis
//
//  Created by Samuel Ribeiro de Freitas on 19/03/24.
//

import Foundation

protocol DasCalculatorProtocol {
    func calculate(das: Das) -> Double
}

protocol InssCalculatorProtocol {
    func calculate(inss: Inss) -> Double
}

protocol IrrfCalculatorProtocol {
    func calculate(inss: Inss) -> Double
}

protocol ProLaboreCalculatorProtocol {
    func calculate(vrau: Vrau) -> Double
}

struct DasCalculator: DasCalculatorProtocol {
    
    func calculate(das: Das) -> Double {
        
        let result = das.calculateTax()
        
        return AmountHandler().roundDouble(amount: result)
    }
    
}

struct InssCalculator: InssCalculatorProtocol {
    
    func calculate(inss: Inss) -> Double {
        
        let result = inss.calculateTax()
        
        return AmountHandler().roundDouble(amount: result)
    }
    
}

struct IrrfCalculator: IrrfCalculatorProtocol {
    
    func calculate(inss: Inss) -> Double {
        
        let result = inss.calculateIrrfTax()
        
        return AmountHandler().roundDouble(amount: result)
    }
    
}

struct ProLaboreCalculator: ProLaboreCalculatorProtocol {
    
    func calculate(vrau: Vrau) -> Double {
        
        let amount = AmountHandler().calculate(percentage: vrau.prolaborePercentage, of: vrau.income)
        
        let proLabore = amount > vrau.minimumWage ? amount : vrau.minimumWage
        
        return proLabore
        
    }
    
}

struct Vrau {
    
    let income: Double
    let prolaborePercentage: Double
    let isNational: Bool
    let minimumWage: Double = 1320
    
    let accountantsFee = 115.0
    let rental = 647.0
    let digitalSignature = 235.0
    let annualExpenses: Double
    let fundsEarmarkedForAnnualBills: Double
    let numberOfMonthsToSaveMoney: Int = 11
    
    static var calculateDas: DasCalculatorProtocol = DasCalculator()
    static var calculateInss: InssCalculatorProtocol = InssCalculator()
    static var calculateIrrf: IrrfCalculatorProtocol = IrrfCalculator()
    static var calculateProLabore: ProLaboreCalculatorProtocol = ProLaboreCalculator()
    
    init(income: Double, prolaborePercentage: Double, isNational: Bool) {
        self.income = income
        self.prolaborePercentage = prolaborePercentage
        self.isNational = isNational
        
        self.annualExpenses = self.rental + self.digitalSignature
        self.fundsEarmarkedForAnnualBills = AmountHandler().roundDouble(amount: self.annualExpenses / Double(self.numberOfMonthsToSaveMoney))
        
    }
    
    func getProLabore() -> Double {
        
        let amount = AmountHandler().calculate(percentage: self.prolaborePercentage, of: self.income)
        
        let proLabore = amount > self.minimumWage ? amount : self.minimumWage
        
        return proLabore
        
    }
    
    func getInss() -> Inss {
        
        let proLabore = self.getProLabore()
        
        return Inss(amount: proLabore)
        
    }
    
    func calculateDla() -> Double {
        
        let inss: Inss = self.getInss()
        let das: Das = Das(amount: self.income, isNational: self.isNational)
        
        let dla = self.income - Vrau.calculateDas.calculate(das: das) - Vrau.calculateProLabore.calculate(vrau: self) - Vrau.calculateInss.calculate(inss: inss) - Vrau.calculateIrrf.calculate(inss: inss) - self.accountantsFee - self.fundsEarmarkedForAnnualBills
        
        return AmountHandler().roundDouble(amount: dla)
        
    }
    
    
}
