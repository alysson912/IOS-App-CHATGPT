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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate(delegate: self)
        viewModel.featchMessage(message: "Cria uma funcao com swift")
    
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
