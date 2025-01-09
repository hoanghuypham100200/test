import UIKit
import SnapKit

class PopupViewController: UIViewController {
    
    // MARK: - Callbacks
    var onClearChat: (() -> Void)?
    var onDeleteConversation: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestureRecognizers()
        setupNotch()
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            preferredContentSize = CGSize(width: 240, height: 100)

        } else {
            preferredContentSize = CGSize(width: 200, height: 70)

        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#18204D")
        
        let clearView = UIView()
        let deleteView = UIView()
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#150E5C")
        
        let clearLabel = UILabel()
        clearLabel.text = "Clear chat"
        clearLabel.textColor = .white
        clearLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        let deleteLabel = UILabel()
        deleteLabel.text = "Delete conversation"
        deleteLabel.textColor = UIColor(hex: "#E53855")
        deleteLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        let clearImageView = UIImageView()
        clearImageView.image = UIImage.clear
        
        let deleteImageView = UIImageView()
        deleteImageView.image = UIImage.delete
        
        view.addSubview(deleteView)
        view.addSubview(clearView)
        view.addSubview(lineView)
        deleteView.addSubview(deleteLabel)
        deleteView.addSubview(deleteImageView)
        clearView.addSubview(clearImageView)
        clearView.addSubview(clearLabel)
        
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        
        clearView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        clearLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        clearImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(18)
        }
        
        deleteView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        deleteImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(18)
        }
    }
    
    private func setupGestureRecognizers() {
        let tapDeleteView = UITapGestureRecognizer(target: self, action: #selector(handleTapDeleteView))
        let tapClearView = UITapGestureRecognizer(target: self, action: #selector(handleTapClearView))
        
        if let clearView = view.subviews.first(where: { $0.subviews.contains(where: { $0 is UILabel && ($0 as! UILabel).text == "Clear chat" }) }),
           let deleteView = view.subviews.first(where: { $0.subviews.contains(where: { $0 is UILabel && ($0 as! UILabel).text == "Delete conversation" }) }) {
            clearView.addGestureRecognizer(tapClearView)
            deleteView.addGestureRecognizer(tapDeleteView)
        }
    }
    
    // MARK: - Actions
    @objc private func handleTapClearView() {
        onClearChat?()
    }
    
    @objc private func handleTapDeleteView() {
        onDeleteConversation?()
    }
}
