//
//  CalculatorInteractor.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
class CalculatorInteractor:PresenterToInteractorCalculatorProtocol{
    
    var presenter: InteractorToPresenterCalculatorProtocol?

    func processCalculate(amount: Double, rate: Double, fromCurrency: String, endCurrency: String) {
        presenter?.calculatorProcessSuccess(from: "\(String(format: "%.2f", amount)) \(fromCurrency)", end: "\(String(format: "%.2f", (amount * rate))) \(endCurrency)")
    }
    
    func countDown(count: Int) {
        var count = count
        if(count > 0) {
            count = count - 1
            presenter?.displayCountDown(count: count)
        }
    }
}
