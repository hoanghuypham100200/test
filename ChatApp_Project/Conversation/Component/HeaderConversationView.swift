//
//  HeaderView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//


import UIKit
import SnapKit

class HeaderConversationView: UIView {
    var isPopupVisible = false
    
    let containerView = UIView()
    let menuBarView = UIView()
    let lineView = UIView()
    var openAction: (() -> Void)?
    var backAction: (() -> Void)?
 

    
    let backButton = UIButton()
    let moreButton = UIButton()
    let titleLabel = UILabel()
  
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

        //button
        backButton.setImage(UIImage.back, for: .normal)
        moreButton.setImage(UIImage.more, for: .normal)
        //label
        titleLabel.text = "Conversation"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(menuBarView)
        containerView.addSubview(lineView)
        menuBarView.addSubview(backButton)
        menuBarView.addSubview(moreButton)
        menuBarView.addSubview(titleLabel)
        
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

        backButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        moreButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)

        }
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }


    }
    
    private func setupRx() {
        moreButton.addTarget(self, action: #selector(togglePopupVisible), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(handleTapBack), for: .touchUpInside)
    }
    
    @objc func togglePopupVisible () {
        openAction?()
    }
    
    @objc func handleTapBack () {
        backAction?()
    }
    
  
}


