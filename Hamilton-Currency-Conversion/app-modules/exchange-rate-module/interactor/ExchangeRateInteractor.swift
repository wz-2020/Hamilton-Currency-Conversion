//
//  ExchangeRateInteractor.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation

class ExchangeRateInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    func fetchExchangeRate(from currency1: String, to currency2: String) {
        if let modelData = UserDefaults.standard.data(forKey: currency1) {
            do {
            let model = try JSONDecoder().decode(ExchangeRateModel.self, from: modelData)
                if let rate = model.conversionRates[currency2] {
                    self.presenter?.exchangeRateFetchedSuccess(rate: rate)
                } else {
                    self.presenter?.exchangeRateFetchFailed()
                }
            } catch {
                self.presenter?.exchangeRateFetchFailed()
            }
        } else {
            self.presenter?.exchangeRateFetchFailed()
        }
    }
    
    func fetchAvailableCurrency() {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        let plistPath: String? = Bundle.main.path(forResource: "settings", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            if let currencyArray = plistData["supported_currency"] as? [String] {
                self.presenter?.availableCurrencyFetchedSuccess(currencyArray: currencyArray)
            } else {
                self.presenter?.availableCurrecnyFetchFailed()
            }
        } catch {
            self.presenter?.availableCurrecnyFetchFailed()
        }
    }
}
