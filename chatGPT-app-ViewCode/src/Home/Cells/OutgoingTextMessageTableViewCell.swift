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
            
            myMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250), // range max size
            
            messageLabel.leadingAnchor.constraint(equalTo: myMessageView.leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: myMessageView.topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: myMessageView.bottomAnchor, constant: -15),
            messageLabel.trailingAnchor.constraint(equalTo: myMessageView.trailingAnchor, constant: -15),
            
        ])
    }
    
    public func setupCell( text: String){
        messageLabel.text = text
    }
}
