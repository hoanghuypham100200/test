//
//  ChangeIconCell.swift
//  ChatApp_Project
//
//  Created by Huy on 9/1/25.
//
import UIKit
import SnapKit
class ChangeIconCell: UICollectionViewCell {
    static let identifier = "ChangeIconCell"

    let containerView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
    }
    private func setupConstrains() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setupRx() {
        
    }
    
    func configure(with image:String) {
        imageView.image = UIImage(named: image)
    }
    
    func addBorder() {
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor(hex: "#E53855").cgColor
    }
    
    func removeBorder() {
        containerView.layer.borderWidth = 0
    }
}

