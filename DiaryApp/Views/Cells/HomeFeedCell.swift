//
//  HomeFeedCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import SnapKit
import UIKit

final class HomeFeedCell: UICollectionViewCell {
    static let identifier = "HomeFeedCell"

    lazy var myView = CustomImageView(frame: .zero)
    lazy var weatherImage = CustomImageView(frame: .zero)

    let sizeWidth = 50

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.myView)

        self.myView.layer.masksToBounds = true
        self.myView.layer.cornerRadius = 20

        self.weatherImage.backgroundColor = .systemBlue
        self.weatherImage.contentMode = .center
        self.weatherImage.tintColor = .white
        self.weatherImage.layer.cornerRadius = CGFloat(self.sizeWidth / 2)

        self.myView.addSubview(self.weatherImage)
        self.myView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(contentView)
        }

        self.weatherImage.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(self.myView).offset(-30)
            make.height.width.equalTo(self.sizeWidth)
        }
    }
}
