//
//  Inss.swift
//  Samis
//
//  Created by Samuel Ribeiro de Freitas on 18/03/24.
//

import Foundation

struct IrrfDeduction {
    
    var aliquot: Double = 0
    var value: Double = 0
    
    init(amountWithoutTax: Double) {
        
        if amountWithoutTax > 0 && amountWithoutTax <= 1903.98 {
            
            self.aliquot = 0.0
            self.value = 0.0
            
        } else if amountWithoutTax > 1903.99 && amountWithoutTax <= 2826.65 {
            
            self.aliquot = 7.5
            self.value = 142.80
            
        } else if amountWithoutTax >= 2826.66 && amountWithoutTax <= 3751.05 {
            
            self.aliquot = 15
            self.value = 354.8
            
        } else if amountWithoutTax >= 3751.06 && amountWithoutTax <= 4664.68 {
            
            self.aliquot = 22.5
            self.value = 636.13
            
        } else if amountWithoutTax > 4664.68 {
            
            self.aliquot = 27.5
            self.value = 869.36
        }
        
    }
    
}

struct Inss: Tax {
    
    var amount: Double
    
    init(amount: Double) {
        self.amount = amount
    }
    
    func calculateTax() -> Double {
        
        // Plano simplificado (11%) - Do Salário Mínimo
        let result = AmountHandler().calculate(percentage: 11, of: self.amount)
        return result
        
    }
    
    func calculateIrrfTax() -> Double {
        
        let amountWithoutInssTax = self.amount - self.calculateTax()
        
        let irrfDeduction = IrrfDeduction(amountWithoutTax: amountWithoutInssTax)
        
        let irrfTax = AmountHandler().calculate(percentage: irrfDeduction.aliquot, of: amountWithoutInssTax) - irrfDeduction.value
        
        let result = irrfTax < 0 ? 0 : irrfTax
       
        return AmountHandler().roundDouble(amount: result)
        
    }
    
    
}
