//
//  HomeCollectionViewCell.swift
//  AdventureDoToList
//
//  Created by Huy on 12/12/24.
//

import UIKit



class ListCollectionViewCell: UICollectionViewCell {

    static let identifier = "ListCollectionViewCell"

        let containerTopView = UIView()
        let logoLabel = UILabel()
        let titleLabel = UILabel()
        let descriptionLabel = UILabel()
        let chatButton = UIButton()
    
    var collectionView : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //MARK: configue
        containerTopView.backgroundColor = .white
        
        //colection
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 175, height: 140)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(SubCollectionViewCell.self, forCellWithReuseIdentifier: "SubCollectionViewCell")
        collectionView.isScrollEnabled = false
//        collectionView.showsVerticalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self
        
        logoLabel.text = "K"
        logoLabel.font = UIFont(name: "Bookerly Bold", size: 20)
        logoLabel.backgroundColor = UIColor(hex: "#F5EEDF")
        logoLabel.textAlignment = .center
        logoLabel.layer.cornerRadius = 20
        logoLabel.clipsToBounds = true
        
        titleLabel.text = "English Tutor"
        titleLabel.font = UIFont(name: "Bookerly Bold", size: 14)
        
        descriptionLabel.text = "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Bookerly", size: 12)
        descriptionLabel.textColor = UIColor(hex: "#675B5B")

        chatButton.setTitle("Chat", for: .normal)
        chatButton.titleLabel?.font = UIFont(name: "Bookerly Bold", size: 14)
        chatButton.backgroundColor = UIColor(hex: "#F5EEDF")
        chatButton.layer.cornerRadius = 15
        chatButton.setTitleColor(.black, for: .normal)
        //MARK: Add view
        contentView.addSubview(containerTopView)
        containerTopView.addSubview(logoLabel)
        containerTopView.addSubview(titleLabel)
        containerTopView.addSubview(descriptionLabel)
        containerTopView.addSubview(chatButton)
        contentView.addSubview(collectionView)

        
        //MARK: constraints
        containerTopView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        logoLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalTo(227)
            $0.left.equalTo(logoLabel.snp.right).offset(12)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.width.equalTo(227)
            $0.left.equalTo(logoLabel.snp.right).offset(12)
        }
        chatButton.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.width.equalTo(60)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
        collectionView.snp.makeConstraints{
            $0.top.equalTo(containerTopView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with item: Item) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        
      
    }
}

// MARK: CreateCell
class CreateCell: UICollectionViewCell {

    static let identifier = "CreateCell"
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let createButton = UIButton()
    
    var createAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        setupRx()
    }
    
    private func setupViews() {
        iconImageView.image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        iconImageView.tintColor = UIColor(hex: "#998A8A")
        
        titleLabel.textColor = UIColor(hex: "#998A8A")
        titleLabel.text = "Create your Tutor"
        titleLabel.font = UIFont(name: "Bookerly", size: 16)
    }
    
    private func setupConstraints() {
        contentView.addSubview(createButton)
        createButton.addSubview(titleLabel)
        createButton.addSubview(iconImageView)

        
        createButton.snp.makeConstraints{
            $0.edges.equalToSuperview().offset(10)
        }
        iconImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(iconImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupRx() {
        createButton.addTarget(self, action: #selector(createTarget), for: .touchUpInside)
    }
    
    @objc func createTarget() {
        createAction?()
    }
   
}


extension ListCollectionViewCell: UICollectionViewDelegate {
    
}
extension ListCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCollectionViewCell.identifier, for: indexPath) as? SubCollectionViewCell else {
            fatalError("Failed to dequeue SubCollectionViewCell")
        }
        return cell
    
    }
}

