//
//  GiffHeaderCollectionView.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffHeaderCollectionView: UICollectionReusableView {
    static let identifier = "giffHeader"
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Buscar Giff"
        textField.textColor = .white
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    
}
