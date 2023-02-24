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
        
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = SDAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    override func prepareForReuse() {
        image.image = UIImage()

        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(giff: Giff) {
        giffViewModel.loadImageGiff(urlString: giff.mediaUrl) { imageData in
            guard let giffImage = imageData else { return }
            let animatedImage = SDAnimatedImage(data: giffImage)
            self.image.image = animatedImage

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
            image.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
