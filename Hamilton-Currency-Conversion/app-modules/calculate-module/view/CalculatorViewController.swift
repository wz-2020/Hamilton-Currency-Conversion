//
//  CalculatorViewController.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var calculatorPresenter:ViewToPresenterCalculatorProtocol?
    var start: Int = 30
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorPresenter?.startCalculate()
        timerLabel.text = "\(String(start)) sec left"
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        calculatorPresenter?.startCountDown(count: start)
    }
    
    @IBAction func convertButtonClicked(_ sender: Any) {
        if let fromAmount = fromLabel.text, let toAmount = toLabel.text {
            calculatorPresenter?.showConfirmConvertAlert(viewController: self, fromAmount: fromAmount, toAmount: toAmount, rate: calculatorPresenter?.rate ?? 0)
        }
    }
}
 
extension CalculatorViewController:PresenterToViewCalculatorProtocol{
    func displayCountDown(count: Int) {
        timerLabel.text = "\(String(count)) sec left"
        start = count
        if count == 0 {
            calculatorPresenter?.navigateToExchangeRateScreen(navigationController: navigationController!)
        }
    }
    
    func onCalculatorProcessSuccess(from: String, end: String) {
        self.fromLabel.text = from
        self.toLabel.text = end
    }
}
