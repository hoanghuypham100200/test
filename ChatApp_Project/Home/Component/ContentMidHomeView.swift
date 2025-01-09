//
//  ContentMidView.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ContentMidHomeView: UIView {

    static var selectIndex: Int?
    var openFileAcion: (() -> Void)?
    var filesData: [ConversationModel] = []
    let viewModel = ConversationViewModel()

    var conversationID: String?

    private let disposeBag = DisposeBag()


    let containerView = UIView()
    let emptyLabel = UILabel()
    
    let filesCountLabel = UILabel()
    let filesTableView = UITableView()
    var maximumFile = 10
    
    
//  
    var isUpgradeUserDefaults = UserDefaults.standard.bool(forKey: "isUpgrade") {
        didSet {
            if(isUpgradeUserDefaults  == true) {
                filesCountLabel.text = "Files (1/\(maximumFile))"
            }
            
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupRx()
        viewModel.fetchConversation()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        setupRx()
        viewModel.fetchConversation()
    }

    
    private func setupUI() {

        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
        filesTableView.backgroundColor = UIColor(hex: "#08033C")
        filesTableView.register(FilesCell.self, forCellReuseIdentifier: FilesCell.identifier)
//        filesTableView.dataSource = self
//        filesTableView.delegate = self
        filesTableView.separatorStyle = .none
        
        //label
        filesCountLabel.text = "Files (10/10)"
        filesCountLabel.textColor = .white
        filesCountLabel.font = UIFont.systemFont(ofSize: 20,weight: .medium)
        emptyLabel.text = "Message is empty."
        emptyLabel.textColor = UIColor(hex: "#8C90A6")
        emptyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    func updateTotal(_ total: String) {
        if !total.isEmpty {
            maximumFile = Int(total)!
        }

    }
   
    
   
    func update(isUpgrade: Bool){
         isUpgradeUserDefaults = isUpgrade
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(emptyLabel)
        containerView.addSubview(filesCountLabel)
        containerView.addSubview(filesTableView)
       
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        filesCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        filesTableView.snp.makeConstraints {
            $0.top.equalTo(filesCountLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
//    func updateFiles(_ files: [String],isUpgrade: Bool) {
//           // Print filesArray to the console
//        filesData = files
//        if (isUpgrade) {
//            filesCountLabel.text = "Files (\(filesData.count)/\(maximumFile))"
//        }else {
//            filesCountLabel.text = "Files (\(filesData.count)/1)"
//
//        }
//        filesTableView.reloadData()
//        isEmpty()
//
//    }

    private func isEmpty() {
        if (filesData.isEmpty){
            filesTableView.isHidden = true
            filesCountLabel.isHidden = true
            emptyLabel.isHidden = false

        } else {
            emptyLabel.isHidden = true
            filesTableView.isHidden = false
            filesCountLabel.isHidden = false
        }
    }
    
    private func setupRx() {
        bindFilesToContentMidView()
    }
    
    private func bindFilesToContentMidView() {

        
        viewModel.conversation
            .bind(to: filesTableView.rx.items(cellIdentifier: FilesCell.identifier, cellType: FilesCell.self)) { index, conversation, cell in
                cell.configure(text: conversation.id)
            }
            .disposed(by: disposeBag)
        
        filesTableView.rx.modelSelected(ConversationModel.self)
               .subscribe(onNext: { [weak self] selectedConversation in
                   let conversationVC = ConversationViewController()
                   self?.conversationID = selectedConversation.id
                   self?.openFileAcion?()
                                  })
               .disposed(by: disposeBag)
        
    }
    
//    private func bindTableView() {
//        viewModel.conversation
//            .bind(to: filesTableView.rx.items(cellIdentifier: "ConversationCell", cellType: UITableViewCell.self)) { index, conversation, cell in
//                cell.textLabel?.text = conversation.id
//                
//            }
//            .disposed(by: disposeBag)
        
//        filesTableView.rx.modelSelected(ConversationModel.self)
//               .subscribe(onNext: { [weak self] selectedConversation in
//                   let conversationVC = ConversationViewController()
//                            conversationVC.conversationID = selectedConversation.id  // Pass the selected id
//                   self?.navigationController?.pushViewController(conversationVC, animated: true)               })
//               .disposed(by: disposeBag)
}

    

//extension ContentMidHomeView : UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filesData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilesCell.identifier, for: indexPath) as? FilesCell else {
//            fatalError("Failed to dequeue CustomCollectionViewCell")
//        }
//        cell.configure(text: filesData[indexPath.row].id)
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        conversationID = filesData[indexPath.row].id
//        openFileAcion?()
//    }
//    
//    
//}



