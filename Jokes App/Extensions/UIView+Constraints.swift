//
//  UIView+Constraints.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import SnapKit
import UIKit

extension UIView {
    func stretchLayout() {
        self.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
