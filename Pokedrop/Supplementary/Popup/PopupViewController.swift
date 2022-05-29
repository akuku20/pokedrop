//  PopupViewController.swift
//  Pokedrop

import Foundation
import UIKit

final class PopupViewController: UIViewController {

    struct PopupModel {
        var title: String
        var message: String?
        var attributedMessage: NSMutableAttributedString?
        var buttonTitle: String
        var action: (() -> Void)?
    }
    
    private var mainView = PopupView()
    private var model: PopupModel!
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    convenience init(model: PopupModel) {
        self.init()
        self.model = model
    }
    
    override func viewDidLoad() {
        let action = {
            self.model.action?()
            self.dismiss(animated: true)
        }
        
        mainView.configure(title: model.title,
                           message: model.message,
                           attributedMessage: model.attributedMessage,
                           buttonTitle: model.buttonTitle,
                           action: action)
    }
}
