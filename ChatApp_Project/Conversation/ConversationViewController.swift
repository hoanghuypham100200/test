


import UIKit
import RxSwift
import RxCocoa
import SnapKit
import GrowingTextView
protocol UpLoadConversationList: AnyObject {
    func upLoadConversationList()
}
class ConversationViewController: UIViewController, UITextViewDelegate, UIPopoverPresentationControllerDelegate,GrowingTextViewDelegate {
    weak var delegateUpdate: UpLoadConversationList?
    
        let containerView = UIView()
        let topView = UIView()
    let headerConversation = HeaderConversationView()
        let midView = UIView()
        let botView = UIView()

    private let tableView = UITableView()
    private let viewModel = ConversationViewModel()
    private let disposeBag = DisposeBag()
    var conversationID: String?
    private var newConversationId: String =  UUID().uuidString
    
    
    private let inputContainerView = UIView()
    private let lineView = UIView()
    
    //MARK: growingTextView
    let growingTextView = GrowingTextView()
    
    
    
    private let characterCountLabel = UILabel()
    private let placeHolderLabel = UILabel()
    private let enterButton = UIButton()
    private var textViewHeightConstraint: Constraint?
    private var inputContainerViewHeightConstraint: Constraint?
    var paddingBottom = DeviceHelper.isHasNotch ? 300 : 220
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupRx()
        bindTableView()
        setupActions()
        if let id = conversationID{
            viewModel.fetchMessages(conversationID: id)
        }
        setupNotch()
    }
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            growingTextView.snp.makeConstraints {
                $0.bottom.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(320)

            }
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(98)
            }
        } else {
            growingTextView.snp.makeConstraints {
                $0.bottom.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(290)

            }
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
        }
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        containerView.backgroundColor = UIColor(hex: "#08033C")
        

        tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: "#08033C")
        tableView.layoutIfNeeded()

        
        
        
        
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
        growingTextView.isScrollEnabled = true
        growingTextView.delegate = self
        growingTextView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        growingTextView.layer.cornerRadius = 15
        growingTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        growingTextView.backgroundColor = UIColor(hex: "#18204D")
        growingTextView.textColor = .white
        
        
        growingTextView.trimWhiteSpaceWhenEndEditing = true
        growingTextView.minHeight = 25.0
        growingTextView.maxHeight = 144
        
        
    }
    
    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(topView)
        containerView.addSubview(botView)
        containerView.addSubview(midView)
        midView.addSubview(tableView)
        topView.addSubview(headerConversation)
        
        botView.addSubview(characterCountLabel)
        botView.addSubview(inputContainerView)
        botView.addSubview(lineView)
        inputContainerView.addSubview(enterButton)
        inputContainerView.addSubview(growingTextView)
        growingTextView.addSubview(placeHolderLabel)

        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
      
        headerConversation.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
       
        midView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()

            $0.bottom.equalTo(botView.snp.top)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
      
        botView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.lessThanOrEqualTo(224)
            $0.bottom.equalToSuperview()
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

            $0.top.equalTo(characterCountLabel.snp.bottom).offset(10)

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
        handlePopup()
        handleBackBtn()
        setupTapGesture()
        scrollToBottom(onKeyBoard: true)
    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let tapTextView = UITapGestureRecognizer(target: self, action: #selector(handeleTapView))
        growingTextView.addGestureRecognizer(tapTextView)
    }
    
    
    @objc private func handeleTapView() {
        openKeyBoard()
 
    }
    
    private func openKeyBoard() {
        growingTextView.becomeFirstResponder()
        botView.snp.updateConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.lessThanOrEqualTo(224)
            $0.bottom.equalToSuperview().inset(paddingBottom)
        }
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)

       
    }
    
    func textViewDidChange(_ textView: UITextView) {
                //update placeholder, color button
                isHasCharacter(textView: textView)
                //update count character
                updateCountCharacter(textView: textView)
                //update height
       }
    func textViewDidEndEditing(_ textView: UITextView) {
        botView.snp.updateConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.lessThanOrEqualTo(224)
            $0.bottom.equalToSuperview()
        }
    }
    func scrollToBottom(onKeyBoard:Bool) {
        if (onKeyBoard == true){
            openKeyBoard()

        }
        DispatchQueue.main.async {
            let lastSectionIndex = self.tableView.numberOfSections - 1
            if lastSectionIndex >= 0 {
                let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
                if lastRowIndex >= 0 {
                    let indexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
                    usleep(100000)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                }
            }
        }
        

    }
    private func sendPrompt(textPrompt: String?, conversationId: String) {
        guard let prompt = textPrompt, !prompt.isEmpty else { return }
        OpenAIManager.shared.sendMessage(messages: [["role": "user","content": prompt]]) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // Update conversation with assistant's response
                    if let assistantMessage = response.first {
                        self?.viewModel.sendMessage(content: assistantMessage["content"]!, role: assistantMessage["role"]!, conversationID: conversationId)
                    }
                    self?.scrollToBottom(onKeyBoard: false)
                case .failure(let error):
                    print( "Error: \(error.localizedDescription)")
                }
            }
        }
    }
    private func handlePopup() {
            headerConversation.openAction = { [weak self] in
                guard let _ = self else {return}
                self!.showPopover()
            }
    }
    private func handleBackBtn() {
            headerConversation.backAction = { [weak self] in
                guard let _ = self else {return}
                self!.navigationController?.popViewController(animated: true)
                
            }
    }
    
    func showPopover() {
            let popupVC = PopupViewController()
            popupVC.modalPresentationStyle = .popover
            popupVC.onClearChat = { [weak self] in
                // Handle clear chat action
                if let conversationID = self?.conversationID {
                    self?.viewModel.clearMessage(conversationID: conversationID)
                    self?.dismiss(animated: false)
                }
            }
            popupVC.onDeleteConversation = { [weak self] in
                // Handle delete conversation action
                if let conversationID = self?.conversationID {
                    self?.viewModel.removeConversation(conversationId: conversationID)
                }
                self?.delegateUpdate?.upLoadConversationList()
                self?.navigationController?.popViewController(animated: true)
            }
    
            if let popoverPresentationController = popupVC.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: 300, y: 70, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
                popoverPresentationController.delegate = self
            }
            self.present(popupVC, animated: true)
    }
    
        // Optional: Keep it as a popover even on compact environments
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
    }
    
    private func bindTableView() {
        viewModel.messages
            .bind(to: tableView.rx.items(cellIdentifier: ConversationCell.identifier, cellType: ConversationCell.self)) { index, message, cell in
                cell.configure(content: message.content)
                cell.chatMessage = message.role
            }
            .disposed(by: disposeBag)
    }
    
    
    private func setupActions() {
        
        enterButton.rx.tap
            .bind { [weak self] in
                guard let self = self, let text = self.growingTextView.text, !text.isEmpty else { return }
                
                if let conversationID = conversationID {
                    viewModel.sendMessage(content: text, role: "user", conversationID: conversationID)
                    sendPrompt(textPrompt: text, conversationId: conversationID)

                } else {
                    viewModel.createConversation(newConversationId: newConversationId)
                    viewModel.sendMessage(content: text, role: "user", conversationID: newConversationId)
                    conversationID = newConversationId
                    viewModel.fetchConversation()
                    self.delegateUpdate?.upLoadConversationList()
                    sendPrompt(textPrompt: text, conversationId: newConversationId)

                }
                growingTextView.text = ""
                isHasCharacter(textView:growingTextView)
                characterCountLabel.text = "0/4000"
                characterCountLabel.textColor = UIColor(hex: "#8C90A6")
                scrollToBottom(onKeyBoard: false)

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
    
    
    private func updateCountCharacter(textView: UITextView) {
        let characterCount = textView.text.count
        let maxCharacterLimit = 4000
        characterCountLabel.text = "\(characterCount)/\(maxCharacterLimit)"
        if (characterCount >= maxCharacterLimit) {
            showPopoverFull()
            characterCountLabel.text = "4000/4000"
            characterCountLabel.textColor = .systemPink
        }
        else {
            characterCountLabel.text = "\(characterCount)/\(maxCharacterLimit)"
            characterCountLabel.textColor = UIColor(hex: "#8C90A6")

        }
    }
    
    func showPopoverFull() {
            let popupFullVC = PopupFullViewController()
        popupFullVC.modalPresentationStyle = .popover
        popupFullVC.dismissAction = { [weak self] in
                // Handle clear chat action
               
                    self?.dismiss(animated: false)
                
            }
           
    
            if let popoverPresentationController = popupFullVC.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect = CGRect(x: 200, y: 300, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
                popoverPresentationController.delegate = self
            }
            self.present(popupFullVC, animated: true)
    }
}


