//  DrawDelegateProtocol.swift
//  Pokedrop

import Foundation
import UIKit

protocol OpenControllerDrawDelegate {
    func readyToDraw() -> Void
    func switchLoader(show: Bool) -> Void
}

protocol OpenViewDrawDelegte {
    func pokemonImage(at idx: Int) -> UIImage
    func launchDrawFetch() -> Void
}
