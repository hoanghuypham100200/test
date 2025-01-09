//
//  HeaderView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//


import UIKit
import SnapKit

class HeaderDSView: UIView {
    let containerView = UIView()
    let menuBarView = UIView()
    
    let premiumView = UIView()
    let premiumLabel = UILabel()
    let closeButton = UIButton()
    
    var closeAction:(()->Void)?
  
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
        premiumView.backgroundColor = UIColor(hex: "#FFB017")
        premiumView.layer.cornerRadius = 18
      

        //button
        closeButton.setImage(UIImage.close, for: .normal)
        closeButton.layer.cornerRadius = 20
        
        //label
        premiumLabel.text = "PREMIUM"
        premiumLabel.textColor = .black
        premiumLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(menuBarView)
        menuBarView.addSubview(premiumView)
        menuBarView.addSubview(closeButton)
        premiumView.addSubview(premiumLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        menuBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }

        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        premiumView.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(101)
            $0.leading.equalToSuperview().offset(16)
        }
        premiumLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupRx() {
        closeButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    @objc func handleTap() {
        closeAction?()
    }
}


