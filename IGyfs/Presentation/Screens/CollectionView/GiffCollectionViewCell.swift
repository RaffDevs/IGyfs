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
        let plusIconImage = UIImage(systemName: "plus")
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(plusIconImage, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(symbolConfig, forImageIn: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tappedLoadMoreGiffs), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let showGiffViewController = ShowGiffViewController()
        showGiffViewController.giffData = giffData
        giffViewModel.showCurrentGiff(viewController: showGiffViewController)
    }
    
    
    override func prepareForReuse() {
        image.image = UIImage()
        super.prepareForReuse()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        clipsToBounds = true
        layer.cornerRadius = 3
        setupElement()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(giff: Giff?, isCellAction: Bool = false) {
        if (isCellAction) {
            activityIndicator.stopAnimating()
           setupLoadMoreButtonElement()
        } else {
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
        
        
    }
    
    @objc private func tappedLoadMoreGiffs(_ sender: UIButton) {
        giffViewModel.getMoreGiffs()
    }
    
    private func setupLoadMoreButtonElement() {
        contentView.addSubview(label)
        contentView.addSubview(button)

        
        NSLayoutConstraint.activate([
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    private func setupGiffCellElement() {
        
        contentView.addSubview(image)
        
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
