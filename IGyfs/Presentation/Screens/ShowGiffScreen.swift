//
//  ShowGiffScreen.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import UIKit
import SDWebImage


class ShowGiffScreen: UIView {
    private let showGiffViewModel = ShowGiffViewModel.shared
    
    lazy var giffDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var giffImage: UIImageView = {
        let image = SDAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupGiffData(giff: Giff) {
        showGiffViewModel.loadImageGiff(urlString: giff.mediaUrl) { imageData in
            self.activityIndicator.stopAnimating()

            guard let giffImage = imageData else { return }
            let animatedImage = SDAnimatedImage(data: giffImage)
            self.giffImage.image = animatedImage
            self.giffDescription.text = giff.title
        }
    }
    
    private func setupElements() {
        addSubview(giffDescription)
        addSubview(giffImage)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            giffDescription.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            giffDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            giffDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            giffImage.topAnchor.constraint(equalTo: giffDescription.bottomAnchor, constant: 10),
            giffImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            giffImage.widthAnchor.constraint(equalToConstant: 500),
            giffImage.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    
}
