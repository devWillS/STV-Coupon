//
//  CouponData.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation

class CouponData {
    var couponID: String = ""
    var priceDown: Int = 0
    var fromExpire: String = ""
    var toExpire: String = ""
    var used: String = ""
    var wish: Bool = false
    
    convenience init(coupon: CouponEntity) {
        self.init()
        couponID = coupon.couponID
        priceDown = coupon.priceDown
        fromExpire = coupon.fromExpire
        toExpire = coupon.toExpire
        used = coupon.used
        wish = coupon.wish
    }
    
    func getExpiredDateString() -> String {
        let fromExpiredDate = fromExpire.toDate(.yearDay)
        let toExpiredDate = toExpire.toDate(.yearDay)
        
        guard let fromExpiredDateString = fromExpiredDate?.toString(.slashYearToDay),
            let toExpiredDateString = toExpiredDate?.toString(.slashYearToDay) else {
                assertionFailure("convert error: Date to String")
                return ""
        }
        
        return "\(fromExpiredDateString)〜\(toExpiredDateString)"
    }
}
