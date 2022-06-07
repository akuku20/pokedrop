//  BaseViewController.swift
//  Pokedrop

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        appearance.shadowColor = .white.withAlphaComponent(0.5)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBar()
    }
        
    //MARK: - Navigation Bar Setup
    
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
        
        let leftView = GiftNavBarView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showHourlyReward))
        leftView.addGestureRecognizer(tap)
        
        let leftItem = UIBarButtonItem()
        leftItem.customView = leftView
        leftItem.customView?.isHidden = true
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem()
        rightItem.customView = CoinNavBarView()
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func updateNavigationBar() {
        if let rightView = navigationItem.rightBarButtonItem?.customView as? CoinNavBarView {
            rightView.changeAmount(to: CoinManager.shared.balance)
        }
        
        if let last = CoinManager.shared.lastReward, Date().timeIntervalSince(last) >= 60 {
            navigationItem.leftBarButtonItem?.customView?.isHidden = false
        } else {
            navigationItem.leftBarButtonItem?.customView?.isHidden = true
        }
    }
    
    @objc private func showHourlyReward() {
        guard view.isUserInteractionEnabled == true else { return }
        
        let fullString = NSMutableAttributedString(string: "You have been awarded\n")
        let attachment = NSTextAttachment(image: UIImage(named: "coinIcon")!)
        attachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 22)
        let attachmentString = NSAttributedString(attachment: attachment)
        fullString.append(attachmentString)
        fullString.append(NSAttributedString(string: " 300"))
        
        let action = {
            CoinManager.shared.changeBalance(by: 300, with: Date())
            self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
            self.updateNavigationBar()
        }
        
        showPopup(title: "Hourly Reward",
                  attributedMessage: fullString,
                  buttonTitle: "Ok", action: action)
    }
    
    //MARK: - Default PopUp
    
    func showPopup(title: String,
                   message: String? = nil,
                   attributedMessage: NSMutableAttributedString? = nil,
                   buttonTitle: String,
                   action: (() -> Void)? = nil) {
        
        let model = PopupViewController.PopupModel(title: title,
                                                   message: message,
                                                   attributedMessage: attributedMessage,
                                                   buttonTitle: buttonTitle,
                                                   action: action)
        let vc = PopupViewController(model: model)
        present(vc, animated: true)
    }
    
    //MARK: - Loader
    
    func showLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
