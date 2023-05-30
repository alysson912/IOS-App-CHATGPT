//
//  ChatViewModel.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 30/05/23.
//

import UIKit

protocol ChatViewModelProtocol: AnyObject {
    func succes()
    func error(message: String)
}

class ChatViewModel {
    
   
    private var service: ChatService = ChatService()
    private weak var delegate: ChatViewModelProtocol?
    
    public func delegate(delegate: ChatViewModelProtocol?){
        self.delegate = delegate
    }
    
    
    
    public func featchMessage(message: String){
       
        service.sendOpenAIRequest(text: message) {[weak self] result in
            guard let self else { return }
                    
            switch result {
            case .success(let success):
                print(success)
                self.delegate?.succes()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.delegate?.error(message: failure.localizedDescription)
            }
        }
    }
    
}
