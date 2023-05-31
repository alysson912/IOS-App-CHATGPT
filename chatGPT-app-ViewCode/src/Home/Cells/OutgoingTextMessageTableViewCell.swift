//
//  OutgoingTextMessageTableViewCell.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 31/05/23.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {
    
    static  let identifier: String = String(describing: OutgoingTextMessageTableViewCell.self)
    
    lazy var myMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner] // custom cornerRadius
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.helveticaNeueMedium(size: 16)
        label.numberOfLines = 0 // automatic lines
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none // disable select cell
        backgroundColor = .backGround
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addElements(){
        addSubview(myMessageView)
        myMessageView.addSubview(messageLabel)
    }
    
    private func configConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
}
