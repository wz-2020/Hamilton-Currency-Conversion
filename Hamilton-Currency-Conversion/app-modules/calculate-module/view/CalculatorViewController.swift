//
//  CalculatorViewController.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var calculatorPresenter:ViewToPresenterCalculatorProtocol?
    
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorPresenter?.startCalculate()
    }
    
    @IBAction func convertButtonClicked(_ sender: Any) {
        calculatorPresenter?.showConfirmConvertAlert(viewController: self)
    }
}
 
extension CalculatorViewController:PresenterToViewCalculatorProtocol{
 
    
    func onCalculatorProcessSuccess(from: String, end: String) {
        self.fromLabel.text = from
        self.toLabel.text = end
    }
}
