//
//  IncomingTextMessageTableViewCell.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 31/05/23.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {

      static  let identifier: String =  String(describing: IncomingTextMessageTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
