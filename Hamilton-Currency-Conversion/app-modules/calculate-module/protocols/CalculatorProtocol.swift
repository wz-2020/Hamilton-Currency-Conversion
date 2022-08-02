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
    func startCountDown(count: Int)
    func showConfirmConvertAlert(viewController: CalculatorViewController)
    func navigateToExchangeRateScreen(navigationController: UINavigationController)
}

protocol PresenterToViewCalculatorProtocol {

    func onCalculatorProcessSuccess(from: String, end: String)
    func displayCountDown(count: Int)
}

protocol PresenterToRouterCalculatorProtocol {
    
    static func createCalculatorModule(amount: Double, rate: Double, fromCurrency: String, endCurrency: String)->CalculatorViewController
    
    func showCalculatorAlert(viewController: CalculatorViewController)
    func presentToCalculatorSuccessScreen(viewController: CalculatorViewController, amount: Double, rate: Double, endCurrency: String)
    func navigateToExchangeRateScreen(navigationController:UINavigationController)
}

protocol PresenterToInteractorCalculatorProtocol {
    
    var presenter:InteractorToPresenterCalculatorProtocol? {get set}
    func processCalculate(amount: Double, rate: Double, fromCurrency: String, endCurrency: String)
    func countDown(count: Int)
    
}

protocol InteractorToPresenterCalculatorProtocol {
    
    func calculatorProcessSuccess(from: String, end: String)
 
    func displayCountDown(count: Int)
}
