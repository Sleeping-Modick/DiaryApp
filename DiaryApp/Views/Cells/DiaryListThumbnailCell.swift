//
//  DiaryListThumbnailCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/30.
//

import SnapKit
import UIKit

class DiaryListThumbnailCell: UICollectionViewCell {
    static let identifier = "DiaryListThumbnailCell"

    lazy var thumbNailImage = CustomImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        thumbNailImage.contentMode = .scaleToFill
        
        contentView.addSubview(thumbNailImage)
        thumbNailImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
