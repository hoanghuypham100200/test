//
//  HeaderView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//


import UIKit
import SnapKit

class HeaderHomeView: UIView {
    let containerView = UIView()
    let menuBarView = UIView()
    let lineView = UIView()
    
    let logoImageView = UIImageView()
    let upgradeButton = UIButton()
    let upgradeLabel = UILabel()
    let upgradeImage = UIImageView()
    let settingButton = UIButton()
    
    var upgradeAction: (()->Void)?
    var settingAction: (()->Void)?

  
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
        lineView.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.05)
        //image
        logoImageView.image = UIImage(named: "Icon")
        upgradeImage.image = UIImage(named: "Upgrade")
        upgradeImage.tintColor = .black
        //button
        settingButton.setImage(UIImage(named: "Setting"), for: .normal)
        settingButton.layer.cornerRadius = 20
        settingButton.backgroundColor = UIColor(hex: "#18204D")
        settingButton.tintColor = .cyan
        
        upgradeButton.layer.cornerRadius = 20
        upgradeButton.backgroundColor = UIColor(hex: "#FFB017")
        
        //label
        upgradeLabel.text = "Upgrade"
        upgradeLabel.textColor = .black
        upgradeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(menuBarView)
        containerView.addSubview(lineView)
        menuBarView.addSubview(logoImageView)
        menuBarView.addSubview(upgradeButton)
        menuBarView.addSubview(settingButton)
        upgradeButton.addSubview(upgradeImage)
        upgradeButton.addSubview(upgradeLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        menuBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalTo(56)
            $0.leading.equalToSuperview().offset(16)
        }
        settingButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        upgradeButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(settingButton.snp.left).offset(-10)
            $0.width.equalTo(106)
        }
        upgradeImage.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        upgradeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupRx() {
        upgradeButton.addTarget(self, action: #selector(handleTap), for:.touchUpInside)
        settingButton.addTarget(self, action: #selector(handleTapSetting), for:.touchUpInside)
    }
    @objc func handleTap() {
        upgradeAction?()
    }
    @objc func handleTapSetting() {
        settingAction?()
    }
}


