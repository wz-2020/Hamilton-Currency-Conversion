//
//  ExchangeRateProtocols.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingExchangeRate(from currency1: String, to currency2: String)
    func startFetchingAvailableCurrency() 
    func showCalculatorController(navigationController:UINavigationController, amount: Double, rate: Double, fromCurrency: String, endCurrency: String)

}

protocol PresenterToViewProtocol {
    func showExchangeRate(exchangeRate: Double)
    func showExchangeRateError()
    func showAvailableCurrency(currencyArray: [String])
    func showAvailableCurrencyError()
}

protocol PresenterToRouterProtocol {
    static func createModule()-> ExchangeRateViewController
    func pushToCalculatorScreen(navigationConroller:UINavigationController, amount: Double, rate: Double, fromCurrency: String, endCurrency: String)
   
}

protocol PresenterToInteractorProtocol {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchExchangeRate(from currency1: String, to currency2: String)
 
}

protocol InteractorToPresenterProtocol {
    func exchangeRateFetchedSuccess(rate: Double)
    func exchangeRateFetchFailed()
    func availableCurrencyFetchedSuccess(currencyArray: [String])
    func availableCurrecnyFetchFailed()
}
