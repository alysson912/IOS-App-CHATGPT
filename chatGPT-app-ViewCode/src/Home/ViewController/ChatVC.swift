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
    
    
    
    
    override func loadView() {
        screen = ChatScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogoToNavigationBarItem(image: UIImage(named: "logo") ?? UIImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.setupTableViewProtocol(delegate: self, dataSource: self)
        screen?.setupTextFieldDelegate(delegate: self)
        viewModel.delegate(delegate: self)
        viewModel.featchMessage(message: "Cria uma funcao com swift")
        
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
        print("Deu Bom")
    }
    
    func error(message: String) {
        print("Deu Ruim: \(message)")
    }
    
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}
