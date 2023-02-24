//
//  GiffCollectionViewCell.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit
import SDWebImage


class GiffCollectionViewCell: UICollectionViewCell {
    static let identifier = "GiffCollectionViewCell"
    private let giffViewModel: GiffViewModel = GiffViewModel.shared
    
    lazy var image: UIImageView = {
        let image = SDAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carregar Mais"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    
    override func prepareForReuse() {
        image.image = UIImage()

        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 3
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(giff: Giff?, isCellAction: Bool = false) {
        if (isCellAction) {
            image.isHidden = true
        } else {
            label.isHidden = true
            button.isHidden = true
            
            if let giffData = giff {
                giffViewModel.loadImageGiff(urlString: giffData.mediaUrl) { imageData in
                    guard let giffImage = imageData else { return }
                    let animatedImage = SDAnimatedImage(data: giffImage)
                    self.image.image = animatedImage
                }
            }
            
            
        }
        
        
    }
    
    private func setupElements() {
        contentView.addSubview(image)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
                        
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}
