//
//  CalculatorViewController.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var calculatorPresenter:ViewToPresenterCalculatorProtocol?
    var start: Int = 0
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorPresenter?.startCalculate()
        timerLabel.text = "\(String(start)) sec left"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
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
            if navigationController != nil {
                calculatorPresenter?.navigateToExchangeRateScreen(navigationController: navigationController!)
            }
        }
    }
    
    func onCalculatorProcessSuccess(from: String, end: String) {
        self.fromLabel.text = from
        self.toLabel.text = end
    }
}
