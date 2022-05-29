//  OptionalExtension.swift
//  Pokedrop

import Foundation

extension Optional {
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        self != nil
    }
}
