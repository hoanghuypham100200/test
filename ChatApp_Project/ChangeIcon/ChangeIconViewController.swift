//
//  ChangeIconViewController.swift
//  ChatApp_Project
//
//  Created by Huy on 27/12/24.
//


import UIKit
import SnapKit

class ChangeIconViewController: UIViewController {
    let navigateBarView = UIView()
    let titleLabel = UILabel()
    let backButton = UIButton()
    let lineView = UIView()
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    let iconImageView = UIImageView()
    let labelInButton = UILabel()
    let selectButton = UIButton()
    var currenIconApp = ""
    
    let imageArray = ["blackLogo","pinkLogo","greenLogo"]
    
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupRx()
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
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#08033C")
       
        
        lineView.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.02)
        titleLabel.text = "Change App Icon"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .white
        
        backButton.setImage(UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        backButton.tintColor = .white
       
        
        selectButton.backgroundColor = UIColor(hex: "#E53855")
        selectButton.layer.cornerRadius = 20
        
        labelInButton.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        labelInButton.textColor = .white
        labelInButton.text = "Select"
        
        layout.itemSize = CGSize(width: 104, height: 104)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hex: "#08033C")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChangeIconCell.self, forCellWithReuseIdentifier: ChangeIconCell.identifier)
        
        iconImageView.image = UIImage.tickwhite
    }
    
    private func setupConstraints() {
        view.addSubview(navigateBarView)
        view.addSubview(collectionView)
        view.addSubview(selectButton)
        navigateBarView.addSubview(titleLabel)
        navigateBarView.addSubview(backButton)
        navigateBarView.addSubview(lineView)
        selectButton.addSubview(labelInButton)
        selectButton.addSubview(iconImageView)
        
        navigateBarView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
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
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(navigateBarView.snp.bottom).offset(20)
            $0.bottom.equalTo(selectButton.snp.top).inset(16)
        }
        selectButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16)
            $0.height.equalTo(60)
            $0.width.equalTo(200)
            $0.bottom.equalToSuperview().inset(49)
        }
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(54.5)
            $0.height.width.equalTo(20)
        }
        labelInButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(54.5)
        }
    }
    
    private func setupRx() {
        backButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(selectAction), for: .touchUpInside)
        getCurrentAppIcon()
    }
    
    func getCurrentAppIcon() {
        if let iconName = UIApplication.shared.alternateIconName {
            if (iconName == "blackLogoIconapp") {
                selectedIndexPath = IndexPath(row: 0, section: 0)
            } else if (iconName == "pinkLogoIconapp") {
                selectedIndexPath = IndexPath(row: 1, section: 0)
            } else {
                selectedIndexPath = IndexPath(row: 2, section: 0)
            }
        } else {
            print("Default Icon")
        }
    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func selectAction(){
        if UIApplication.shared.supportsAlternateIcons {
            UIApplication.shared.setAlternateIconName(currenIconApp) { error in
                if let error = error {
                    print("Error changing icon: \(error.localizedDescription)->",self.currenIconApp)
                } else {
                    print("Icon changed successfully!")
                }
            }
        }else {
            print("fail")
        }
    }
   
}

extension ChangeIconViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChangeIconCell.identifier, for: indexPath) as? ChangeIconCell else {
            fatalError("Failed to dequeue CustomCollectionViewCell")
        }
        if selectedIndexPath == indexPath {
            cell.addBorder()
            currenIconApp = imageArray[indexPath.row] + "Iconapp"
        } else {
            cell.removeBorder()
        }
        
        cell.configure(with: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != indexPath {
                    selectedIndexPath = indexPath
        }
        collectionView.reloadData()
    }
    
    
}
