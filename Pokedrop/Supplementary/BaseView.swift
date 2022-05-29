// BaseView.swift
// Pokedrop

import UIKit

open class BaseView: UIView {
    public init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) { nil }
}
