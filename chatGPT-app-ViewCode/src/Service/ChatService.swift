//
//  ChatService.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 30/05/23.
//

import UIKit

class ChatService: ServiceManager {
    
    // mrequisicao
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void){
        token.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.choices?.first?.text else {
                        completion(.failure(.missingChoiseText))
                        return
                    }
                    completion(.success(text))
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        })
    }
    
}
