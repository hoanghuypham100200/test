import UIKit
import SnapKit

class PopupFullViewController: UIViewController {
    
    // MARK: - Callbacks
    var dismissAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNotch()
    }
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            preferredContentSize = CGSize(width: 300, height: 224)

        } else {
            preferredContentSize = CGSize(width: 250, height: 224)

        }
    }
    
    private func setupUI() {
        preferredContentSize = CGSize(width: 300, height: 224)
        
      
        let containerView = UIView()
        containerView.backgroundColor = UIColor(hex: "#08033C")
        
        let titleLabel = UILabel()
        titleLabel.text = "Warning !!!"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center

        let descLabel = UILabel()
        descLabel.text = "I'm full, Don't add more characters, I cannot contain any more"
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.textColor = .white
        descLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
    
        
        let okButton = UIButton()
        okButton.setTitle("OK, I got it ", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        okButton.titleLabel?.textColor = .white
        okButton.backgroundColor = UIColor(hex: "#E53855")
        okButton.layer.cornerRadius = 25
        okButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        
        
        
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        containerView.addSubview(okButton)

        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(224)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        descLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        okButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(230)
            $0.bottom.equalToSuperview().inset(32)
        }

    }
    
    
    // MARK: - Actions
    @objc private func handleTap() {
        dismissAction?()
    }
    
  
}
