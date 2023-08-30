//
//  CustomLabel.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/29.
//

import UIKit

final class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
