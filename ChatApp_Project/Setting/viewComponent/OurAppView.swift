//
//  OurAppView.swift
//  CaptionAI
//
//  Created by Huy on 21/12/24.
//

import UIKit

class OurAppView: UIView {
    private let titleLabel = UILabel()
    private let containerButton = UIButton()
    private let imageView = UIImageView()
    var linkAction: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstaints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstaints()
    }
    
    private func setupView (){
        

        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15,weight: .medium)
     
        containerButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)

      

    }
    private func setupConstaints(){
        addSubview(containerButton)
        containerButton.addSubview(titleLabel)
        containerButton.addSubview(imageView)
       
        
        containerButton.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(16)
            make.width.equalTo(329)
        }
        titleLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(12)
        }
        imageView.snp.makeConstraints{ make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
    }
    func configure(title: String, logo: String, resizeImage: String) {
          titleLabel.text = title
        imageView.image = UIImage(named: logo)
        if (resizeImage == "logo"){
            imageView.snp.makeConstraints{ make in
                make.height.equalTo(40)
                make.width.equalTo(40)
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }else {
            imageView.snp.makeConstraints{ make in
                make.height.equalTo(25)
                make.width.equalTo(25)
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
      }
    @objc private func handleButtonTap() {
        linkAction?()
    }
}




