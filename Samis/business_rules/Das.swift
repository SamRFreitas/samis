//
//  Das.swift
//
//  Created by Samuel Ribeiro de Freitas on 14/03/24.
//

import Foundation
// Just a comment to test git
struct Das: Tax {
    
    var amount: Double
    
    var percentage: Double
    
    init(amount: Double, isNational: Bool = true) {
        
        self.amount = amount
        self.percentage = isNational ? 6.5 : 3.05
        
    }
    
    func calculateTax() -> Double {
        
        let result = AmountHandler().calculate(percentage: self.percentage, of: self.amount)
        
        return result
        
    }
    
}
