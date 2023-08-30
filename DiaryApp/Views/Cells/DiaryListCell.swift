//
//  DiaryListCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/29.
//

import UIKit

final class DiaryListCell: UICollectionViewCell {
    static let identifier = "DiaryListCell"

    let stackView = CustomStackView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    func setupUI() {
        stackView.axis = .vertical
    }

    func setupLayout() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
