//
//  ProfileViewController.swift
//  DiaryApp
//
//  Created by (^ㅗ^)7 iMac on 2023/08/28.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    let photo = UIImagePickerController()
    
    var profileImg: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    var lineSpacer: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        view.snp.makeConstraints{
            $0.height.equalTo(1)
        }
        return view
    }()
    
    var userNameLabel: UILabel = {
        var label = UILabel()
        label.text = "이름"
        label.textColor = .systemGray
        return label
    }()
    
    var userNumLabel: UILabel = {
        var label = UILabel()
        label.text = "연락처"
        label.textColor = .systemGray
        return label
    }()
    
    var userMailLabel: UILabel = {
        var label = UILabel()
        label.text = "메일 주소"
        label.textColor = .systemGray
        return label
    }()
    
    var userName: UILabel = {
        var label = UILabel()
        label.text = "모비딕"
        return label
    }()
    
    var userNum: UILabel = {
        var label = UILabel()
        label.text = "010-0000-0000"
        return label
    }()
    
    var userMail: UILabel = {
        var label = UILabel()
        label.text = "mobydick@naver.com"
        return label
    }()
    
    var editUserName: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        return btn
    }()
    
    var editUserNum: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        return btn
    }()
    
    var editUserMail: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil"), for: .normal)
        return btn
    }()
    
    var settingStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 1
        stackView.backgroundColor = .systemGray
        return stackView
    }()
    
    var settingColor: UIButton = {
        var btn = UIButton()
        btn.setTitle("컬러 변경", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        return btn
    }()
    
    var settingNotice: UIButton = {
        var btn = UIButton()
        btn.setTitle("공지사항", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        return btn
    }()
    
    var settingQna: UIButton = {
        var btn = UIButton()
        btn.setTitle("QnA", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        return btn
    }()
    
    var settingBlank: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.photo.delegate = self
        
        setUI()
    }
    
    func setUI() {
        setProfileImage()
        setLineSpacer()
        setUserName()
        setUserNum()
        setStackView()
        setUserMail()
        setEditBtn()
    }
    
    func setProfileImage() {
        view.addSubview(profileImg)
        profileImg.snp.makeConstraints{
            //            $0.top.equalToSuperview().inset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(150)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setLineSpacer() {
        view.addSubview(lineSpacer)
        lineSpacer.snp.makeConstraints{
            $0.top.equalTo(profileImg.snp.bottom).inset(-20)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
    
    func setUserName() {
        view.addSubview(userNameLabel)
        view.addSubview(userName)
        view.addSubview(editUserName)
        
        userNameLabel.snp.makeConstraints{
            $0.top.equalTo(lineSpacer.snp.bottom).inset(-40)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        userName.snp.makeConstraints{
            $0.top.equalTo(lineSpacer.snp.bottom).inset(-40)
            $0.leading.equalTo(userNameLabel.snp.trailing).inset(-10)
            $0.height.equalTo(40)
        }
        
        editUserName.snp.makeConstraints{
            $0.top.equalTo(lineSpacer.snp.bottom).inset(-40)
            $0.leading.equalTo(userName.snp.trailing).inset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.width.equalTo(20)
            $0.height.equalTo(40)
        }
    }
    
    func setUserNum() {
        view.addSubview(userNumLabel)
        view.addSubview(userNum)
        view.addSubview(editUserNum)
        
        userNumLabel.snp.makeConstraints{
            $0.top.equalTo(userNameLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        userNum.snp.makeConstraints{
            $0.top.equalTo(userName.snp.bottom).inset(-10)
            $0.leading.equalTo(userNumLabel.snp.trailing).inset(-10)
            $0.height.equalTo(40)
        }
        
        editUserNum.snp.makeConstraints{
            $0.top.equalTo(editUserName.snp.bottom).inset(-10)
            $0.leading.equalTo(userNum.snp.trailing).inset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.width.equalTo(20)
            $0.height.equalTo(40)
        }
    }
    
    func setUserMail() {
        view.addSubview(userMailLabel)
        view.addSubview(userMail)
        view.addSubview(editUserMail)
        
        userMailLabel.snp.makeConstraints{
            $0.top.equalTo(userNumLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.bottom.equalTo(settingStackView.snp.top).inset(-40)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        userMail.snp.makeConstraints{
            $0.top.equalTo(userNum.snp.bottom).inset(-10)
            $0.leading.equalTo(userMailLabel.snp.trailing).inset(-10)
            $0.bottom.equalTo(settingStackView.snp.top).inset(-40)
            $0.height.equalTo(40)
        }
        
        editUserMail.snp.makeConstraints{
            $0.top.equalTo(editUserNum.snp.bottom).inset(-10)
            $0.leading.equalTo(userMail.snp.trailing).inset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.bottom.equalTo(settingStackView.snp.top).inset(-40)
            $0.width.equalTo(20)
            $0.height.equalTo(40)
        }
    }
    
    func setStackView() {
        view.addSubview(settingStackView)
        settingStackView.addArrangedSubview(settingColor)
        settingStackView.addArrangedSubview(settingNotice)
        settingStackView.addArrangedSubview(settingQna)
        settingStackView.addArrangedSubview(settingBlank)
        
        settingStackView.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        settingColor.snp.makeConstraints{
            $0.top.equalTo(settingStackView.snp.top).inset(1)
            $0.height.equalTo(40)
        }
        
        settingNotice.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        
        settingQna.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        
        settingBlank.snp.makeConstraints{
            $0.height.equalTo(40)
        }
    }
    
    func setEditBtn() {
        editUserName.addTarget(self, action: #selector(clickedEditName), for: .touchUpInside)
        editUserNum.addTarget(self, action: #selector(clickedEditNum), for: .touchUpInside)
        editUserMail.addTarget(self, action: #selector(clickedEditMail), for: .touchUpInside)
    }
    
    func editAlert(_ setTitle: String, _ hint: String, _ changedTextField: UILabel) {
        let alert = UIAlertController(title: "수정", message: setTitle, preferredStyle: .alert)
        let sucess = UIAlertAction(title: "완료", style: .default){ ok in
            changedTextField.text = alert.textFields?.first?.text
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive){ cancel in
        }
        alert.addTextField { textField in
            textField.placeholder = hint
        }
        alert.addAction(sucess)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func selectImage(){
        DispatchQueue.main.async {
            self.photo.sourceType = .photoLibrary // 앨범 지정 실시
            self.photo.allowsEditing = true // 편집을 허용하지 않음
            self.present(self.photo, animated: false, completion: nil)
        }
    }
    
    @objc func imageViewTapped(_ sender: AnyObject) {
        selectImage()
    }
    
    @objc func clickedEditName() {
        editAlert(userNameLabel.text!, userName.text!, userName)
    }
    
    @objc func clickedEditNum() {
        editAlert(userNumLabel.text!, userNum.text!, userNum)
    }
    
    @objc func clickedEditMail() {
        editAlert(userMailLabel.text!, userMail.text!, userMail)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage]{
            self.profileImg.image = img as? UIImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
