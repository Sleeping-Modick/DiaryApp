//
//  BottomSheetViewController.swift
//  DiaryApp
//
//  Created by t2023-m0056 on 2023/08/31.
//

import SnapKit
import UIKit

@available(iOS 16.0, *)
class DiaryCalendarViewController: UIViewController {
    // MARK: - BottomSheet

    // 바텀 시트 높이
    var bottomHeight: CGFloat = 650
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    // 전달받을 클로저
    var dataSendClosure: ((_ data: (String?, Date?)) -> Void)?
    
    // 기존 화면을 흐려지게 만들기 위한 뷰
    private let dimmedBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 바텀 시트 뷰
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        return view
    }()
    
    // MARK: - Callendar
    
    lazy var dateView: UICalendarView = {
        var view = UICalendarView()
        view.wantsDateDecorations = true
        return view
    }()
    
    var selectedDate: DateComponents? = nil
    var selectedTitle: String? = nil
    
    // MARK: - Properties
    
    var purposeTextField: UITextField = {
        var textField = UITextField()
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "목표", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        return textField
    }()
    
    var everyDayBtn = UIButton(), threeDaysBtn = UIButton(), fiveDaysBtn = UIButton(), everyWeekBtn = UIButton()
    
    var checkedEverDay = false, checkedThreeDays = false, checkedFiveDays = false, checkedEverWeek = false
    
    var sundayBtn = UIButton(), mondayBtn = UIButton(), tuesdayBtn = UIButton(), wednesdayBtn = UIButton(), thursdayBtn = UIButton(), fridayBtn = UIButton(), saturdayBtn = UIButton()
    
    var checkedSunday = false, checkedMonday = false, checkedTuesday = false, checkedWednesday = false, checkedThursday = false, checkedFridaay = false, checkedSaturday = false
    
    var saveBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("저장", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        return btn
    }()
    
    // dismiss Indicator View UI 구성 부분
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 3
        return view
    }()
    
    // MARK: - StackView
    
    var totalStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.snp.makeConstraints {
            $0.height.equalTo(120)
        }
        return view
    }()
    
    lazy var intervalStackView = {
        var view = UIStackView(arrangedSubviews: [self.everyDayBtn, self.threeDaysBtn, self.fiveDaysBtn, self.everyWeekBtn])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return view
    }()
    
    lazy var dayStackView = {
        let view = UIStackView(arrangedSubviews: [self.sundayBtn, self.mondayBtn, self.tuesdayBtn, self.wednesdayBtn, self.thursdayBtn, self.fridayBtn, self.saturdayBtn])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.isHidden = true
        view.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        return view
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.selectionBehavior = dateSelection
        
        configurationView()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }

    // MARK: - @Functions

    func configurationView() {
        setupUI()
        setupLayout()
        setDateView()
        setPurposeTitle()
        setTotalStackView()
        
        setEveryDayBtn()
        setThreeDaysBtn()
        setFiveDaysBtn()
        setEveryWeekBtn()
        
        setSundayBtn()
        setMondayBtn()
        setTuesdayBtn()
        setWednesdayBtn()
        setThursdayBtn()
        setFridayBtn()
        setSaturdayBtn()
        
        setSaveBtn()
    }
    
    // UI 세팅 작업
    private func setupUI() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        view.addSubview(dismissIndicatorView)
        dimmedBackView.alpha = 0.0
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // 레이아웃 세팅
    private func setupLayout() {
        dimmedBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        bottomSheetView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view)
        }
        bottomSheetViewTopConstraint.isActive = true
        
        dismissIndicatorView.snp.makeConstraints {
            $0.width.equalTo(102)
            $0.height.equalTo(7)
            $0.top.equalTo(bottomSheetView.snp.top).inset(12)
            $0.centerX.equalTo(bottomSheetView.snp.centerX)
        }
    }
    
    func setDateView() {
        bottomSheetView.addSubview(dateView)
        dateView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
    func setPurposeTitle() {
        bottomSheetView.addSubview(purposeTextField)
        purposeTextField.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        purposeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func setTotalStackView() {
        bottomSheetView.addSubview(totalStackView)
        totalStackView.addArrangedSubview(intervalStackView)
        totalStackView.addArrangedSubview(dayStackView)
        totalStackView.snp.makeConstraints {
            $0.top.equalTo(purposeTextField.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - IntervalBtn

    func setEveryDayBtn() {
        setIntervalBtn("매일", everyDayBtn)
        everyDayBtn.addTarget(self, action: #selector(clickedEveryDay), for: .touchUpInside)
    }
    
    func setThreeDaysBtn() {
        setIntervalBtn("3일", threeDaysBtn)
        threeDaysBtn.addTarget(self, action: #selector(clickedThreeDays), for: .touchUpInside)
    }
    
    func setFiveDaysBtn() {
        setIntervalBtn("5일", fiveDaysBtn)
        fiveDaysBtn.addTarget(self, action: #selector(clickedFiveDays), for: .touchUpInside)
    }
    
    func setEveryWeekBtn() {
        setIntervalBtn("매주", everyWeekBtn)
        everyWeekBtn.addTarget(self, action: #selector(clickedEveryWeek), for: .touchUpInside)
    }
    
    // MARK: - DaysBtn

    func setSundayBtn() {
        setDayBtn("일", sundayBtn)
        sundayBtn.layer.borderColor = UIColor.red.cgColor
        sundayBtn.setTitleColor(.red, for: .normal)
        sundayBtn.addTarget(self, action: #selector(clickedSunday), for: .touchUpInside)
    }
    
    func setMondayBtn() {
        setDayBtn("월", mondayBtn)
        mondayBtn.addTarget(self, action: #selector(clickedMonday), for: .touchUpInside)
    }
    
    func setTuesdayBtn() {
        setDayBtn("화", tuesdayBtn)
        tuesdayBtn.addTarget(self, action: #selector(clickedTuesday), for: .touchUpInside)
    }
    
    func setWednesdayBtn() {
        setDayBtn("수", wednesdayBtn)
        wednesdayBtn.addTarget(self, action: #selector(clickedWednesday), for: .touchUpInside)
    }
    
    func setThursdayBtn() {
        setDayBtn("목", thursdayBtn)
        thursdayBtn.addTarget(self, action: #selector(clickedThursday), for: .touchUpInside)
    }
    
    func setFridayBtn() {
        setDayBtn("금", fridayBtn)
        fridayBtn.addTarget(self, action: #selector(clickedFriday), for: .touchUpInside)
    }
    
    func setSaturdayBtn() {
        setDayBtn("토", saturdayBtn)
        saturdayBtn.layer.borderColor = UIColor.blue.cgColor
        saturdayBtn.setTitleColor(.blue, for: .normal)
        saturdayBtn.addTarget(self, action: #selector(clickedSaturday), for: .touchUpInside)
    }
    
    func setSaveBtn() {
        bottomSheetView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(totalStackView.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        saveBtn.addTarget(self, action: #selector(clickedSaveBtn), for: .touchUpInside)
    }
    
    func setIntervalBtn(_ title: String, _ btn: UIButton) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.snp.makeConstraints {
            $0.width.equalTo(80)
        }
    }
    
    func setDayBtn(_ title: String, _ btn: UIButton) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.snp.makeConstraints {
            $0.width.equalTo(40)
        }
    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - @objc

    @objc func clickedEveryDay() {
        everyDayBtn.backgroundColor = checkedEverDay ? .white : .black
        everyDayBtn.setTitleColor(checkedEverDay ? .black : .white, for: .normal)
        checkedEverDay = !checkedEverDay
    }
    
    @objc func clickedThreeDays() {
        threeDaysBtn.backgroundColor = checkedThreeDays ? .white : .black
        threeDaysBtn.setTitleColor(checkedThreeDays ? .black : .white, for: .normal)
        checkedThreeDays = !checkedThreeDays
    }
    
    @objc func clickedFiveDays() {
        fiveDaysBtn.backgroundColor = checkedFiveDays ? .white : .black
        fiveDaysBtn.setTitleColor(checkedFiveDays ? .black : .white, for: .normal)
        checkedFiveDays = !checkedFiveDays
    }
    
    @objc func clickedEveryWeek() {
        everyWeekBtn.backgroundColor = checkedEverWeek ? .white : .black
        everyWeekBtn.setTitleColor(checkedEverWeek ? .black : .white, for: .normal)
        checkedEverWeek = !checkedEverWeek
        
        dayStackView.isHidden = !dayStackView.isHidden
        bottomHeight = (dayStackView.isHidden == false) ? 700 : 650
        showBottomSheet()
    }
    
    @objc func clickedSunday() {
        sundayBtn.backgroundColor = checkedSunday ? .white : .red
        sundayBtn.setTitleColor(checkedSunday ? .red : .white, for: .normal)
        checkedSunday = !checkedSunday
    }
    
    @objc func clickedMonday() {
        mondayBtn.backgroundColor = checkedMonday ? .white : .black
        mondayBtn.setTitleColor(checkedMonday ? .black : .white, for: .normal)
        checkedMonday = !checkedMonday
    }
    
    @objc func clickedTuesday() {
        tuesdayBtn.backgroundColor = checkedTuesday ? .white : .black
        tuesdayBtn.setTitleColor(checkedTuesday ? .black : .white, for: .normal)
        checkedTuesday = !checkedTuesday
    }
    
    @objc func clickedWednesday() {
        wednesdayBtn.backgroundColor = checkedWednesday ? .white : .black
        wednesdayBtn.setTitleColor(checkedWednesday ? .black : .white, for: .normal)
        checkedWednesday = !checkedWednesday
    }
    
    @objc func clickedThursday() {
        thursdayBtn.backgroundColor = checkedThursday ? .white : .black
        thursdayBtn.setTitleColor(checkedThursday ? .black : .white, for: .normal)
        checkedThursday = !checkedThursday
    }
    
    @objc func clickedFriday() {
        fridayBtn.backgroundColor = checkedFridaay ? .white : .black
        fridayBtn.setTitleColor(checkedFridaay ? .black : .white, for: .normal)
        checkedFridaay = !checkedFridaay
    }
    
    @objc func clickedSaturday() {
        saturdayBtn.backgroundColor = checkedSaturday ? .white : .blue
        saturdayBtn.setTitleColor(checkedSaturday ? .blue : .white, for: .normal)
        checkedSaturday = !checkedSaturday
    }
    
    @objc func clickedSaveBtn() {
        self.dataSendClosure?((selectedTitle, selectedDate?.date))
        self.dismiss(animated: true, completion: nil)
    }
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
    
    @objc func textFieldDidChange() {
        self.selectedTitle = self.purposeTextField.text!
    }
}

@available(iOS 16.0, *)
extension DiaryCalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    // UICalendarView
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let label = UILabel()
//                label.text = "🐶"
                label.textAlignment = .center
                return label
            }
        }
        return nil
    }
    
    // 달력에서 날짜 선택했을 경우
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}

////    btn.addTarget(self, action: #selector(pushCallendar), for: .touchUpInside)
//    @objc func pushCallendar() {
//        let vc = DiaryCalendarViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: false, completion: nil)
//    }
