//
//  footerView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//




import UIKit
import SnapKit

class FooterDSView: UIView {
    
    let containerView = UIView()
    let termView  = UIView()
    let descView = UIView()
    
    let iconDescImageView = UIImageView()
    
    let descLabel = UILabel()
    let termsLabel = UILabel()
    let restoreLabel = UILabel()
    let privacyLabel = UILabel()
    
    let continueButton  = UIButton()
    var continueAction :(()->Void)?
  
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
       
        //label
        descLabel.text = "CANCEL ANYTIME"
        descLabel.textColor = .white
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        termsLabel.text = "Terms of Use"
        termsLabel.textColor = UIColor(hex: "#8C90A6")
        termsLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        restoreLabel.text = "Restore"
        restoreLabel.textColor = UIColor(hex: "#8C90A6")
        restoreLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        privacyLabel.text = "Privacy Policy"
        privacyLabel.textColor = UIColor(hex: "#8C90A6")
        privacyLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        //image
        iconDescImageView.image = UIImage.shield
        //button
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        continueButton.layer.cornerRadius = 15
        continueButton.backgroundColor = .black.withAlphaComponent(0.3)
        
      
       
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(descView)
        containerView.addSubview(termView)
        containerView.addSubview(continueButton)
        descView.addSubview(descLabel)
        descView.addSubview(iconDescImageView)
        termView.addSubview(termsLabel)
        termView.addSubview(restoreLabel)
        termView.addSubview(privacyLabel)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        descView.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.width.equalTo(125)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        iconDescImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(12)
        }
        descLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iconDescImageView.snp.right).offset(5)
        }
        continueButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descView.snp.bottom).offset(15)
        }
        termView.snp.makeConstraints {
            $0.width.equalTo(291)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(continueButton.snp.bottom).offset(40)
        }
        termsLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        restoreLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        privacyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
       
    }
    
    private func setupRx() {
        continueButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    @objc func handleTap() {
        continueAction?()
    }
    func updateVersion(_ version: String) {
        
        switch version {
               case "v1":
                continueButton.backgroundColor = .black.withAlphaComponent(0.3)
                descView.isHidden = false
                descLabel.text = "CANCEL ANYTIME"
               case "v2":
                continueButton.backgroundColor = UIColor(hex: "#E53855")
                descView.isHidden = false
                descLabel.text = "BUY ONCE - USE FOREVER"
               default:
                descView.isHidden = true
        }
        
        descView.snp.updateConstraints {
            $0.height.equalTo(14)
            $0.width.equalTo(version == "v1" ? 125 : 176)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}



