//
//  CustomImageView.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import UIKit

final class CustomImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = nil
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}