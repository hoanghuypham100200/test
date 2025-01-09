//
//  OnBoardViewController.swift
//  ChatApp_Project
//
//  Created by Huy on 27/12/24.
//

import UIKit
import SnapKit

struct DeviceHelper {
    static let isHasNotch: Bool = {
        let size = UIScreen.main.bounds.size
        return size.width / size.height < 375.0 / 667.0
    }()
}

class OnBoardViewController: UIViewController {
    //variable
    var currentIndex: Int = 0
    var imageArray = [
        (image:"OnBoarding1",desc:"Ask anything about PDF file!"),
        (image:"OnBoarding2",desc:"Work with PDF in seconds"),

    ]
    //view
    let containerView = UIView()
    let midView = UIView()
    let botView = UIView()
    // collectionView
    var OBcollectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
   
    //Button
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupRx()
        setupNotch()
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            OBcollectionView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(80)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(600)
            }
            nextButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview()
                $0.height.equalTo(60)
                $0.width.equalTo(333)
            }
            
        } else {
            OBcollectionView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(600)
            }
            nextButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(40)
                $0.height.equalTo(60)
                $0.width.equalTo(333)
            }
            
        }
    }
    //MARK: setupUI
    private func setupUI() {
        //navigate
        navigationItem.hidesBackButton = true
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        //collectionView
        layout.itemSize = CGSize(width: view.bounds.width, height: 600)
        layout.scrollDirection = .horizontal
        
        OBcollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        OBcollectionView.dataSource = self
        OBcollectionView.delegate = self
        OBcollectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
        OBcollectionView.isScrollEnabled = false
        OBcollectionView.backgroundColor = UIColor(hex: "#08033C")
        

        //button
        nextButton.setTitle( "Let's start", for: .normal)
        nextButton.backgroundColor = UIColor(hex: "#E53855")
        nextButton.layer.cornerRadius = 15
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
       

    }
    //MARK: setupConstraints
    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(midView)
        containerView.addSubview(botView)
        midView.addSubview(OBcollectionView)
        botView.addSubview(nextButton)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        //midview
        midView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(botView.snp.top)
        }
        OBcollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
        
        //botView
        botView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(170)
        }
       
     
    }
    //MARK: setupRx
    private func setupRx() {
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    //MARK: function
    @objc func didTapNext() {
        currentIndex += 1
        if (currentIndex > imageArray.count - 1) {
            let DSVC = DSViewController()
            navigationController?.pushViewController(DSVC, animated: true)
        } else {
            let indexPath = IndexPath(item: currentIndex, section: 0)
            OBcollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            //set text in button
            nextButton.setTitle("Continue", for: .normal)
        }
        
    }
}

extension OnBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count // Số lượng cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as? OnBoardingCollectionViewCell else {
            fatalError("Failed to dequeue CustomCollectionViewCell")
        }
        cell.configure(image: imageArray[indexPath.row].image, desc: imageArray[indexPath.row].desc)
       
        return cell
    }
    
}

