//
//  ExchangeRateRouter.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

class ExchangeRateRouter:PresenterToRouterProtocol{
    
    static func createModule() -> ExchangeRateViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ExchangeRateViewController") as! ExchangeRateViewController
        
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ExchangeRatePresenter()
        var interactor: PresenterToInteractorProtocol = ExchangeRateInteractor()
        let router:PresenterToRouterProtocol = ExchangeRateRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToCalculatorScreen(navigationConroller navigationController:UINavigationController, amount: Double, rate: Double, fromCurrency: String, endCurrency: String) {
        
        let calculatorModue = CalculatorRouter.createCalculatorModule(amount: amount, rate: rate, fromCurrency: fromCurrency, endCurrency: endCurrency)
        navigationController.pushViewController(calculatorModue,animated: true)
    }
    
}
