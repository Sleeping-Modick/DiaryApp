//
//  DiaryProgressCell.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/30.
//

import SnapKit
import UIKit

final class DiaryProgressCell: UICollectionViewCell {
    static let identifier = "DiaryProgressCell"

    lazy var circularProgressBarView = CircleProgressBar(frame: .zero)
    lazy var percentLabel = CustomLabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCircularProgressBarView()
    }

    func setUpCircularProgressBarView() {
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false

        circularProgressBarView.center = contentView.center
        circularProgressBarView.progressAnimation(duration: 30)
        percentLabel.text = "100%"

        contentView.addSubview(circularProgressBarView)
        circularProgressBarView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
