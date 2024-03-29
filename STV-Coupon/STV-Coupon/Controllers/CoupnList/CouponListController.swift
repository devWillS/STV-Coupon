//
//  CouponListController.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol CouponListControllerDelegate: class {
    func deliveredCouponList(couponList: [CouponData])
}

class CouponListController{
    private var api = APIClient()
    
    weak var delegate: CouponListControllerDelegate?
    
    func fetchCoupons() {
        SVProgressHUD.show()
        api.fetchCoupons(endPoint: "/couponList") { (result) in
            switch result {
            case .success(let data):
                self.save(data: data)
            case .failure(let error):
                self.deliverCouponList()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    func getCouponList() -> [CouponData] {
        return CouponEntityDao.findAll()
    }
    
    func checkCouponAvailable(coupon: CouponData) -> Bool {
        let nowString = Date().toString(.yearDay)
        
        return nowString > coupon.fromExpire && nowString < coupon.toExpire
    }
    
    private func save(data: Data) {
        let decoder = JSONDecoder()
        guard let couponResult: CouponResult = try? decoder.decode(CouponResult.self, from: data) else {
            return
        }
        
        if couponResult.returnCode == "0000" {
            CouponEntityDao.add(objects: couponResult.couponList)
            deliverCouponList()
        } else {
            deliverCouponList()
        }
    }
    
    private func deliverCouponList() {
        let couponList = CouponEntityDao.findAll()
        delegate?.deliveredCouponList(couponList: couponList)
    }
}
