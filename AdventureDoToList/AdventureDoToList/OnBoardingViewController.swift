//
//  BoardingViewController.swift
//  AdventureDoToList
//
//  Created by Huy on 11/12/24.
//

import UIKit


class OnBoardingViewController: UIViewController {
    var step = 0

    let containerBottomView = UIView()
    let containerTopView = UIView()
    let labelView = UIView()
    let buttonView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let continueButton = UIButton()
    let imageView = UIImageView()
    let iconImageView = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(containerBottomView)
        view.addSubview(containerTopView)
        containerBottomView.addSubview(labelView)
        containerBottomView.addSubview(buttonView)

        labelView.addSubview(titleLabel)
        labelView.addSubview(subtitleLabel)
        
        buttonView.addSubview(continueButton)
        
        containerTopView.addSubview(imageView)
        continueButton.addSubview(iconImageView)
        //MARK: configue
            //view
        containerBottomView.backgroundColor = .white
        labelView.backgroundColor = .white
        buttonView.backgroundColor = .white
        
        //imageview
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFill
        
        iconImageView.image = UIImage(systemName: "chevron.right.2",withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        iconImageView.tintColor = .black
        //titleLabel

        titleLabel.attributedText = createAttributedTitleString(
                   regularText: "Introducing",
                   boldText: "KAI",
                   fontSize: 32
               )
        
            // subtitleLabel
        subtitleLabel.attributedText = createAttributedTitleString(
            regularText: "Personal AI", 
            boldText: "in Your Pocket",
            fontSize: 24,
            isReverse: true
        )


            //continueButton
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.backgroundColor = UIColor(hex:"#E2D5BD")
        continueButton.layer.cornerRadius = 15
        continueButton.titleLabel?.font = UIFont(name: "Bookerly Bold", size: 20)
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)


        
        //MARK: constraints
        containerBottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(234)
        }
        
        labelView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview()
            make.height.equalTo(84)
            
        }
        buttonView.snp.makeConstraints{ make in
            make.top.equalTo(labelView.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-25)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(70)
        }
        titleLabel.snp.makeConstraints{make in
            make.top.leading.equalToSuperview()
            make.height.equalTo(42)
        }
        subtitleLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.height.equalTo(32)

        }
        continueButton.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        containerTopView.snp.makeConstraints{make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(containerBottomView.snp.top)
            
        }
        iconImageView.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18)
        }
        imageView.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
// MARK: function
    @objc func continueButtonAction(){
        step = step + 1
        
        if(step == 1){
            titleLabel.attributedText = createAttributedTitleString(
                       regularText: "Boost",
                       boldText: "Productivity",
                       fontSize: 32
                   )
            
                // subtitleLabel
            subtitleLabel.attributedText = createAttributedTitleString(
                regularText: "Custom your",
                boldText: "Daily Tasks",
                fontSize: 24
            )
            imageView.image = UIImage(named: "Image 1")

        }
        if(step == 2){
            titleLabel.attributedText = createAttributedTitleString(
                       regularText: "Unleash",
                       boldText: "Creativity",
                       fontSize: 32
                   )
            
                // subtitleLabel
            subtitleLabel.attributedText = createAttributedTitleString(
                regularText: "Turn text",
                boldText: "Into Image",
                fontSize: 24
            )
            
            imageView.image = UIImage(named: "Image 2")

        }
        if(step == 3){
            titleLabel.attributedText = createAttributedTitleString(
                       regularText: "Upload & Ask",
                       boldText: "Vision",
                       fontSize: 32
                   )
            
                // subtitleLabel
            subtitleLabel.attributedText = createAttributedTitleString(
                regularText: "Ask anything in",
                boldText: "Image",
                fontSize: 24
            )

            imageView.image = UIImage(named: "Image 3")

            let VC = StoreController()
            navigationController?.pushViewController(VC, animated: true)
        }
       
    }


}
