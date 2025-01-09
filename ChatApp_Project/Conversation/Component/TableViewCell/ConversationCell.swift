//
//  ConversationCell.swift
//  ChatApp_Project
//
//  Created by Huy on 30/12/24.

import UIKit
import SnapKit

class ConversationCell: UITableViewCell {
    static let identifier = "ConversationCell"

    let containerView = UIView()
    private let textChatView = UIView()
    private let textChatLabel = UILabel()
    
    var leadingConstraint: Constraint?
    var trailingConstraint: Constraint?
    
    var chatMessage: String! {
        didSet {
            if(chatMessage == "assistant") {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
                textChatView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,.layerMinXMinYCorner]
            }
            else {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
                textChatView.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupConstraints()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    
    private func setupUI() {
        //view
        contentView.backgroundColor = UIColor(hex: "#08033C")
        containerView.backgroundColor = UIColor(hex: "#08033C")
        textChatView.backgroundColor = UIColor(hex: "#18204D")
       
        
        textChatView.layer.masksToBounds = true
        textChatView.layer.cornerRadius = 20
        

        //label
        textChatLabel.textColor = .white
        textChatLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textChatLabel.numberOfLines  = 0
    }
    
    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(textChatView)
        textChatView.addSubview(textChatLabel)
       
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        textChatView.snp.makeConstraints {
            leadingConstraint = $0.leading.equalToSuperview().constraint
            trailingConstraint = $0.trailing.equalToSuperview().constraint

            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.86)

//            $0.width.lessThanOrEqualTo()
            $0.top.bottom.equalToSuperview()
        }
        leadingConstraint?.isActive = true
        trailingConstraint?.isActive = false

       
        textChatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
  
        }
    }
    func configure (content: String) {
        textChatLabel.text = content
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupRx() {
        
    }


}




