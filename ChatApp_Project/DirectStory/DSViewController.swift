//
//  DSViewController.swift
//  ChatApp_Project
//
//  Created by Huy on 27/12/24.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa
protocol UpdateUpgradeDelegate: AnyObject {
    func updateUpgradeDelegate(isUpgrade: Bool)
}

class DSViewController: UIViewController {
    private let versionSubject = BehaviorSubject<String>(value: "") // Default version
    private let disposeBag = DisposeBag()
    weak var delegate: UpdateUpgradeDelegate?

    
    let containerView = UIView()
    let topView = UIView()
    let midView = UIView()
    let botView = UIView()
    
    let headerDSView = HeaderDSView()
    let contentMidDSView = ContentMidDSView()
    let footerDSView = FooterDSView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupRx()
        fetchRemoteConfig()
        setupNotch()
    }
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            containerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(98)
            }
            headerDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            midView.snp.makeConstraints {
                $0.top.equalTo(topView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(botView.snp.top)
            }
            contentMidDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            botView.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(200)
            }
            footerDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
        } else {
            containerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            headerDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            midView.snp.makeConstraints {
                $0.top.equalTo(topView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(botView.snp.top)
            }
            contentMidDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            botView.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(150)
            }
            footerDSView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
        }
    }
    
    private func setupUI() {
        //navigate
        navigationController?.setNavigationBarHidden(true, animated: false)
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
       
        
    }
    
    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(topView)
        containerView.addSubview(midView)
        containerView.addSubview(botView)
        
        topView.addSubview(headerDSView)
        midView.addSubview(contentMidDSView)
        botView.addSubview(footerDSView)
        
        
        
        
    }
    
    private func setupRx() {
        versionSubject
            .asObservable()
            .subscribe(onNext: { [weak self] version in
                self?.footerDSView.updateVersion(version)
                self?.contentMidDSView.updateVersion(version)
            })
            .disposed(by: disposeBag)
        
        handleContinueBtn()
        handleCloseBtn()
    }
    private func handleContinueBtn() {
       
        footerDSView.continueAction = { [weak self] in
            guard let _ = self else {return}
            UserDefaults.standard.set(true, forKey: "isUpgrade")
            UserDefaults.standard.set(true, forKey: "isNotFirstTime")

            self!.delegate?.updateUpgradeDelegate(isUpgrade: true)

            if self?.navigationController != nil {
                let homeVC = HomeViewController()
                self?.navigationController?.pushViewController(homeVC, animated: true)
            } else {
                self?.dismiss(animated: true)
                
            }
        }
    }
    private func handleCloseBtn() {

        headerDSView.closeAction = { [weak self] in
            guard let _ = self else {return}
            UserDefaults.standard.set(false, forKey: "isUpgrade")
            
            UserDefaults.standard.set(true, forKey: "isNotFirstTime")

            if self?.navigationController != nil {
                let homeVC = HomeViewController()
                self?.navigationController?.pushViewController(homeVC, animated: true)
            } else {
                self?.dismiss(animated: true)
            }
        }
    }
    private func fetchRemoteConfig() {
        let remoteConfigManager = RemoteConfigManager()
        remoteConfigManager.fetchRemoteConfig { success in
            
            if success {
                let versionDS = remoteConfigManager.getValue(forKey: "version_DS")
                print("Fetched Remote Config: \(versionDS)")
                self.versionSubject.onNext(versionDS)
            } else {
                print("Failed to fetch Remote Config")
            }
        }
    }
}

