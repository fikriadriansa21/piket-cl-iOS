//
//  ImageTextfieldExtension.swift
//  piket-cl-ios
//
//  Created by Fikri Adriansa Yudha on 12/10/19.
//  Copyright © 2019 Unikom Codelabs. All rights reserved.
//

import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 0, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       rightView = iconContainerView
       rightViewMode = .always
    }
}
