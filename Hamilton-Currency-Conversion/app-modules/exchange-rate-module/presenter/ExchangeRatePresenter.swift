//
//  ExchangeRatePresenter.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

class ExchangeRatePresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingExchangeRate(from currency1: String, to currency2: String) {
        interactor?.fetchExchangeRate(from: currency1, to: currency2)
    }
    
    func startFetchingAvailableCurrency() {
        interactor?.fetchAvailableCurrency()
    }
    
    func showCalculatorController(navigationController: UINavigationController, amount: Double, rate: Double, fromCurrency: String, endCurrency: String) {
        router?.pushToCalculatorScreen(navigationConroller:navigationController, amount: amount, rate: rate, fromCurrency: fromCurrency, endCurrency: endCurrency)
    }

}

extension ExchangeRatePresenter: InteractorToPresenterProtocol{
    func availableCurrencyFetchedSuccess(currencyArray: [String]) {
        view?.showAvailableCurrency(currencyArray: currencyArray)
    }
    
    func availableCurrecnyFetchFailed() {
        view?.showAvailableCurrencyError()
    }
    
    
    func exchangeRateFetchedSuccess(rate: Double) {
        view?.showExchangeRate(exchangeRate: rate)
    }
    
    func exchangeRateFetchFailed() {
        view?.showExchangeRateError()
    }
    
}
