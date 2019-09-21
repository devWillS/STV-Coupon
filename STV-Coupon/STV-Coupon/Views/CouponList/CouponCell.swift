//
//  CouponCell.swift
//  STV-Coupon
//
//  Created by devWill on 2019/09/21.
//  Copyright © 2019 devWill. All rights reserved.
//

import UIKit

class CouponCell: UICollectionViewCell {
    var coupon = CouponData() {
        didSet {
            setCoupon()
        }
    }
    
    @IBOutlet weak private var upperView: UIView!
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var wishButton: UIButton!
    @IBOutlet weak private var priceDownLabel: UILabel!
    @IBOutlet weak private var expiredTitleLabel: UILabel!
    @IBOutlet weak private var expiredLabel: UILabel!
    
    
    @IBAction func tappedWishButton(_ sender: UIButton) {
        coupon.wish = !coupon.wish
        CouponEntityDao.update(object: coupon)
        setWishButttonImage()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
}

///Private Method
extension CouponCell {
    private func setupView() {
        upperView.layer.cornerRadius = 20
        upperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomView.layer.cornerRadius = 5
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        priceDownLabel.text = ""
        expiredTitleLabel.text = ""
        expiredLabel.text = ""
        
        wishButton.imageView?.contentMode = .scaleAspectFit
        wishButton.contentHorizontalAlignment = .fill
        wishButton.contentVerticalAlignment = .fill
    }
    
    private func setCoupon() {
        priceDownLabel.text = "priceDownText".localized(parameter: coupon.priceDown.commaSeparated())
        
        if coupon.used.isEmpty {
            expiredTitleLabel.text = "expiredTitleText".localized()
            expiredTitleLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.getExpiredDateString()
            expiredLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)

        } else {
            
            expiredTitleLabel.text = "expiredTitleUsedText".localized()
            expiredTitleLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.used
            expiredLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
        }
        
        setWishButttonImage()
    }
    
    private func setWishButttonImage() {
        var image: UIImage
        if coupon.wish {
            image = #imageLiteral(resourceName: "unwish")
        } else {
            image = #imageLiteral(resourceName: "wish")
        }
        wishButton.setImage(image, for: .normal)
    }
}

// MARK: - CollectionViewNibRegistrable
extension CouponCell: CollectionViewNibRegistrable {}
