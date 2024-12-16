//
//  TestViewController.swift
//  AdventureDoToList
//
//  Created by Huy on 13/12/24.
//

import UIKit
import RxSwift

protocol ReloadInfoDelegate: NSObjectProtocol {
    func reloadInfo()
}

class AddViewController: UIViewController {
    weak var delegate: ReloadInfoDelegate?

    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    let addButton = UIButton()
    var createAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F5EEDF")
        setupRx()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        titleTextField.placeholder = "Title"
        titleTextField.textColor = .black
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextField.placeholder = "Description"
        descriptionTextField.textColor = .black
        descriptionTextField.borderStyle = .roundedRect
        
        addButton.setTitle("Create", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemGray
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        
        
    }
    func setupConstraints() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(addButton)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        
        }
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        
        }
    }
    private func setupRx() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    @objc func addButtonTapped() {
        let title = titleTextField.text!
        let description = descriptionTextField.text!
        
        if (!title.isEmpty || !description.isEmpty) {
            let addItem = Item(title: title, description: description)
            ItemData.items.append(addItem)
            
            delegate?.reloadInfo()

            self.dismiss(animated: true, completion: nil)
        }
        print("Add button tapped",ItemData.items)

       

    }


}
