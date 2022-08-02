//
//  ExchangeRateModel.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation

typealias ExchangeRateModels = [ExchangeRateModel]

// MARK: - ExchangeRate
struct ExchangeRateModel: Codable {
    let baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
