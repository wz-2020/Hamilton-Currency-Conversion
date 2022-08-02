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
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
        
        //let movieModue = MovieRouter.createMovieModule()
        //navigationController.pushViewController(movieModue,animated: true)
        
    }
    
}
