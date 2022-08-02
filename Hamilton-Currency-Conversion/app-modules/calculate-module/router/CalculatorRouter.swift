//
//  CalculatorRouter.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

class CalculatorRouter:PresenterToRouterCalculatorProtocol{
    func presentToCalculatorSuccessScreen(viewController: CalculatorViewController, amount: Double, rate: Double, endCurrency: String) {
        
        let vc = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        
        vc.text = NSLocalizedString("Success_Message", comment: "")
        
 
        vc.modalPresentationStyle = .fullScreen
        
        viewController.present(vc, animated: true, completion: nil)
        //navigationController.pushViewController(view,animated: true)
    }
    
    func showCalculatorAlert(viewController: CalculatorViewController) {
        let alert = UIAlertController(title: NSLocalizedString("Alert_Title", comment: ""), message: NSLocalizedString("Alert_Message", comment: ""), preferredStyle: UIAlertController.Style.alert)

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                // cancel
        }
 
        let approveButton = UIAlertAction(title: "Approve", style: .default) { _ in
            self.presentToCalculatorSuccessScreen(viewController: viewController, amount: 0, rate: 0, endCurrency: "")
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

