//
//  ServiceManager.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 30/05/23.
// 

import UIKit
import OpenAISwift

class ServiceManager {

    enum OpenAIError: Error {
        case missingChoiseText
        case apiError(Error)
    }
    
    let openAIModelType: OpenAIModelType = .gpt3(.davinci)
    let token: OpenAISwift = OpenAISwift(authToken: API.authToken)
}
