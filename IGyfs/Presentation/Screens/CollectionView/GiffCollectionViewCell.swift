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
    private var giffData: Giff? = nil
    
    lazy var image: UIImageView = {
        let image = SDAnimatedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    override func prepareForReuse() {
        showActivityIndicator(false)

        super.prepareForReuse()
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 3
        setupElement()
        setupConstraints()
        showActivityIndicator(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showActivityIndicator(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    public func setupCell(giff: Giff?, isCellAction: Bool = false) {
        activityIndicator.stopAnimating()
        setupGiffCellElement()
        
        if let giffData = giff {
            self.giffData = giff
            giffViewModel.loadImageGiff(urlString: giffData.mediaUrl) { imageData in
                self.activityIndicator.stopAnimating()

                guard let giffImage = imageData else { return }
                let animatedImage = SDAnimatedImage(data: giffImage)
                self.image.image = animatedImage
            }
        }
        
        
    }
    
    @objc private func tappedShowGiffDetails(_ sender: Any) {
        let showGiffViewController = ShowGiffViewController()
        showGiffViewController.giffData = giffData
        giffViewModel.showCurrentGiff(viewController: showGiffViewController)
    }
    
    private func setupGiffCellElement() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedShowGiffDetails))
        
        contentView.addSubview(image)
        contentView.addGestureRecognizer(tapGestureRecognizer)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupElement() {
        contentView.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
