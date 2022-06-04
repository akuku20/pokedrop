//  OpenBallViewController.swift
//  Pokedrop

import Foundation
import UIKit

final class OpenBallViewController: BaseViewController {
    
    //MARK: - Variables
    
    private var mainView = OpenBallView()
    private var viewModel: OpenBallViewModel!
    
    //MARK: - Lifecycle
    
    convenience init(viewModel: OpenBallViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
        self.mainView.delegate = self.viewModel
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavBar(title: "Open Poké Ball")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        mainView.configure(image: viewModel.image,
                           name: viewModel.name,
                           description: viewModel.description,
                           buttonText: viewModel.buttonString)
        
        mainView.onBuyPress = {
            self.viewModel.openPokeball()
        }
    }
    
}

//MARK: - OpenControllerDrawDelegate

extension OpenBallViewController: OpenControllerDrawDelegate {
    func readyToDraw() {
        mainView.beginDraw(idx: viewModel.resultIndex)
    }
    
    func switchLoader(show: Bool) {
        show
        ? showLoader()
        : hideLoader()
    }
}

//MARK: - UIGestureRecognizerDelegate

extension OpenBallViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        mainView.isUserInteractionEnabled
    }
}
