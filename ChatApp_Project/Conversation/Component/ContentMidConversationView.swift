//
//  ContentMidView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//



import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ContentMidConversationView: UIView {

    private let viewModel = ConversationViewModel()
    private let disposeBag = DisposeBag()
    var conversationID: String?

    
    private let containerView = UIView()
    let chatTableView = UITableView()
    


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
    func fetchData (id: String) {
            viewModel.fetchMessages(conversationID: id)
        chatTableView.reloadData()
    }
    
    private func setupUI() {
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        //table View
        chatTableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
//        chatTableView.dataSource = self
//        chatTableView.delegate = self
        chatTableView.separatorStyle = .none
        chatTableView.backgroundColor = UIColor(hex: "#08033C")
        chatTableView.layoutIfNeeded()

    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(chatTableView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        chatTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    private func setupRx() {
        loadDataConversation()
    }
    private func loadDataConversation() {
        
        viewModel.messages
            .bind(to: chatTableView.rx.items(cellIdentifier: ConversationCell.identifier, cellType: ConversationCell.self)) { index, message, cell in
                cell.configure(content: message.content)
                cell.chatMessage = message.role
            }
            .disposed(by: disposeBag)
    }

}





