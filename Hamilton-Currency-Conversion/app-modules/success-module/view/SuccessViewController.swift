//
//  SuccessViewController.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
import UIKit

// Should write this in a router, but I run out of time to write this class in a viper

class SuccessViewController: UIViewController {
    @IBOutlet weak var successLabel: UILabel!
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        successLabel.text = text
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
 
        /* Create ui-view-controller instance*/
        let exchangeRate = ExchangeRateRouter.createModule()

        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController(rootViewController: exchangeRate)
        /* Setting up the root view-controller as ui-navigation-controller */
 
        
        if let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        } else {
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}
  
