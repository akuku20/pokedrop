//  NavBarViews.swift
//  Pokedrop

import Foundation
import UIKit

final class GiftNavBarView: UIView {
    
    private var giftImgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "giftIcon")
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }()
    
    private var giftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        widthAnchor.constraint(equalToConstant: 50).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        addSubview(giftImgView)
        giftImgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        giftImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(giftLabel)
        giftLabel.leadingAnchor.constraint(equalTo: giftImgView.trailingAnchor, constant: 4).isActive = true
        giftLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

final class CoinNavBarView: UIView {
    
    private var coinImgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "coinIcon")
        view.heightAnchor.constraint(equalToConstant: 32).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.67).isActive = true
        return view
    }()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .appFont(ofSize: 18, isBold: true)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "0"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        widthAnchor.constraint(equalToConstant: 70).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        addSubview(coinImgView)
        coinImgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        coinImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: coinImgView.trailingAnchor, constant: 4).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func changeAmount(to value: Int) {
        amountLabel.text = String(value)
    }
}
