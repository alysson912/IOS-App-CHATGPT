//
//  HomeScreen.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 29/05/23.
//

import UIKit
import AVFoundation

protocol ChatScreenProtocol: AnyObject {
    func sendMessage(text: String)
}

class ChatScreen: UIView {

    var player: AVAudioPlayer?
    
    private weak var delegate: ChatScreenProtocol?
    
    public func delegate(delegate: ChatScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backGround
        return view
    }()
   
    lazy var messageBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
   
    lazy var sendButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .orange
        btn.clipsToBounds = true
        btn.layer.cornerRadius =  15 //25.5
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.setImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        btn.tintColor = .white
        btn.isEnabled = false
        btn.transform = .init(scaleX: 0.8, y: 0.8)// nasce com tamanho menor depois aumenta
        btn.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        return btn
    }()
    

    
    lazy var inputMessageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .asciiCapable
        tf.placeholder = "Digite aqui"
        tf.font = UIFont.helveticaNeueMedium(size: 16) // customFont+extension
       // tf.isSecureTextEntry = false
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none // retirando linhas
        tableView.showsVerticalScrollIndicator = false // desativando scrool indicator
        // TO DO: Register
        tableView.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1) // tableView Contraria/ append item de baixo pra cima
        return tableView
    }()
    
    @objc func tappedSendButton(){
        sendButton.touchAnimation() // extension
        playSounnd()//
        delegate?.sendMessage(text: inputMessageTextField.text ?? "") // enviando texto
        pushMessage() 
        
        
    }
    
    private func pushMessage(){
        inputMessageTextField.text = ""
        sendButton.isEnabled = false
        sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    private func playSounnd(){
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print("Error ao tocar o som: \(error.localizedDescription)")
        }
    }
    
    public func setupTextFieldDelegate(delegate: UITextFieldDelegate){
        inputMessageTextField.delegate = delegate
    }
    public func setupTableViewProtocol(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements(){
        addSubview(tableView)
        addSubview(messageInputView)
        addSubview(sendButton)
        messageInputView.addSubview(messageBarView)
        messageInputView.addSubview(inputMessageTextField)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate( [
           
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),// layout sobe com teclado
            messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBarView.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
            messageBarView.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
            messageBarView.heightAnchor.constraint(equalToConstant: 55),
            messageBarView.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: messageBarView.trailingAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalToConstant: 65),
            sendButton.widthAnchor.constraint(equalToConstant: 65),
            sendButton.bottomAnchor.constraint(equalTo: messageBarView.bottomAnchor, constant: -10),
            
            inputMessageTextField.leadingAnchor.constraint(equalTo: messageBarView.leadingAnchor, constant: 20),
            inputMessageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            
            inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageTextField.centerYAnchor.constraint(equalTo: messageBarView.centerYAnchor)
        ])
    }
}
