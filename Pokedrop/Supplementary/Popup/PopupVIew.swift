//  PopupVIew.swift
//  Pokedrop

import UIKit

final class PopupView: BaseView {
    
    var onButtonPress: (() -> Void)!
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 18, isBold: true)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var buttonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .appFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var button: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    override init() {
        super.init()
        setUp()
    }
    
    private func setUp() {
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        
        containerView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        containerView.addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        
        containerView.addSubview(button)
        button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        button.addGestureRecognizer(tap)
        
        button.addSubview(buttonLabel)
        buttonLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        buttonLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        containerView.addSubview(separator)
        separator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
    }
    
    @objc private func buttonPressed() {
        onButtonPress()
    }
    
    func configure(title: String, message: String?, attributedMessage: NSMutableAttributedString?, buttonTitle: String, action: @escaping () -> Void) {
        titleLabel.text = title
        buttonLabel.text = buttonTitle
        onButtonPress = action
        if let msg = message {
            messageLabel.text = msg
        } else if let msg = attributedMessage {
            messageLabel.attributedText = msg
        } else {
            messageLabel.text = ""
        }
    }
}
