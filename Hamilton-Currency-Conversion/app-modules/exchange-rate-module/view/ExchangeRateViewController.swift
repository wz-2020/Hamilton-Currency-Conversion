//
//  ExchangeRateViewController.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import UIKit

class ExchangeRateViewController: UIViewController {
   
    var presentor:ViewToPresenterProtocol?
    
    var exchangeRateArrayList:Array<ExchangeRateModel> = Array()
    var availableFromCurrencyArray: [String] = []
    var availableToCurrencyArray: [String] = []
    var exchangeRate: Double = 0
    
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    weak var pickerView: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.title = "Notice-Module"
        presentor?.startFetchingExchangeRate(from: "USD", to: "GBP")
        presentor?.startFetchingAvailableCurrency()
        //showProgressIndicator(view: self.view)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.pickerView = pickerView
        
        self.fromTextField.inputView = pickerView
        self.toTextField.inputView = pickerView
        self.amountTextField.keyboardType = .numberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExchangeRateViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
    }
    
    // tap screen dismiss keyboard.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func calculatorButtonClicked(_ sender: Any) {
        
    }
}

extension ExchangeRateViewController:PresenterToViewProtocol{
    func showExchangeRate(exchangeRate: Double) {
        self.exchangeRate = exchangeRate
    }
    
    func showExchangeRateError() {
        //hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAvailableCurrency(currencyArray: [String]) {
        availableFromCurrencyArray = currencyArray
        availableToCurrencyArray = currencyArray
        pickerView?.reloadAllComponents()
    }
    
    func showAvailableCurrencyError() {
        
    }
}

//MARK: -UIPickerViewDataSource, UIPickerViewDelegate
extension ExchangeRateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.fromTextField.isFirstResponder{
            return self.availableFromCurrencyArray.count
        }else if self.toTextField.isFirstResponder{
            return self.availableToCurrencyArray.count
        }
        return 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.fromTextField.isFirstResponder{
            return self.availableFromCurrencyArray[row]
        } else if self.toTextField.isFirstResponder{
            return self.availableToCurrencyArray[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.fromTextField.isFirstResponder{
            fromTextField.text = availableFromCurrencyArray[row]
        } else if self.toTextField.isFirstResponder{
            toTextField.text = availableToCurrencyArray[row]
        }
    }
}
