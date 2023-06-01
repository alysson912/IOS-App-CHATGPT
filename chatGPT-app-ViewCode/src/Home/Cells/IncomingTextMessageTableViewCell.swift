//
//  IncomingTextMessageTableViewCell.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 31/05/23.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static  let identifier: String = String(describing: IncomingTextMessageTableViewCell.self)
    
    lazy var contactMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .incomingColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner] // custom cornerRadius
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
        transform = CGAffineTransform(scaleX: 1, y: -1)
        backgroundColor = .backGround
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addElements(){
        addSubview(contactMessageView)
        contactMessageView.addSubview(messageLabel)
    }
    
    private func configConstraints(){
        NSLayoutConstraint.activate([
            
            contactMessageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contactMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contactMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250), // range max size
            
            messageLabel.leadingAnchor.constraint(equalTo: contactMessageView.leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: contactMessageView.topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: contactMessageView.bottomAnchor, constant: -15),
            messageLabel.trailingAnchor.constraint(equalTo: contactMessageView.trailingAnchor, constant: -15),
            
        ])
    }
    
    public func setupCell( data: MessageModel){
        messageLabel.text = data.message
    }
}
