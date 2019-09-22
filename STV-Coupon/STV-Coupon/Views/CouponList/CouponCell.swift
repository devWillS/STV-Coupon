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
    @IBOutlet weak private var overlayView: UIView!
    @IBOutlet weak private var upperOverlayView: UIView!
    @IBOutlet weak private var bottomOverlayView: UIView!
    
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
        
        upperOverlayView.layer.cornerRadius = 20
        upperOverlayView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomOverlayView.layer.cornerRadius = 5
        bottomOverlayView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        priceDownLabel.text = ""
        expiredTitleLabel.text = ""
        expiredLabel.text = ""
        
        wishButton.imageView?.contentMode = .scaleAspectFit
        wishButton.contentHorizontalAlignment = .fill
        wishButton.contentVerticalAlignment = .fill
    }
    
    private func setCoupon() {
        priceDownLabel.text = R.string.localizable.priceDownText(coupon.priceDown.commaSeparated())
        
        overlayView.isHidden = coupon.used.isEmpty
        
        if coupon.used.isEmpty {
            expiredTitleLabel.text = R.string.localizable.expiredTitleText()
            expiredTitleLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.getExpiredDateString()
            expiredLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)

        } else {
            
            expiredTitleLabel.text = R.string.localizable.expiredTitleUsedText()
            expiredTitleLabel.font = UIFont.boldSystemFont(ofSize: expiredTitleLabel.font.pointSize)
            
            expiredLabel.text = coupon.used
            expiredLabel.font = UIFont.systemFont(ofSize: expiredTitleLabel.font.pointSize)
        }
        
        setWishButttonImage()
    }
    
    private func setWishButttonImage() {
        var image: UIImage?
        if coupon.wish {
            image = R.image.unwish()
        } else {
            image = R.image.wish()
            if #available(iOS 13.0, *) {
                wishButton.tintColor = .label
            } else {
                wishButton.tintColor = .black
            }
        }
        wishButton.setImage(image, for: .normal)
    }
}

// MARK: - CollectionViewNibRegistrable
extension CouponCell: CollectionViewNibRegistrable {}
