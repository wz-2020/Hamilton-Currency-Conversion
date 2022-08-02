//
//  HttpRequestHelper.swift
//  Hamilton-Currency-Conversion
//
//  Created by Wanchun Zhang on 02/08/2022.
//

import Foundation

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        switch httpHeader {
            case .application_json:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .application_x_www_form_urlencoded:
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            case .none: break
        }

        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                complete(false, nil)
                return
            }
            guard let data = data else {
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}
