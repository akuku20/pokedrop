//  UIFontExtension.swift
//  Pokedrop

import UIKit

extension UIFont {
    static func appFont(ofSize: CGFloat, isBold: Bool = false) -> UIFont {
        if isBold {
            return UIFont(name: "IBMPlexMono-SemiBold", size: ofSize)!
        } else {
            return UIFont(name: "IBMPlexMono-Regular", size: ofSize)!
        }
    }
}
