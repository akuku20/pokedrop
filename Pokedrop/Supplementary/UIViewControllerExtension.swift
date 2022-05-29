//  DefaultNavBar.swift
//  Pokedrop

import UIKit

extension UIViewController {
    
    func addDefaultNavBar(title: String) {
        navigationController?.navigationBar.backgroundColor = .white
                
        let titleLabel = UILabel()
        titleLabel.font = .appFont(ofSize: 21, isBold: true)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .black
        titleLabel.text = title
        navigationItem.titleView = titleLabel
        
        let coinImgView = UIImageView()
        coinImgView.translatesAutoresizingMaskIntoConstraints = false
        coinImgView.contentMode = .scaleAspectFit
        coinImgView.image = UIImage(named: "coinIcon")
        coinImgView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        coinImgView.widthAnchor.constraint(equalTo: coinImgView.heightAnchor, multiplier: 0.67).isActive = true
        
        let amountLabel = UILabel()
        amountLabel.font = .appFont(ofSize: 18, isBold: true)
        amountLabel.textAlignment = .left
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.numberOfLines = 1
        amountLabel.textColor = .black
        amountLabel.text = "0"
        
        let rightBarView = UIView()
        rightBarView.translatesAutoresizingMaskIntoConstraints = false
        rightBarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        rightBarView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        rightBarView.addSubview(coinImgView)
        coinImgView.leadingAnchor.constraint(equalTo: rightBarView.leadingAnchor).isActive = true
        coinImgView.centerYAnchor.constraint(equalTo: rightBarView.centerYAnchor).isActive = true
        
        rightBarView.addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: coinImgView.trailingAnchor, constant: 4).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: rightBarView.centerYAnchor).isActive = true
        
        let rightItem = UIBarButtonItem()
        rightItem.customView = rightBarView
        
        navigationItem.rightBarButtonItem = rightItem
        
        let giftImgView = UIImageView()
        giftImgView.translatesAutoresizingMaskIntoConstraints = false
        giftImgView.contentMode = .scaleAspectFit
        giftImgView.image = UIImage(named: "giftIcon")
        giftImgView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        giftImgView.widthAnchor.constraint(equalTo: giftImgView.heightAnchor).isActive = true
        
        let giftLabel = UILabel()
        giftLabel.font = UIFont.systemFont(ofSize: 25)
        giftLabel.textAlignment = .left
        giftLabel.translatesAutoresizingMaskIntoConstraints = false
        giftLabel.numberOfLines = 1
        giftLabel.textColor = .black
        giftLabel.text = "!"
        
        let leftBarView = UIView()
        leftBarView.translatesAutoresizingMaskIntoConstraints = false
        leftBarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        leftBarView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        leftBarView.addSubview(giftImgView)
        giftImgView.leadingAnchor.constraint(equalTo: leftBarView.leadingAnchor).isActive = true
        giftImgView.centerYAnchor.constraint(equalTo: leftBarView.centerYAnchor).isActive = true
        
        leftBarView.addSubview(giftLabel)
        giftLabel.leadingAnchor.constraint(equalTo: giftImgView.trailingAnchor, constant: 4).isActive = true
        giftLabel.centerYAnchor.constraint(equalTo: leftBarView.centerYAnchor).isActive = true
        
        let leftItem = UIBarButtonItem()
        leftItem.customView = leftBarView
        
        navigationItem.leftBarButtonItem = leftItem
    }
}
