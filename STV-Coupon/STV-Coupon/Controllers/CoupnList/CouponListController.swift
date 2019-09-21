//
//  CouponListController.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

class CouponListController{
    private var api = APIClient()
    
    func fetchCoupons() {
        api.fetchCoupons(endPoint: "/couponList") { (result) in
            switch result {
            case .success(let data):
                self.save(data: data)
            case .failure(let error):
                break
            }
        }
    }
    
    private func save(data: Data) {
        let decoder = JSONDecoder()
        guard let couponResult: CouponResult = try? decoder.decode(CouponResult.self, from: data) else {
            return
        }
    }
}
