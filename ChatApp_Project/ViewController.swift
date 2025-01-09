import UIKit


class ChatViewController: UIViewController {
    private let textField = UITextField()
    private let sendButton = UIButton()
    private let responseLabel = UILabel()
    private var conversation: [[String: String]] = [
        ["role": "system", "content": "You are a helpful assistant."]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your question"
        textField.translatesAutoresizingMaskIntoConstraints = false

        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.layer.cornerRadius = 8
        sendButton.translatesAutoresizingMaskIntoConstraints = false
       

        responseLabel.numberOfLines = 0
        responseLabel.textAlignment = .center
        responseLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)
        view.addSubview(sendButton)
        view.addSubview(responseLabel)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 100),

            responseLabel.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 20),
            responseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            responseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

   
}

