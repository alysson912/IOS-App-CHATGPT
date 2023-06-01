//
//  MessageModel.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 31/05/23.
//

import UIKit

enum TypeMessage {
    case user
    case chatGPT
}

struct MessageModel {

    var message: String
    var date: Date
    var typeMessage: TypeMessage
    
}
