//
//  FilesCell.swift
//  ChatApp_Project
//
//  Created by Huy on 31/12/24.
//


import UIKit
import SnapKit

class FilesCell: UITableViewCell {
    static let identifier = "FilesCell"

    let containerView = UIView()
    
    let fileImageView = UIImageView()
    let chevronImageView = UIImageView()
    
    let nameFileLabel = UILabel()
    let sizeFileLabel = UILabel()
    

    
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

        containerView.backgroundColor = UIColor(hex: "#18204D")
        containerView.layer.cornerRadius = 15
        //image
        fileImageView.image = UIImage.file
        chevronImageView.image = UIImage.chevronRight
        //label
        nameFileLabel.text  = "Swift 5-9.PDF"
        nameFileLabel.textColor = .white
        nameFileLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        sizeFileLabel.text  = "7.5 MB"
        sizeFileLabel.textColor = UIColor(hex: "#8C90A6")
        sizeFileLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

       


    }
    
    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(fileImageView)
        containerView.addSubview(nameFileLabel)
        containerView.addSubview(sizeFileLabel)
        containerView.addSubview(chevronImageView)
       
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            
        }
        fileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(15)
            $0.height.width.equalTo(30)
            
        }
        nameFileLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalTo(fileImageView.snp.right).offset(12)
        }
        sizeFileLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.left.equalTo(fileImageView.snp.right).offset(12)
        }
        chevronImageView.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
       
    }
    func configure (text: String) {
        nameFileLabel.text = text
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupRx() {
        
    }


}




