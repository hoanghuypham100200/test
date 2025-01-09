//
//  footerView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//




import UIKit
import SnapKit

class FooterHomeView: UIView {
    let containerView = UIView()
    let createView  = DashedBorderView()
    
    let createLabel = UILabel()
    let iconFileImage = UIImageView()
    let iconCreateImage = UIImageView()
    
    var createAction:(()->Void)?
    
    var isUpgradeUserDefaults = UserDefaults.standard.bool(forKey: "isUpgrade") {
        didSet {
            if(isUpgradeUserDefaults  == true) {
                createView.isHidden = false

            }
            
        }
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRx()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupRx()
    }

    
    private func setupUI() {
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        createView.backgroundColor = UIColor(hex: "#18204D")
        createView.layer.cornerRadius = 25
        //label
        createLabel.text = "Create first message"
        createLabel.textColor = .white
        createLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        //image
        iconFileImage.image = UIImage.file
        iconCreateImage.image = UIImage.createIcon
       
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(createView)
        createView.addSubview(iconFileImage)
        createView.addSubview(iconCreateImage)
        createView.addSubview(createLabel)
       
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        createView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(88)
        }
        iconFileImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.height.width.equalTo(40)
        }
        createLabel.snp.makeConstraints {
            $0.left.equalTo(iconFileImage.snp.right).offset(12)
            $0.centerY.equalToSuperview()
        }
        iconCreateImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.width.equalTo(40)
        }
    }
    func isHiddenCreateBtn (isHidden: Bool) {
        if(isHidden){
            createView.isHidden = true
        }else {
            createView.isHidden = false

        }
    }
    func update(isUpgrade: Bool){
         isUpgradeUserDefaults = isUpgrade 
    }
    
    private func setupRx() {
        let tapCreateView = UITapGestureRecognizer(target: self, action: #selector(handleTapCreateView))
        createView.addGestureRecognizer(tapCreateView)
    }
    
    @objc func handleTapCreateView() {
        createAction?()
    }
}



