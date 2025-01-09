//
//  SettingViewController.swift
//  CaptionAI
//
//  Created by Huy on 19/12/24.
//

import UIKit

class SettingViewController: UIViewController {
    let navigateBarView = UIView()
    let titleLabel = UILabel()
    let backButton = UIButton()
    let lineView = UIView()
    
    let containerView = UIView()
    let scrollView  = UIScrollView()
    let appLabel = UILabel()
    let ourAppLabel = UILabel()
    let aboutLabel = UILabel()
    

    let ourAppStackView = UIStackView()
    let appStackView = UIStackView()
    let aboutStackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadAndDisplayOurApp()
        loadAndDisplayApp()
        loadAndDisplayAbout()
        setupNotch()
        
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            navigateBarView.snp.makeConstraints {
                $0.leading.top.trailing.equalToSuperview()
                $0.height.equalTo(100)
            }
        } else {
            navigateBarView.snp.makeConstraints {
                $0.leading.top.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
        }
    }
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        containerView.backgroundColor = UIColor(hex: "#08033C")
        navigateBarView.backgroundColor = UIColor(hex: "#08033C")
        scrollView.backgroundColor = UIColor(hex: "#08033C")
        
        lineView.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.02)
        titleLabel.text = "Setting"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        
        backButton.setImage(UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        

        

        scrollView.contentInsetAdjustmentBehavior = .never

        appLabel.text = "APP"
        appLabel.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.55)
        appLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        ourAppLabel.text = "OUR APPS"
        ourAppLabel.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.55)
        ourAppLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        aboutLabel.text = "ABOUT"
        aboutLabel.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.55)
        aboutLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        ourAppStackView.axis = .vertical
        ourAppStackView.distribution = .fill
        ourAppStackView.backgroundColor =  UIColor(hex:"#18204D")

        ourAppStackView.layer.cornerRadius = 15
        
        appStackView.axis = .vertical
        appStackView.distribution = .fill
        appStackView.backgroundColor =  UIColor(hex:"#18204D")

        appStackView.layer.cornerRadius = 15
        
        aboutStackView.axis = .vertical
        aboutStackView.distribution = .fill
        aboutStackView.backgroundColor =  UIColor(hex:"#18204D")

        aboutStackView.layer.cornerRadius = 15
    }
    private func setupConstraints() {
        view.addSubview(scrollView)
        view.addSubview(navigateBarView)
        navigateBarView.addSubview(titleLabel)
        navigateBarView.addSubview(backButton)
        navigateBarView.addSubview(lineView)
        scrollView.addSubview(containerView)
        containerView.addSubview(appLabel)
        containerView.addSubview(ourAppStackView)
        containerView.addSubview(ourAppLabel)
        containerView.addSubview(appStackView)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(aboutStackView)
        
       
        lineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-13)
            $0.centerX.equalToSuperview()
        }
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-13)
            $0.height.width.equalTo(20)
            $0.leading.equalToSuperview().offset(23.5)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigateBarView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview() // Pin to the view's edges
          }

        containerView.snp.makeConstraints { make in
              make.edges.equalToSuperview() // Match scrollView's edges
              make.width.equalTo(scrollView.snp.width) // Important: Match scrollView's width for vertical scrolling
          }
   
        appLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
        }
        
        // App StackView Constraints
        appStackView.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Our App Label Constraints
        ourAppLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(appStackView.snp.bottom).offset(40)
        }
        
        // Our App StackView Constraints
        ourAppStackView.snp.makeConstraints { make in
            make.top.equalTo(ourAppLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // About Label Constraints
        aboutLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(ourAppStackView.snp.bottom).offset(40)
        }
        
        // About StackView Constraints
        aboutStackView.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20) // Bottom constraint to the containerView
        }
    }
    private func loadAndDisplayOurApp() {
        let items = loadApp(from: "appSetting")
           for item in items! {
               let ourAppView = OurAppView()
               ourAppView.configure(title: item.title, logo: item.image, resizeImage: "logo")
               ourAppStackView.addArrangedSubview(ourAppView)
               
           }
    }
    private func loadAndDisplayAbout() {
        let items = loadAboutApp(from: "aboutSetting")
           for item in items! {
               let ourAppView = OurAppView()
               ourAppView.configure(title: item.title, logo: item.image,resizeImage: "nil")
               ourAppView.linkAction = { [weak self] in
                   guard let _ = self else { return }
                   if let url = URL(string: item.link) {
                     UIApplication.shared.open(url)
                 }
               }
               aboutStackView.addArrangedSubview(ourAppView)
               
           }
    }
    private func loadAndDisplayApp() {
        let ourAppView = OurAppView()
        ourAppView.configure(title: "Change App icon", logo: "star",resizeImage:"nil")
            appStackView.addArrangedSubview(ourAppView)
            ourAppView.linkAction = { [weak self] in
            guard let _ = self else { return }
                let changeIconVC = ChangeIconViewController()
            self?.navigationController?.pushViewController(changeIconVC, animated: true)
            
        }
    }
}



