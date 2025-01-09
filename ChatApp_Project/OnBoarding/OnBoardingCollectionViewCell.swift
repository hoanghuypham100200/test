//
//  OnBoadingCollectionViewCell.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnBoadingCollectionViewCell"

    //view
    let containerView = UIView()
    let titleView = UIView()
    //label
    let titleLabel = UILabel()
    let descLabel = UILabel()
    //image
    let titleImageView = UIImageView()
    let contentMidImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRx()
        setupNotch()
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            contentMidImageView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(420)
            }
        } else {
            contentMidImageView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(300)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupRx()
    }
    
    private func setupUI(){
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        //image
        titleImageView.image = UIImage(named: "PDF")
        
        //label
        titleLabel.text = "ChatPDF"
        titleLabel.textColor = UIColor(hex: "#E53855")
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        descLabel.textColor = .white
        descLabel.font = .systemFont(ofSize: 32, weight: .regular)
        descLabel.numberOfLines = 0
        

    }
    private func setupConstraints(){
        contentView.addSubview(containerView)
        containerView.addSubview(contentMidImageView)
        containerView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(titleImageView)
        titleView.addSubview(descLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
      
        titleView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(contentMidImageView.snp.bottom).offset(45)
            $0.width.equalTo(333)
        }
        titleImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3.5)
            $0.left.equalTo(titleImageView.snp.right).offset(10)
        }
        descLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
    }
    
    func configure(image:String, desc:String){
        contentMidImageView.image = UIImage(named: image)
        descLabel.text = desc
    }
    
    private func setupRx(){

    }
    
    
}
