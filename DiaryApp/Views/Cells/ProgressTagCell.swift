//
//  ProgressTagCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/31.
//

import SnapKit
import UIKit

final class ProgressTagCell: UICollectionViewCell {
    static let identifier = "ProgressTagCell"

    lazy var tagTitleLabel = CustomLabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        tagTitleLabel.numberOfLines = 1
        tagTitleLabel.font = .systemFont(ofSize: 15)
        tagTitleLabel.textAlignment = .center
    }

    func setupLayout() {
        contentView.addSubview(tagTitleLabel)
        tagTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(contentView).inset(-10)
        }
    }
}
