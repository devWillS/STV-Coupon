//
//  CouponEntityDao.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit
import RealmSwift

final class CouponEntityDao {
    
    static let dao = RealmDaoHelper<CouponEntity>()
    
    static func add(objects: [Coupon]) {
        
        var couponList = [CouponEntity]()
        
        for object in objects {
            let coupon = CouponEntity(coupon: object)
            couponList.append(coupon)
        }
        
        dao.add(objects: couponList)
    }
    
    static func add(object: Coupon) {
        
        let coupon = CouponEntity(coupon: object)
        
        dao.add(object: coupon)
    }
    
    static func deleteAll() {
        dao.deleteAll()
    }
    
    static func findByID(couponID: Int) -> CouponEntity? {
        guard let object = dao.findFirst(key: couponID as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findAll() -> [CouponEntity] {
        
        var couponList = [CouponEntity]()
        
        for object in dao.findAll() {
            let coupon = object
            couponList.append(coupon)
        }
        return couponList
    }
}
