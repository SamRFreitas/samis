//
//  Das.swift
//
//  Created by Samuel Ribeiro de Freitas on 14/03/24.
//

import Foundation

protocol Tax {
    
    var amount: Double { get }
    
    func calculateTax() -> Double
    
}

