//
//  ViewController.swift
//  AdventureDoToList
//
//  Created by Huy on 11/12/24.
//

import UIKit
import SnapKit
class StoreController: UIViewController {
    
    var isToggle: Bool = false
   
    let containerTopView = UIView()
    let premiumButton = UIButton()
    let XButton = UIButton()
    
    let containerMiddleView = UIView()
    let titleView = UIView()
    let featureImageView = UIImageView()
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let titleLabel3 = UILabel()
    let radioButton1 = UIButton()
    let radioButton2 = UIButton()
    let iconInWeeklyButtonView = UIImageView()
    let iconInYearlyButtonView = UIImageView()
    let weeklyLabel = UILabel()
    let descLabel = UILabel()
    let yearlyLabel = UILabel()
    let desc2Label = UILabel()
    let price1Label = UILabel()
    let price2Label = UILabel()
    let restoreButton = UIButton()
    let termButton = UIButton()
    let privacyButton = UIButton()


    let containerBottomView = UIView()
    let noPaymentLabel = UILabel()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        view.backgroundColor = .white
        view.addSubview(containerBottomView)
        view.addSubview(containerMiddleView)
        view.addSubview(containerTopView)
        containerTopView.addSubview(premiumButton)
        containerTopView.addSubview(XButton)
        
        containerMiddleView.addSubview(titleView)
        containerMiddleView.addSubview(featureImageView)
        titleView.addSubview(titleLabel1)
        titleView.addSubview(titleLabel2)
        titleView.addSubview(titleLabel3)
        
        containerMiddleView.addSubview(radioButton1)
        containerMiddleView.addSubview(radioButton2)
        
        containerMiddleView.addSubview(termButton)
        containerMiddleView.addSubview(privacyButton)
        containerMiddleView.addSubview(restoreButton)
        
        radioButton1.addSubview(iconInWeeklyButtonView)
        radioButton1.addSubview(weeklyLabel)
        radioButton1.addSubview(descLabel)
        radioButton1.addSubview(price1Label)
        
        radioButton2.addSubview(iconInYearlyButtonView)
        radioButton2.addSubview(yearlyLabel)
        radioButton2.addSubview(desc2Label)
        radioButton2.addSubview(price2Label)
        
        
        
    
        containerBottomView.addSubview(startButton)
        containerBottomView.addSubview(noPaymentLabel)
        

        //MARK: configue
        // view
        containerBottomView.backgroundColor = .white
        containerTopView.backgroundColor = .white
        containerMiddleView.backgroundColor = .white
            
        
        
        //MARK: configue button
        startButton.setTitle("Start free trial", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .lightGray
        startButton.layer.cornerRadius = 15
        startButton.titleLabel?.font = UIFont(name: "Bookerly Bold", size: 20)
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        premiumButton.setTitle("Premium", for: .normal)
        premiumButton.setTitleColor(.black, for: .normal)
        premiumButton.backgroundColor = UIColor(hex:"#FFD045")
        premiumButton.layer.cornerRadius = 10
        premiumButton.titleLabel?.font = UIFont(name: "Bookerly Bold", size: 14)
        
        XButton.setTitle("x", for: .normal)
        XButton.setTitleColor(.systemGray, for: .normal)
        XButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        
        
        radioButton1.layer.borderWidth = 1
        radioButton1.layer.cornerRadius = 30
        radioButton1.layer.borderWidth = 2
        radioButton1.addTarget(self, action: #selector (radioButtonAction1), for: .touchUpInside)
        
        radioButton2.layer.borderWidth = 1
        radioButton2.layer.cornerRadius = 30
        radioButton2.layer.borderColor = UIColor(hex: "#949498").cgColor
        radioButton2.addTarget(self, action: #selector (radioButtonAction2), for: .touchUpInside)


        
        
        
        let Attributes: [NSAttributedString.Key: Any] = [
             .font: UIFont(name: "Bookerly", size: 15)!,
             .foregroundColor: UIColor(hex: "#949498"),
             .underlineStyle: NSUnderlineStyle.single.rawValue
         ]
        let attributeReStore = NSMutableAttributedString(
              string: "Restore",
              attributes: Attributes
           )
        
        let attributeTerm = NSMutableAttributedString(
              string: "Term",
              attributes: Attributes
           )
        let attributePrivacy = NSMutableAttributedString(
              string: "Privacy",
              attributes: Attributes
           )
        restoreButton.setAttributedTitle(attributeReStore, for: .normal)
        termButton.setAttributedTitle(attributeTerm, for: .normal)
        privacyButton.setAttributedTitle(attributePrivacy, for: .normal)

        
        
        //MARK: configue label
        price1Label.text = "$9.99"
        price1Label.textColor = UIColor(hex: "#212122")
        price1Label.font = UIFont(name: "Bookerly", size: 18)
        
        price2Label.text = "$39.99"
        price2Label.textColor = UIColor(hex: "#212122")
        price2Label.font = UIFont(name: "Bookerly", size: 18)
        
        noPaymentLabel.text = "NO PAYMENT NOW"
        noPaymentLabel.textColor = .lightGray
        noPaymentLabel.font = UIFont(name: "Bookerly Bold", size: 10)
        
        titleLabel1.text = "Boost"
        titleLabel1.textColor = UIColor(hex: "#675B5B")
        titleLabel1.font = UIFont(name: "Bookerly Bold", size: 32)
        
        titleLabel2.text = "Your Productivity"
        titleLabel2.textColor = .black
        titleLabel2.font = UIFont(name: "Bookerly Italic", size: 40)
        
        titleLabel3.text = " with power of A.I. "
        titleLabel3.textColor =  .white
        titleLabel3.backgroundColor = UIColor(hex: "#675B5B")
        titleLabel3.font = UIFont(name: "Bookerly", size: 20)
        titleLabel3.layer.cornerRadius = 10
        titleLabel3.clipsToBounds = true
        
        weeklyLabel.text = "Weekly Trial"
        weeklyLabel.textColor = .black
        weeklyLabel.font = UIFont(name: "Bookerly Bold", size: 18)
        
        yearlyLabel.text = "Yearly"
        yearlyLabel.textColor = .black
        yearlyLabel.font = UIFont(name: "Bookerly Bold", size: 18)
        
        descLabel.text = "3 days free"
        descLabel.textColor = UIColor(hex: "#949498")
        descLabel.font = UIFont(name: "Bookerly", size: 15)
        
        desc2Label.text = "only $0.39 / week"
        desc2Label.textColor = UIColor(hex: "#949498")
        desc2Label.font = UIFont(name: "Bookerly", size: 15)
        
        
        
        
        // imageView
        featureImageView.image = UIImage(named: "Frame 1096")
        
        iconInWeeklyButtonView.image =  UIImage(systemName: "circle.circle.fill")
        iconInWeeklyButtonView.tintColor = UIColor(hex: "#675B5B")
//        iconInYearlyButtonView.image = UIImage(systemName: "circle.circle.fill")
        iconInYearlyButtonView.tintColor = UIColor(hex: "#675B5B")
        iconInYearlyButtonView.image =  UIImage(systemName: "circle")
        
        //MARK: constraints
        //bottom
        containerBottomView.snp.makeConstraints{
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.equalTo(143)
        }
        noPaymentLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(13)
        }
        startButton.snp.makeConstraints{
            $0.top.equalTo(noPaymentLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(60)
        }
        
        // MARK: middle
        containerMiddleView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(containerTopView.snp.bottom)
            $0.bottom.equalTo(containerBottomView.snp.top)
        }
        titleView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(137)

        }
        titleLabel1.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(42)
        }
        titleLabel2.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel1.snp.bottom)
            $0.height.equalTo(53)

        }
        titleLabel3.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(32)

        }
        
        featureImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleView.snp.bottom).offset(25)
            $0.height.equalTo(200)
        }
        radioButton1.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(featureImageView.snp.bottom).offset(30)
            $0.height.equalTo(64)
        }
        radioButton2.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(radioButton1.snp.bottom).offset(15)
            $0.height.equalTo(64)
        }
        iconInWeeklyButtonView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(22)
        }
        iconInYearlyButtonView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(22)
        }
        weeklyLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(iconInWeeklyButtonView.snp.right).offset(10)
        }
        descLabel.snp.makeConstraints{
            $0.top.equalTo(weeklyLabel.snp.bottom)
            $0.left.equalTo(iconInYearlyButtonView.snp.right).offset(10)
        }
        price1Label.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(24)
        }
        
        yearlyLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(iconInWeeklyButtonView.snp.right).offset(10)
        }
        desc2Label.snp.makeConstraints{
            $0.top.equalTo(yearlyLabel.snp.bottom)
            $0.left.equalTo(iconInYearlyButtonView.snp.right).offset(10)
        }
        price2Label.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(24)
        }
        restoreButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(radioButton2.snp.bottom).offset(30)
            $0.height.equalTo(17)
        }
        termButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(radioButton2.snp.bottom).offset(30)
            $0.height.equalTo(17)
        }
        privacyButton.snp.makeConstraints{
            $0.left.equalTo(termButton.snp.right).offset(5)
            $0.top.equalTo(radioButton2.snp.bottom).offset(30)
            $0.height.equalTo(17)
        }
        
        
        //MARK: TOP
        containerTopView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(91)
        }
        premiumButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-4.5)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(35)
            $0.width.equalTo(91)
        }
        XButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-8.5)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(17)
            $0.width.equalTo(17)
        }
        
      
    }
    @objc func startButtonAction(){
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: false)

    }
    @objc func radioButtonAction1(){
       
        iconInWeeklyButtonView.image = UIImage(systemName:"circle.circle.fill")
        iconInYearlyButtonView.image = UIImage(systemName:"circle")
        
        radioButton1.layer.borderWidth = 2
        radioButton2.layer.borderWidth = 1
        
        radioButton2.layer.borderColor = UIColor(hex: "#949498").cgColor
        radioButton1.layer.borderColor = UIColor(hex: "#000000").cgColor


    }
    
    @objc func radioButtonAction2(){

        iconInYearlyButtonView.image = UIImage(systemName:"circle.circle.fill")
        iconInWeeklyButtonView.image = UIImage(systemName:"circle")

        radioButton1.layer.borderWidth = 1
        radioButton2.layer.borderWidth = 2
        
        radioButton1.layer.borderColor = UIColor(hex: "#949498").cgColor
        radioButton2.layer.borderColor = UIColor(hex: "#000000").cgColor

    }



}
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


