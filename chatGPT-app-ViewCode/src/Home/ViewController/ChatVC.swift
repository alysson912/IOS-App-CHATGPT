//
//  ViewController.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 29/05/23.
// 

import UIKit
import OpenAISwift



class ChatVC: UIViewController {
    
    private var viewModel: ChatViewModel = ChatViewModel()
    private var screen: ChatScreen?
    private var loading: Loading?
    
    override func loadView() {
        screen = ChatScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogoToNavigationBarItem(image: UIImage(named: "logo") ?? UIImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading = Loading(viewController: self)
        screen?.setupTableViewProtocol(delegate: self, dataSource: self)
        screen?.setupTextFieldDelegate(delegate: self)
        viewModel.delegate(delegate: self)
        hideKeyboardWhenTappedAround()
        screen?.delegate(delegate: self)
        viewModel.featchMessage(message: "Cria uma funcao com swift")
        
    }
    
    func vibrate(){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func reloadTableView(){
        screen?.reloadTableView()
        vibrate()
    }
}

extension ChatVC: ChatScreenProtocol {
    func sendMessage(text: String) {
        viewModel.addMessage(message: text, type: .user)
        screen?.reloadTableView()
        loading?.show(message: "")
        viewModel.featchMessage(message: text)
    }
}

extension ChatVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return false }
        let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        
        if txtAfterUpdate.isEmpty { // animation
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.screen?.sendButton.isEnabled = false
                self.screen?.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        } else { // animation
            UIView.animate(withDuration: 0.3, delay: 0,usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.screen?.sendButton.isEnabled = true
                self.screen?.sendButton.transform = .identity
            }, completion: { _ in
            })
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ChatVC: ChatViewModelProtocol {
    func succes() {
        loading?.hide()
        reloadTableView()
        vibrate()
    }
    
    func error(message: String) {
        loading?.hide()
        reloadTableView()
        vibrate()
    }
    
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.loadingCurrent(indexPath: indexPath)
        switch message.typeMessage {
            
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as?
            OutgoingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
            
        case .chatGPT:
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as?
            IncomingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
}
