//
//  DemoView.swift
//  ChatApp_Project
//
//  Created by Huy on 6/1/25.
//

import Foundation
import SnapKit
import UIKit
import RxSwift

class DemoView: UIView {
    
    private lazy var premiumButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    var premiumAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    private func setupViews() {
        premiumButton.backgroundColor = .orange
    }
    
    private func setupConstraints() {
        addSubview(premiumButton)
        
        premiumButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 50))
        }
    }
    
    private func setupRx() {
        premiumButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                owner.premiumAction?()
            })
            .disposed(by: disposeBag)
    }
}
