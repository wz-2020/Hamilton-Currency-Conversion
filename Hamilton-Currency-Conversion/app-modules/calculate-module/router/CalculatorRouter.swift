//
//  CalculatorRouter.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

class CalculatorRouter:PresenterToRouterCalculatorProtocol{
    func navigateToExchangeRateScreen(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
    
    func presentToCalculatorSuccessScreen(viewController: CalculatorViewController, toAmount: String, rate: Double) {
        
        let vc = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        vc.text = String(format: NSLocalizedString("Success_Message", comment: ""), toAmount, String(format: "%.2f", rate))
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func showCalculatorAlert(viewController: CalculatorViewController, fromAmount: String, toAmount: String, rate: Double) {
        let title = NSLocalizedString("Alert_Title", comment: "")
        let message = String(format: NSLocalizedString("Alert_Message", comment: ""), fromAmount, toAmount)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                // cancel
        }
 
        let approveButton = UIAlertAction(title: "Approve", style: .default) { _ in
            self.presentToCalculatorSuccessScreen(viewController: viewController, toAmount: toAmount, rate: rate)
        }

        alert.addAction(cancelButton)
        alert.addAction(approveButton)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func createCalculatorModule(amount: Double, rate: Double, fromCurrency: String, endCurrency: String) -> CalculatorViewController {
        
        let view = CalculatorRouter.mainstoryboard.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        
        var presenter: ViewToPresenterCalculatorProtocol & InteractorToPresenterCalculatorProtocol = CalculatorPresenter()
        presenter.amount = amount
        presenter.rate = rate
        presenter.fromCurrency = fromCurrency
        presenter.endCurrency = endCurrency
        
        var interactor: PresenterToInteractorCalculatorProtocol = CalculatorInteractor()
        let router:PresenterToRouterCalculatorProtocol = CalculatorRouter()
        
        view.calculatorPresenter = presenter
        view.start = (UIApplication.shared.delegate as! AppDelegate).getTimerMax()
        presenter.view = view as! PresenterToViewCalculatorProtocol
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
 
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
 
}

