//
//  APIClient.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientType {
    func fetchCoupons(endPoint: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}

enum FetchError: Error {
    case missingData   // データがないとき
}

class APIClient : APIClientType {
    let baseUrl = "https://st-ventures.mocklab.io"
    
    func fetchCoupons(endPoint: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        log?.info("\n👆👆👆\nRequestURL:\(baseUrl + endPoint)")
        Alamofire.request(baseUrl + endPoint, headers: nil).responseData { response in
            guard let statusCode = response.response?.statusCode else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            var responseJson = ""
            if let data = response.result.value,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                responseJson = json.prettyPrintedJsonString
            }
            switch response.result {
                
            case .success:
                log?.info("\n👇👇👇" +
                    "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")
                guard let data = response.data else {
                    completion(.failure(FetchError.missingData))
                    return
                }
                completion(.success(data))
                return
                
            case .failure:
                log?.error("\n🔻🔻🔻" +
                    "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")
                
                if let error = response.result.error {
                    completion(.failure(error))
                    return
                }
            }
        }
    }
}
