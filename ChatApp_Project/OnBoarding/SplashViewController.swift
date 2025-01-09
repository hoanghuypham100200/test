//
//  SplashViewController.swift
//  ChatApp_Project
//
//  Created by Huy on 27/12/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
class SplashViewController: UIViewController {
    let containerView = UIView()
    let iconImageView = UIImageView()
    let writtenLabel = UILabel()
    let GPTLabel = UILabel()
    private let totalSubject = BehaviorSubject<String>(value: "")
    private let disposeBag = DisposeBag()

    
    let isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupRx()
    }
    
    private func setupUI() {
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        //image
        iconImageView.image = UIImage(named: "Icon")
        //label
        writtenLabel.text = "Written with"
        writtenLabel.textColor = .white
        writtenLabel.font = .systemFont(ofSize: 14, weight: .regular )
        GPTLabel.text = "ChatGPT & GPT-4o"
        GPTLabel.textColor = .white
        GPTLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(writtenLabel)
        containerView.addSubview(GPTLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(50)
        }
        writtenLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(GPTLabel.snp.top)
        }
        GPTLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-43)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupRx() {
        nextScreen()
        fetchRemoteConfig()
        saveMaxTotalToUserDefault()
    }
    private func saveMaxTotalToUserDefault() {
        totalSubject
            .asObservable()
            .subscribe(onNext: { [weak self] total in
                if let total = Int(total) {
                    UserDefaults.standard.set(total, forKey: "maximumFile")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchRemoteConfig() {
        let remoteConfigManager = RemoteConfigFileManager()
        remoteConfigManager.fetchRemoteConfig { success in

            if success {
                let totalFiles = remoteConfigManager.getValue(forKey: "total_files")
             
                self.totalSubject.onNext(totalFiles)
            } else {
                print("Failed to fetch Remote Config")
            }
        }
    }
    private func nextScreen(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if(self.isNotFirstTime) {
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
            else {
                let onBoardingVC = OnBoardViewController()
                self.navigationController?.pushViewController(onBoardingVC, animated: true)

            }
        }
    }
}
