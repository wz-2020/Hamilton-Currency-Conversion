//
//  CalculatorProtocol.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

protocol ViewToPresenterCalculatorProtocol {
    
    var view: PresenterToViewCalculatorProtocol? {get set}
    var interactor: PresenterToInteractorCalculatorProtocol? {get set}
    var router: PresenterToRouterCalculatorProtocol? {get set}
    var amount: Double? { get set }
    var rate: Double? { get set }
    var fromCurrency: String? { get set }
    var endCurrency: String? { get set }
    func startCalculate()
    func showConfirmConvertAlert(viewController: CalculatorViewController)
}

protocol PresenterToViewCalculatorProtocol {

    func onCalculatorProcessSuccess(from: String, end: String)
}

protocol PresenterToRouterCalculatorProtocol {
    
    static func createCalculatorModule(amount: Double, rate: Double, fromCurrency: String, endCurrency: String)->CalculatorViewController
    
    func showCalculatorAlert(viewController: CalculatorViewController)
    func presentToCalculatorSuccessScreen(viewController: CalculatorViewController, amount: Double, rate: Double, endCurrency: String)
}

protocol PresenterToInteractorCalculatorProtocol {
    
    var presenter:InteractorToPresenterCalculatorProtocol? {get set}
    func processCalculate(amount: Double, rate: Double, fromCurrency: String, endCurrency: String)
    
}

protocol InteractorToPresenterCalculatorProtocol {
    
    func calculatorProcessSuccess(from: String, end: String)
 
    
}
