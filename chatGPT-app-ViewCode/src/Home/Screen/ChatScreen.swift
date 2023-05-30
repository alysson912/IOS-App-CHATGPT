//
//  HomeScreen.swift
//  chatGPT-app-ViewCode
//
//  Created by ALYSSON DODO on 29/05/23.
//

import UIKit

class ChatScreen: UIView {

    lazy var genericLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ola Mundo !"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addViews()
        setupConstraints()
    }
    
    private func addViews(){
        addSubview(genericLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate( [
            genericLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genericLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}
