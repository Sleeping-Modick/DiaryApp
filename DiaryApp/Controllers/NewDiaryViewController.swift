//
//  NewDiaryViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import SnapKit
import UIKit

enum Options: String {
    case exercise = "운동"
    case food = "식단"
    case healthy = "헬스"
    case crossFit = "크로스핏"
}

final class NewDiaryViewController: UIViewController {
    let options: [Options] = [.exercise, .food, .healthy, .crossFit]

    var postList: [Post] = []
    var selectedButton: UIButton?

    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        return pickerView
    }()

    private let pickImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "내용을 입력하세요"
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 10
        textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        return textView
    }()

    private let goalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("목표", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedGoalButton), for: .touchUpInside)
        return button
    }()

    private let exercisButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("운동", for: .normal)
        button.addTarget(self, action: #selector(tappedHealthyButton), for: .touchUpInside)
        return button
    }()

    private let healthyButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("건강", for: .normal)
        button.addTarget(self, action: #selector(tappedHealthyButton), for: .touchUpInside)
        return button
    }()

    private let foodButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("식단", for: .normal)
        button.addTarget(self, action: #selector(tappedFoodButton), for: .touchUpInside)
        return button
    }()

    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(pickImageButton)
        view.addSubview(textView)
        view.addSubview(goalButton)
        view.addSubview(exercisButton)
        view.addSubview(healthyButton)
        view.addSubview(foodButton)

        pickImageButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(textView.snp.top).offset(-15)
            make.height.equalTo(pickImageButton.snp.width)
        }

        textView.snp.makeConstraints { make in
            make.top.equalTo(pickImageButton.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }

        goalButton.snp.makeConstraints { make in
            make.trailing.equalTo(textView)
            make.top.equalTo(textView.snp.bottom).offset(12)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }

        foodButton.snp.makeConstraints { make in
            make.top.equalTo(goalButton.snp.bottom).offset(12)
            make.leading.equalTo(textView.snp.leading)
            make.width.equalTo(100)
        }

        healthyButton.snp.makeConstraints { make in
            make.top.equalTo(goalButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }

        exercisButton.snp.makeConstraints { make in
            make.top.equalTo(goalButton.snp.bottom).offset(12)
            make.trailing.equalTo(textView.snp.trailing)
            make.width.equalTo(100)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    @objc func tappedGoalButton() {
        print("### \(#function)")
        if #available(iOS 16.0, *) {
            let vc = DiaryCalendarViewController()
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true)
        }
    }

    @objc func tappedExerciseButton() {
        print("### \(#function)")
    }

    @objc func tappedHealthyButton() {
        print("### \(#function)")
    }

    @objc func tappedFoodButton() {
        print("### \(#function)")
    }
}

extension NewDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func pickImage() {
        showImagePicker()
    }

    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageView = UIImageView(image: selectedImage)
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleToFill
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.bottom.leading.trailing.equalTo(pickImageButton)
            }
        }
    }
}

extension NewDiaryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].rawValue
    }
}
