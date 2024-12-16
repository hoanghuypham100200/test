//
//  SubCollectionViewCell.swift
//  AdventureDoToList
//
//  Created by Huy on 12/12/24.
//

import UIKit

class SubCollectionViewCell: UICollectionViewCell {
    static let identifier = "SubCollectionViewCell"

    let containerView = UIView ()
    let titleView = UIView ()
    let titleLabel = UILabel ()
    let contentLabel = UILabel ()
    let iconLabel = UILabel ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(iconLabel)
        containerView.addSubview(contentLabel)
        
        //configue
        containerView.backgroundColor = UIColor(hex: "#F5EEDF")
        containerView.layer.cornerRadius = 10
        
        titleLabel.text = "Paraphrasing Sentences Grammar"
        titleLabel.font = UIFont(name: "Bookerly Bold", size: 14)
        titleLabel.numberOfLines = 0
        
        iconLabel.text = "🥳"
        iconLabel.font = UIFont.systemFont(ofSize: 28)
        
        contentLabel.text = "Do grammar check for the given paragraph the given paragraph"
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Bookerly", size: 12)
        contentLabel.textColor = UIColor(hex: "#675B5B")
        //constraints
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(125)
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalToSuperview().offset(12)
        }
        iconLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right)
            $0.top.equalToSuperview().offset(12)
            
        }
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)

        }
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
