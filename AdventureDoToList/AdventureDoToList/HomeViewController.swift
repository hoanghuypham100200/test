//
//  HomeViewController.swift
//  AdventureDoToList
//
//  Created by Huy on 12/12/24.
//

import UIKit
import RxSwift
import RxCocoa
class HomeViewController: UIViewController {
//     var items = loadItems(from: "data")
    let disposeBag = DisposeBag()
    let dataSubject = PublishSubject<String>()
    
    let containerTopView = UIView()
    
    let kaiButton = UIButton()
    let voiceButton = UIButton()
    let moreButton = UIButton()
    
    let kaiImageView = UIImageView()
    let kaiLabel = UILabel()
    
    var collectionView : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        //MARK: configue
        
        //colection
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 360, height: 510)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ListCollectionViewCell")
        collectionView.register(CreateCell.self, forCellWithReuseIdentifier: "CreateCell")
        


        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // MARK: addview
        view.addSubview(containerTopView)
        
        containerTopView.addSubview(kaiButton)
        containerTopView.addSubview(voiceButton)
        containerTopView.addSubview(moreButton)
        
        kaiButton.addSubview(kaiImageView)
        kaiButton.addSubview(kaiLabel)
        
        view.addSubview(collectionView)

        //view
        containerTopView.backgroundColor = .white
        containerTopView.layer.borderWidth = 1
        containerTopView.layer.borderColor = UIColor.lightGray.cgColor
        
        //button
        kaiButton.backgroundColor = UIColor(hex: "#F5EEDF")
        kaiButton.layer.cornerRadius = 20
        
        voiceButton.setImage(UIImage(systemName: "speaker.wave.2",withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        voiceButton.tintColor = .black
        
        moreButton.setImage(UIImage(systemName: "ellipsis",withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        moreButton.tintColor = .black

        //label
        kaiLabel.textColor = .black
        kaiLabel.font = UIFont(name: "Bookerly", size: 20)
        kaiLabel.text = "Kai"
        
        //imageView
        kaiImageView.image = UIImage(named: "kai")
        kaiImageView.contentMode = .scaleAspectFit
        kaiImageView.clipsToBounds = true
        kaiImageView.layer.cornerRadius = 15
        collectionView.backgroundColor = .white
        

        
        
        //MARK: constraints
            //collectionView
        collectionView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(containerTopView.snp.bottom).offset(20)
        }
            // constraints view
        containerTopView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
            //constraints button
        kaiButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-6)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(86)
        }
        kaiLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            
        }
        kaiImageView.snp.makeConstraints{
            $0.height.width.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        
        moreButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-6)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        voiceButton.snp.makeConstraints{
            $0.right.equalTo(moreButton.snp.left).offset(-10)
            $0.bottom.equalToSuperview().offset(-6)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemsInSection = 1
        if(section == 0){
            itemsInSection = ItemData.items.count
        }
        if(section == 1){
            itemsInSection = 1
        }
        return itemsInSection
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
           
        if(indexPath.section == 1){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateCell.identifier, for: indexPath) as? CreateCell else {
                fatalError("Failed to dequeue ImageCell")
            }
            
            cell.createAction = { [weak self] in
                guard let _ = self else { return }
                let addVC = AddViewController()
                addVC.delegate = self
                addVC.modalPresentationStyle = .pageSheet
                self!.present(addVC, animated: true, completion: nil)

                
            }
            return cell
            
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
                fatalError("Failed to dequeue CustomCollectionViewCell")
            }
            cell.configure(with: ItemData.items[indexPath.row])

            return cell
        }
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItem = 6
        var height: Int = 0
        var cgSize: CGSize = .zero
        
        
        if indexPath.section == 1 {
            cgSize = CGSize(width:360 , height: 164)
        }
        
        if indexPath.section == 0 {
            if (numberOfItem % 2 == 1){
                height = (numberOfItem / 2 + 1) * 150 + 52
                cgSize = CGSize(width: 360 , height: height)
            }else{
                height = (numberOfItem / 2) * 150 + 52
                cgSize = CGSize(width: 360 , height: height)
            }
            
        }
        
        return cgSize
        
    }
}
extension HomeViewController: ReloadInfoDelegate {
    func reloadInfo() {
        print("reload")
        self.collectionView.reloadData()
    }
}


