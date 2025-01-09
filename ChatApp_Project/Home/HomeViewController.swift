

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class HomeViewController: UIViewController {

    private let tableView = UITableView()
    
    let filesCountLabel = UILabel()
    let createView  = DashedBorderView()
    
    let createLabel = UILabel()
    let iconFileImage = UIImageView()
    let iconCreateImage = UIImageView()
    
    
    private let viewModel = ConversationViewModel()
    private let disposeBag = DisposeBag()
    let containerView = UIView()
    let topView = UIView()
    let midView = UIView()
    let botView = UIView()
    let headerView = HeaderHomeView()
    let emptyLabel = UILabel()
//    let max =

    var maximumFile = UserDefaults.standard.integer(forKey: "maximumFile")
    var maximumFileIsNotUpgrade = 2
    var currentFilesTotal:Int?
    var isUpgradeUserDefaults = UserDefaults.standard.bool(forKey: "isUpgrade") {
        didSet {
            if(isUpgradeUserDefaults  == true) {
                if let currentFilesTotal = currentFilesTotal{
                    filesCountLabel.text = "Files (\(currentFilesTotal)/\(maximumFile))"
                }
                createView.isHidden = false
                headerView.upgradeButton.isHidden = true
                iconCreateImage.image = UIImage.createIcon
               
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupRx()
        viewModel.fetchConversation()
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupNotch()
    }
    
    private func setupNotch() {
        if DeviceHelper.isHasNotch {
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(100)
            }
            headerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
           
            midView.snp.makeConstraints {
                $0.top.equalTo(topView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(593)
            }

            filesCountLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().offset(16)
            }
            tableView.snp.makeConstraints {
                $0.top.equalTo(filesCountLabel.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().offset(-20)
            }
            emptyLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            botView.snp.makeConstraints {
                $0.top.equalTo(midView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            createView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(88)
            }
            iconFileImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(30)
                $0.height.width.equalTo(40)
            }
            createLabel.snp.makeConstraints {
                $0.left.equalTo(iconFileImage.snp.right).offset(12)
                $0.centerY.equalToSuperview()
            }
            iconCreateImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-30)
                $0.height.width.equalTo(40)
            }
            
        } else {
            topView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(50)
            }
            headerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
           
            midView.snp.makeConstraints {
                $0.top.equalTo(topView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(500)
            }

            filesCountLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().offset(16)
            }
            tableView.snp.makeConstraints {
                $0.top.equalTo(filesCountLabel.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().offset(-20)
            }
            emptyLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            botView.snp.makeConstraints {
                $0.top.equalTo(midView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            createView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(88)
            }
            iconFileImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(30)
                $0.height.width.equalTo(40)
            }
            createLabel.snp.makeConstraints {
                $0.left.equalTo(iconFileImage.snp.right).offset(12)
                $0.centerY.equalToSuperview()
            }
            iconCreateImage.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-30)
                $0.height.width.equalTo(40)
            }
            
        }
    }
    
    private func setupUI() {
        //navigate
        navigationItem.hidesBackButton = true
        //view
        containerView.backgroundColor = UIColor(hex: "#08033C")
    
        tableView.backgroundColor = UIColor(hex: "#08033C")
        tableView.register(FilesCell.self, forCellReuseIdentifier: FilesCell.identifier)

        tableView.separatorStyle = .none
        
        //label
        filesCountLabel.text = "Files (10/10)"
        filesCountLabel.textColor = .white
        filesCountLabel.font = UIFont.systemFont(ofSize: 20,weight: .medium)

        createView.backgroundColor = UIColor(hex: "#18204D")
        createView.layer.cornerRadius = 25
        //label
        createLabel.text = "Create first message"
        createLabel.textColor = .white
        createLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        emptyLabel.text = "Message is empty."
        emptyLabel.textColor = UIColor(hex: "#8C90A6")
        emptyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        //image
        iconFileImage.image = UIImage.upFile
        iconCreateImage.image = UIImage.createIcon

    }
        private func setupConstraints() {
            view.addSubview(containerView)
            containerView.addSubview(topView)
            containerView.addSubview(midView)
            containerView.addSubview(botView)
            topView.addSubview(headerView)
            midView.addSubview(emptyLabel)
            midView.addSubview(tableView)
            midView.addSubview(filesCountLabel)
            botView.addSubview(createView)
            createView.addSubview(iconFileImage)
            createView.addSubview(iconCreateImage)
            createView.addSubview(createLabel)
    
            containerView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
           
       
        }
    private func setupRx() {
        let tapCreateView = UITapGestureRecognizer(target: self, action: #selector(handleTapCreateView))
        createView.addGestureRecognizer(tapCreateView)
        handleUpgradeBtn()
        handleSettingBtn()
        bindTableView()
        isCheckUpgrade()

    }
    
    private func isCheckUpgrade() {
        print(isUpgradeUserDefaults)

        if (isUpgradeUserDefaults) {
            headerView.upgradeButton.isHidden = true
        } else {
            headerView.upgradeButton.isHidden = false

        }
    }
    private func isEmpty(isEmpty : Bool) {
        if (isEmpty){
            tableView.isHidden = true
            filesCountLabel.isHidden = true
            emptyLabel.isHidden = false

        } else {
            emptyLabel.isHidden = true
            tableView.isHidden = false
            filesCountLabel.isHidden = false
        }
    }
    
       
    
        private func handleUpgradeBtn() {
            headerView.upgradeAction = { [weak self] in
                guard let _ = self else {return}
                if self?.navigationController != nil {
                    let DSVC = DSViewController()
                    DSVC.delegate = self
                    DSVC.modalPresentationStyle = .fullScreen
                    self?.present(DSVC, animated: true, completion: nil)
                } else {
                    self?.navigationController!.popViewController(animated: true)
                }
            }
    
        }
        private func handleSettingBtn() {
            headerView.settingAction = { [weak self] in
                guard let _ = self else {return}
                let settingVC = SettingViewController()
                self?.navigationController?.pushViewController(settingVC, animated: true)
    
            }
    
        }
    
    
    private func bindTableView() {
        
        viewModel.conversation
                .bind(to: tableView.rx.items(cellIdentifier: FilesCell.identifier, cellType: FilesCell.self)) { index, conversation, cell in
                    let firstTwo = String(conversation.id.prefix(2))
                    let nameFile = "file \(firstTwo).PDF"
                    cell.configure(text: nameFile)
                }
                .disposed(by: disposeBag)
            
            tableView.rx.modelSelected(ConversationModel.self)
                   .subscribe(onNext: { [weak self] selectedConversation in
                       let conversationVC = ConversationViewController()
                                conversationVC.conversationID = selectedConversation.id  // Pass the selected id
                       conversationVC.delegateUpdate = self
                       self?.navigationController?.pushViewController(conversationVC, animated: true)               })
                   .disposed(by: disposeBag)
            
            viewModel.conversation
                    .asObservable()
                    .subscribe(onNext: { [weak self] files in
                       
                        let total = self!.isUpgradeUserDefaults ? self?.maximumFile : self?.maximumFileIsNotUpgrade

                        self?.filesCountLabel.text = "Files (\(files.count)/\(total!))"
                        if(files.count >= total!){
                            self?.iconCreateImage.image = UIImage(systemName: "plus.circle.fill")
                            self?.iconCreateImage.tintColor = UIColor(hex:"#8C90A6")
                        } else {
                            self?.iconCreateImage.image = UIImage.createIcon
                        }
                        self?.currentFilesTotal = files.count
                        self?.isEmpty(isEmpty:files.isEmpty)
                    })
                    .disposed(by: disposeBag)
            
            
        
    }

 

    @objc func handleTapCreateView() {
        
        let limitedFile = self.isUpgradeUserDefaults ? self.maximumFile : self.maximumFileIsNotUpgrade
        let currentFileTotal =  viewModel.conversation.value.count
        
        if(currentFileTotal >= limitedFile) {
            return
        }
        else {
            let conversationVC = ConversationViewController()
            navigationController?.pushViewController(conversationVC, animated: true)
            conversationVC.delegateUpdate = self
        }
    }
}

extension HomeViewController: UpLoadConversationList,UpdateUpgradeDelegate {
    func upLoadConversationList() {
        viewModel.fetchConversation()
    }
        func updateUpgradeDelegate(isUpgrade: Bool) {
            isUpgradeUserDefaults = isUpgrade
        }
}





