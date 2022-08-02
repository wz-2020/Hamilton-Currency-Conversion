//
//  ExchangeRateManager.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation
class ExchangeRateManager {
    static let urlSession = URLSession(configuration: .default)
  
    static func exchangeRate(currency: String,
                      completionHandler: @escaping (_ exchangeRate: ExchangeRateModel) -> Void) {
            let exchangeRateUrl = buildExchangeRateURL(currency: currency)
            let task = urlSession.dataTask(with: exchangeRateUrl) { (data, _, _) in
            let exchangeRate = try! JSONDecoder().decode(ExchangeRateModel.self, from: data!)
            UserDefaults.standard.set(data, forKey: currency)
            DispatchQueue.main.async {
                completionHandler(exchangeRate)
            }
        }
            
        task.resume()
  }
  
  private static func buildExchangeRateURL(currency: String) -> URL {
      let apiKey = "c4431b73572c7957129be2ee"
      //"https://v6.exchangerate-api.com/v6/c4431b73572c7957129be2ee/latest/USD"
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "v6.exchangerate-api.com"
      urlComponents.path = "/v6/\(apiKey)/latest/\(currency)"
      return urlComponents.url!
  }
}
