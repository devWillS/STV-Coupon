//
//  CouponListViewController.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {
    var controller: CouponListController = CouponListController()
    let dataSource: CouponListProvider = CouponListProvider()
    
    private let itemsPerRow: CGFloat = 1
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var couponListCollectionView: UICollectionView!
    @IBOutlet weak private var noCouponView: UIView!
    @IBOutlet weak private var noCouponLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        controller.delegate = self
        controller.fetchCoupons()
    }
}

///Private Method
extension CouponListViewController {
    private func setupView() {
        titleLabel.text = "titleLabelText".localized()
        
        couponListCollectionView.dataSource = dataSource
        couponListCollectionView.delegate = self
        CouponCell.register(collectionView: couponListCollectionView)
        
        noCouponView.isHidden = true
        noCouponLabel.text = "noCouponText".localized()
    }
}


extension CouponListViewController: UICollectionViewDelegate {
    
}

extension CouponListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = collectionView.bounds.width * 0.9
        return CGSize(width: cellSize, height: cellSize * 225 / 300)
    }
}

extension CouponListViewController: CouponListControllerDelegate {
    func deliveredCouponList(couponList: [CouponData]) {
        if couponList.isEmpty {
            noCouponView.isHidden = false
        } else {
            noCouponView.isHidden = true
            dataSource.couponList = couponList
        }
        couponListCollectionView.reloadData()
    }
}
