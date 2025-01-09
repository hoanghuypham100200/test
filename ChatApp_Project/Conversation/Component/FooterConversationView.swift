//
//  footerView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//




import UIKit
import SnapKit
import RxSwift
import RxCocoa


protocol FooterConversationViewDelegate: AnyObject {
    func footerConversationViewDidChangeHeight(_ newHeight: CGFloat)
}

class FooterConversationView: UIView, UITextViewDelegate {
    weak var delegate: FooterConversationViewDelegate?

    private let viewModel = ConversationViewModel()
    private let disposeBag = DisposeBag()
    var conversationID: String?
    private var newConversationId: String =  UUID().uuidString

    private var textViewHeightConstraint: Constraint?
    private var inputContainerViewHeightConstraint: Constraint?

    
    private let containerView = UIView()
    private let inputContainerView = UIView()
    private let lineView = UIView()
    
    let growingTextView = UITextView()
    
    private let characterCountLabel = UILabel()
    private let placeHolderLabel = UILabel()
    private let enterButton = UIButton()
    
    var enterAction:(() -> Void)?
    
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRx()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupRx()
    }

    
    private func setupUI() {
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        lineView.backgroundColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.05)
        //label
        characterCountLabel.text = "0/4000"
        characterCountLabel.textColor = UIColor(hex: "#8C90A6")
        characterCountLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        placeHolderLabel.text = "Ask anything..."
        placeHolderLabel.textColor = UIColor(hex: "#8C90A6")
        placeHolderLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        //button
        enterButton.setImage(UIImage.enter, for: .normal)
        //textView
        growingTextView.font = UIFont.systemFont(ofSize: 16)
        growingTextView.isScrollEnabled = false
        growingTextView.delegate = self
        growingTextView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        growingTextView.layer.cornerRadius = 15
        growingTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        growingTextView.backgroundColor = UIColor(hex: "#18204D")
        growingTextView.textColor = .white
    
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(characterCountLabel)
        containerView.addSubview(inputContainerView)
        containerView.addSubview(lineView)
        inputContainerView.addSubview(enterButton)
        inputContainerView.addSubview(growingTextView)
        growingTextView.addSubview(placeHolderLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        lineView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(1)
        }
        characterCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(16)
        }
        inputContainerView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-49)
            $0.leading.trailing.equalToSuperview().inset(16)
            inputContainerViewHeightConstraint = $0.height.equalTo(42).constraint
        }
        growingTextView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(320)
            textViewHeightConstraint = $0.height.equalTo(40).constraint
        }
        enterButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.width.equalTo(42)
            $0.trailing.equalToSuperview()
        }
        placeHolderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
    }
    
    private func setupRx() {
        setupActions()
        enterButton.addTarget(self, action: #selector(handleTapEnterBtn), for: .touchUpInside)
    }
    @objc func handleTapEnterBtn() {
        enterAction?()
        growingTextView.text = ""
        isHasCharacter(textView:growingTextView)
        textViewDidChange(growingTextView)
    }
    private func setupActions() {
        
        enterButton.rx.tap
            .bind { [weak self] in
                guard let self = self, let text = self.growingTextView.text, !text.isEmpty else { return }

                if let conversationID = conversationID {
                    viewModel.sendMessage(content: text, role: "user", conversationID: conversationID)
                } else {
                    viewModel.createConversation(newConversationId: newConversationId)
                    viewModel.sendMessage(content: text, role: "user", conversationID: newConversationId)
                    conversationID = newConversationId
                    viewModel.fetchConversation()
                }
               
            
            }
            .disposed(by: disposeBag)

    }
    
    // Check if the textView has characters
    private func isHasCharacter(textView: UITextView) {
        if textView.text.isEmpty {
            placeHolderLabel.isHidden = false
            enterButton.setImage(UIImage.enter, for: .normal)
        }
        else {
            placeHolderLabel.isHidden = true
            enterButton.setImage(UIImage.enterText, for: .normal)
        }
    }
    
    // count character in text view and update
    private func updateCountCharacter(textView: UITextView) {
        let characterCount = textView.text.count
        let maxCharacterLimit = 4000
        characterCountLabel.text = "\(characterCount)/\(maxCharacterLimit)"
        if (characterCount >= maxCharacterLimit) {
            characterCountLabel.textColor = .systemPink
            handleCharacterLimitExceeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        let padding: CGFloat = 5

        let maxHeight: CGFloat = 146 // Set a maximum height if needed
        let newHeight = min(estimatedSize.height, maxHeight)
                textView.isScrollEnabled = estimatedSize.height > maxHeight
        //update placeholder, color button
        isHasCharacter(textView: textView)
        //update count character
        updateCountCharacter(textView: textView)
        //update height
        textViewHeightConstraint?.update(offset: newHeight + padding)
        inputContainerViewHeightConstraint?.update(offset: newHeight + padding)
        delegate?.footerConversationViewDidChangeHeight(newHeight + 90)

    }
    
    private func handleCharacterLimitExceeded() {
        showAlert(title: "Character Limit Exceeded", message: "You can only enter up to 4000 characters.")
    }

}



