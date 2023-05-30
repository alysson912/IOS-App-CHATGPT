//
//  ViewController.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 29/05/23.
// 

import UIKit
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ViewController: UIViewController {
    
    
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    var token: OpenAISwift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        token = OpenAISwift(authToken: API.authToken)
        sendOpenAIRequest(text: "qual o tipo de arquivo um aplicativo ios usa") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // metodo asincrono, guarda a func na memora ate o retorno da api
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void){
        token?.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
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

