//
//  CalculatorPresenter.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

class CalculatorPresenter:ViewToPresenterCalculatorProtocol{
    
    var view: PresenterToViewCalculatorProtocol?

    var interactor: PresenterToInteractorCalculatorProtocol?
    
    var router: PresenterToRouterCalculatorProtocol?
    
    var amount: Double?
    var rate: Double?
    var fromCurrency: String?
    var endCurrency: String?
    
    func startCalculate() {
        if amount != nil && rate != nil && fromCurrency != nil && endCurrency != nil {
            interactor?.processCalculate(amount: amount!, rate: rate!, fromCurrency: fromCurrency!, endCurrency: endCurrency!)
        }
    }
    
    func startCountDown(count: Int) {
        interactor?.countDown(count: count)
    }
    
    func showConfirmConvertAlert(viewController: CalculatorViewController) {
        router?.showCalculatorAlert(viewController: viewController)
    }
    
    func navigateToExchangeRateScreen(navigationController: UINavigationController) {
        router?.navigateToExchangeRateScreen(navigationController: navigationController)
    }
}

extension CalculatorPresenter:InteractorToPresenterCalculatorProtocol{
    func displayCountDown(count: Int) {
        view?.displayCountDown(count: count)
    }
    
    func calculatorProcessSuccess(from: String, end: String) {
        view?.onCalculatorProcessSuccess(from: from, end: end)
    }
}
