//
//  ViewCodeProtocol.swift
//  DSKit
//
//  Created by Jose Julio on 15/12/25.
//

import Foundation

public protocol ViewCodeProtocol {
    func setupViewCode()
    func addViews()
    func addConstraints()
    func setupViews()
    func setupAccessibility()
}

public extension ViewCodeProtocol {
    func setupViewCode() {
        addViews()
        addConstraints()
        setupViews()
        setupAccessibility()
    }
    func setupViews() {}
}