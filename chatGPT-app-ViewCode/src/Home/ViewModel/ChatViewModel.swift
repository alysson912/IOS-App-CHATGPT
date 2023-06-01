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
    private var messageList: [MessageModel] = []
    
    
    public func delegate(delegate: ChatViewModelProtocol?){
        self.delegate = delegate
    }
    
    
    
    public func featchMessage(message: String){
       
        service.sendOpenAIRequest(text: message) {[weak self] result in
            guard let self else { return }
                    
            switch result {
            case .success(let success):
                self.addMessage(message: success, type: .chatGPT)
                self.delegate?.succes()
                
            case .failure(let failure):
                self.addMessage(message: failure.localizedDescription, type: .chatGPT)
                self.delegate?.error(message: failure.localizedDescription)
            }
        }
    }
    
    public func addMessage(message: String, type: TypeMessage){ // quebra de linha, Date() data de agora
        messageList.insert(MessageModel(message: message.trimmingCharacters(in: .whitespacesAndNewlines), date: Date(), typeMessage: type), at: .zero) // insert new element in first position
    }
    
    public var numberOfRowsInSection: Int {
        return messageList.count
    }
    
    public func loadingCurrent(indexPath: IndexPath) -> MessageModel{
        return messageList[indexPath.row]
    }
    
    public func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        
        let message = loadingCurrent(indexPath: indexPath).message
        let font = UIFont.helveticaNeueMedium(size: 16)
        let estimateHeight = message.heightWithConstrainedWidth(width: 220, font: font)// -> extension p/ fazer calc da altura
        
        return estimateHeight + 65
        
    }
}
