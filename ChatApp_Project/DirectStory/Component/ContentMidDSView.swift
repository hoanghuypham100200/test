//
//  ContentMidView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//



import UIKit
import SnapKit

class ContentMidDSView: UIView {
    let containerView = UIView()
    let featuresImageView = UIImageView()
    
    let weeklyButton = UIButton()
    let yearlyButton = UIButton()
    
    let weekTitleLabel = UILabel()
    let weekPriceLabel = UILabel()
    let weekDescLabel = UILabel()
    
    let yearTitleLabel = UILabel()
    let yearPriceLabel = UILabel()
    let yearDescLabel = UILabel()
    
    let bestOfferLabel = UILabel()
    let saveLabel = UILabel()
    
    let wTickImageView = UIImageView()
    let yTickImageView = UIImageView()

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRx()
        setupNotch()

    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupRx()
        setupNotch()
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            featuresImageView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(32)
                $0.height.equalTo(243)
            }
            weeklyButton.snp.makeConstraints {
                $0.top.equalTo(featuresImageView.snp.bottom).offset(55)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalTo(171.5)
                $0.height.equalTo(150)
            }
            weekTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(16)
                $0.leading.equalToSuperview().offset(16)
            }
            weekPriceLabel.snp.makeConstraints {
                $0.top.equalTo(weekTitleLabel.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(16)
            }
            weekDescLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-16)
                $0.leading.equalToSuperview().offset(16)
            }
            wTickImageView.snp.makeConstraints {
                $0.height.width.equalTo(22)
                $0.trailing.equalToSuperview().offset(-16)
                $0.bottom.equalToSuperview().offset(-16)
            }
            
            
            yearlyButton.snp.makeConstraints {
                $0.top.equalTo(featuresImageView.snp.bottom).offset(55)
                $0.trailing.equalToSuperview().offset(-20)
                $0.width.equalTo(171.5)
                $0.height.equalTo(150)
            }
            yearTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(16)
                $0.leading.equalToSuperview().offset(16)
            }
            saveLabel.snp.makeConstraints {
                $0.bottom.equalTo(yearPriceLabel.snp.top).offset(-7)
                $0.left.equalTo(yearTitleLabel.snp.right).offset(5)
            }
            yearPriceLabel.snp.makeConstraints {
                $0.top.equalTo(yearTitleLabel.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(16)
            }
            yearDescLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-16)
                $0.leading.equalToSuperview().offset(16)
            }
            yTickImageView.snp.makeConstraints {
                $0.height.width.equalTo(22)
                $0.trailing.equalToSuperview().offset(-16)
                $0.bottom.equalToSuperview().offset(-16)
            }
            bestOfferLabel.snp.makeConstraints {
                $0.bottom.equalTo(yearlyButton.snp.top).offset(10)
                $0.centerX.equalTo(yearlyButton)
                $0.height.equalTo(20)
                $0.width.equalTo(84)
            }
        } else {
            featuresImageView.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(20)
                $0.height.equalTo(243)
            }
            weeklyButton.snp.makeConstraints {
                $0.top.equalTo(featuresImageView.snp.bottom).offset(30)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalTo(160)
                $0.height.equalTo(150)
            }
            weekTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(16)
                $0.leading.equalToSuperview().offset(16)
            }
            weekPriceLabel.snp.makeConstraints {
                $0.top.equalTo(weekTitleLabel.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(16)
            }
            weekDescLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-16)
                $0.leading.equalToSuperview().offset(16)
            }
            wTickImageView.snp.makeConstraints {
                $0.height.width.equalTo(22)
                $0.trailing.equalToSuperview().offset(-16)
                $0.bottom.equalToSuperview().offset(-16)
            }
            
            
            yearlyButton.snp.makeConstraints {
                $0.top.equalTo(featuresImageView.snp.bottom).offset(30)
                $0.trailing.equalToSuperview().offset(-20)
                $0.width.equalTo(160)
                $0.height.equalTo(150)
            }
            yearTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(16)
                $0.leading.equalToSuperview().offset(16)
            }
            saveLabel.snp.makeConstraints {
                $0.bottom.equalTo(yearPriceLabel.snp.top).offset(-7)
                $0.left.equalTo(yearTitleLabel.snp.right).offset(5)
            }
            yearPriceLabel.snp.makeConstraints {
                $0.top.equalTo(yearTitleLabel.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(16)
            }
            yearDescLabel.snp.makeConstraints {
                $0.bottom.equalToSuperview().offset(-16)
                $0.leading.equalToSuperview().offset(16)
            }
            yTickImageView.snp.makeConstraints {
                $0.height.width.equalTo(22)
                $0.trailing.equalToSuperview().offset(-16)
                $0.bottom.equalToSuperview().offset(-16)
            }
            bestOfferLabel.snp.makeConstraints {
                $0.bottom.equalTo(yearlyButton.snp.top).offset(10)
                $0.centerX.equalTo(yearlyButton)
                $0.height.equalTo(20)
                $0.width.equalTo(84)
            }
        }
    }
    //MARK: setupUI
    private func setupUI() {
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        //label
        weekTitleLabel.text = "Weekly Trial"
        weekTitleLabel.textColor = .white
        weekTitleLabel.font = .systemFont(ofSize: 18,weight: .bold)
        
        weekPriceLabel.text = "$2.99"
        weekPriceLabel.textColor = .white
        weekPriceLabel.font = .systemFont(ofSize: 18,weight: .semibold)
        
        weekDescLabel.text = "3 days free"
        weekDescLabel.textColor = .white
        weekDescLabel.font = .systemFont(ofSize: 14,weight: .semibold)
        
        yearTitleLabel.text = "Yearly"
        yearTitleLabel.textColor = .white
        yearTitleLabel.font = .systemFont(ofSize: 18,weight: .bold)
        
        
        yearPriceLabel.text = "$24.99"
        yearPriceLabel.textColor = .white
        yearPriceLabel.font = .systemFont(ofSize: 18,weight: .semibold)
        
        yearDescLabel.text = "billed yearly"
        yearDescLabel.textColor = .white
        yearDescLabel.font = .systemFont(ofSize: 14,weight: .semibold)
        
        bestOfferLabel.text = "Best Offer"
        bestOfferLabel.textColor = .white
        bestOfferLabel.font = .systemFont(ofSize: 13, weight: .heavy)
        bestOfferLabel.backgroundColor = UIColor(hex: "#201963").withAlphaComponent(0.5)
        bestOfferLabel.textAlignment = .center
        bestOfferLabel.layer.cornerRadius = 10
        bestOfferLabel.clipsToBounds = true
        
        saveLabel.text = "Save 83%"
        saveLabel.textColor = UIColor(hex: "#FFB017")
        saveLabel.font = .systemFont(ofSize: 14,weight: .bold)
        //image
        wTickImageView.image = UIImage.tick
        wTickImageView.isHidden = true

        yTickImageView.image = UIImage.tick
        yTickImageView.isHidden = true

        featuresImageView.image = UIImage.feature
        //button
        weeklyButton.backgroundColor = .clear
        weeklyButton.layer.cornerRadius = 20
        weeklyButton.layer.borderWidth = 2
        weeklyButton.layer.borderColor = UIColor(hex: "#201963").withAlphaComponent(0.5).cgColor
        
        yearlyButton.layer.cornerRadius = 20
        yearlyButton.layer.borderWidth = 2
        yearlyButton.layer.borderColor = UIColor(hex: "#201963").withAlphaComponent(0.5).cgColor
    }
    //MARK: setupConstraints
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(featuresImageView)
        containerView.addSubview(weeklyButton)
        containerView.addSubview(yearlyButton)
        containerView.addSubview(bestOfferLabel)
        weeklyButton.addSubview(weekTitleLabel)
        weeklyButton.addSubview(weekPriceLabel)
        weeklyButton.addSubview(weekDescLabel)
        weeklyButton.addSubview(wTickImageView)
        
        yearlyButton.addSubview(yearTitleLabel)
        yearlyButton.addSubview(saveLabel)
        yearlyButton.addSubview(yearPriceLabel)
        yearlyButton.addSubview(yearDescLabel)
        yearlyButton.addSubview(yTickImageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private func setupRx() {
        weeklyButton.addTarget(self, action: #selector(handleTapWButton), for: .touchUpInside)
        yearlyButton.addTarget(self, action: #selector(handleTapYButton), for: .touchUpInside)
    }
    @objc func handleTapWButton() {
        weeklyButton.layer.borderColor = UIColor(hex: "#E53855").cgColor
        wTickImageView.isHidden = false
        
        yearlyButton.layer.borderColor =  UIColor(hex: "#201963").withAlphaComponent(0.5).cgColor
        bestOfferLabel.backgroundColor = UIColor(hex: "#201963").withAlphaComponent(0.5)
        yTickImageView.isHidden = true
    }
    @objc func handleTapYButton() {
        yearlyButton.layer.borderColor = UIColor(hex: "#E53855").cgColor
        bestOfferLabel.backgroundColor = UIColor(hex: "#FFB017")
        yTickImageView.isHidden = false
        
        weeklyButton.layer.borderColor =  UIColor(hex: "#201963").withAlphaComponent(0.5).cgColor
        wTickImageView.isHidden = true
    }
    
    func updateVersion(_ version: String) {
        
        switch version {
        case "v1":
            weeklyButton.layer.borderColor = UIColor(hex: "#E53855").cgColor
            wTickImageView.isHidden = false
            saveLabel.textColor = UIColor(hex: "#E53855")
            saveLabel.isHidden = false

        case "v2":
            yearlyButton.layer.borderColor = UIColor(hex: "#E53855").cgColor
            bestOfferLabel.backgroundColor = UIColor(hex: "#FFB017")
            yTickImageView.isHidden = false
            saveLabel.textColor = UIColor(hex: "#FFB017")
            saveLabel.isHidden = false

        default:
            saveLabel.isHidden = true
        }
    }
}



