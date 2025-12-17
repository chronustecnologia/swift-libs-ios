//
//  CadastroView.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 15/12/25.
//

import UIKit
import DSKit

struct CadastroModel {
    let button: String
}

protocol CadastroDelegate: AnyObject {
    func didTap()
}

final class CadastroView: UIView {
    
    private lazy var button: SLButton = {
        let button = SLButton()
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CadastroDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func didTapAction() {
        delegate?.didTap()
    }
    
    func setup(model: CadastroModel) {
        button.setTitle(model.button, for: .normal)
    }
}

extension CadastroView: ViewCodeProtocol {
    
    func addViews() {
        addSubview(button)
    }
    
    func addConstraints() {
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupAccessibility() {}
    
    func setupViews() {
        backgroundColor = .green
    }
}
