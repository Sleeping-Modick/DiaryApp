//
//  NewDiaryViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import SnapKit
import UIKit

class NewDiaryViewController: UIViewController {
    let options = ["운동", "식단", "헬스", "크로스핏", "양배추", "닭가슴살", "닭안심살"]
    var selectedButton: UIButton?
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    lazy var pickImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        return button
    }()

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "입력하시요"
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0
        return textView
    }()

    lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Button 1", for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        return button
    }()

    lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("운동", for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        return button
    }()

    lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("건강", for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        return button
    }()

    lazy var button4: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("식단", for: .normal)
        button.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(pickImageButton)
        view.addSubview(textView)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        pickImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            //      make.centerY.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(pickImageButton.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
            make.height.equalTo(button1).offset(100)
        }
        button1.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.bottom).offset(20)
            make.trailing.equalTo(textView).inset(20)
            make.top.equalTo(textView).offset(150)
        }
        button2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(20)
            make.leading.equalTo(button1)
        }
        button3.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(20)
            make.leading.equalTo(button2.snp.leading).offset(-100)
        }
        button4.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(20)
            make.leading.equalTo(button2.snp.leading).offset(-200)
        }
    }

    @objc func button1Tapped() {
        presentAlertWithPicker(for: button1)
    }

    @objc func button2Tapped() {
        presentAlertWithPicker(for: button2)
    }

    @objc func button3Tapped() {
        presentAlertWithPicker(for: button3)
    }

    @objc func button4Tapped() {
        presentAlertWithPicker(for: button4)
    }

    func presentAlertWithPicker(for button: UIButton) {
        selectedButton = button
        let alertController = UIAlertController(title: "Select", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.inputView = self.pickerView
        }
        let confirmAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let textField = alertController.textFields?.first
            if textField?.inputView == self.pickerView {
                let selectedRow = self.pickerView.selectedRow(inComponent: 0)
                let selectedOption = self.options[selectedRow]
                button.setTitle(selectedOption, for: .normal)
            } else {
                // Handle custom input from text field
                if let customInput = textField?.text, !customInput.isEmpty {
                    button.setTitle(customInput, for: .normal)
                }
            }
            self.selectedButton = nil
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.selectedButton = nil
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerX.equalTo(pickImageButton)
                make.centerY.equalTo(pickImageButton)
                make.width.height.equalTo(300)
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
        return options[row]
    }
}
