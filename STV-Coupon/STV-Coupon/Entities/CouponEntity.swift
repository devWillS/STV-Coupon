//
//  CouponEntity.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation
import RealmSwift

class CouponEntity: Object {
    
    @objc dynamic var couponID: String = ""
    @objc dynamic var priceDown: Int = 0
    @objc dynamic var fromExpire: String = ""
    @objc dynamic var toExpire: String = ""
    @objc dynamic var used: Bool = false
    @objc dynamic var wish: Bool = false
    
    override static func primaryKey() -> String? {
        return "couponID"
    }
    
    convenience init(coupon: Coupon) {
        self.init()
        couponID = coupon.couponID
        priceDown = coupon.priceDown
        fromExpire = coupon.fromExpire
        toExpire = coupon.toExpire
    }
}
