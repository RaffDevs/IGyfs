//
//  GiffHeaderCollectionView.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffHeaderCollectionView: UICollectionReusableView {
    static let identifier = "giffHeader"
    
    private let giffViewModel = GiffViewModel.shared
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Buscar"
        textField.attributedPlaceholder = NSAttributedString(string: "Buscar Giff", attributes: attributes)
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private func setupHeaderTextFieldDelegate(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
        setupHeaderTextFieldDelegate(delegate: self)
    
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
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    
}

extension GiffHeaderCollectionView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textSearch = textField.text {
            if (textSearch.isEmpty) {
                giffViewModel.getTrendingGiffs()
            } else {
                giffViewModel.searchForGiffs(search: textSearch)
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text?.removeAll()
    }
}
