//
//  CircleProgressBar.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/30.
//

import SnapKit
import UIKit

final class CircleProgressBar: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    var dayCount: Double?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath(dayCount ?? 0)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createCircularPath(_ strokeEnd: Double) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 65, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 20.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.systemGray6.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 20.0
        progressLayer.strokeEnd = strokeEnd
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
    }

//    func progressAnimation(duration: TimeInterval) {
//        // created circularProgressAnimation with keyPath
//        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        // set the end time
//        circularProgressAnimation.duration = 30
//        circularProgressAnimation.toValue = 3
//        circularProgressAnimation.fillMode = .forwards
//        circularProgressAnimation.isRemovedOnCompletion = false
//        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
//    }
}
