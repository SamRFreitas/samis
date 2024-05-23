//
//  CoinMarketCapAPITests.swift
//  SamisTests
//
//  Created by Samuel Ribeiro de Freitas on 10/04/24.
//

import XCTest
@testable import Samis

final class CoinMarketCapAPITests: XCTestCase {

    func testCMCAPI() {
        
        let cmcapi = CMC()
        cmcapi.test()
        
    }

}
