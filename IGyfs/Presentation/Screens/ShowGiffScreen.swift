//
//  ShowGiffScreen.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import UIKit
import SDWebImage
import NotificationBannerSwift

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
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedLike), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    lazy var sharingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tappedShare), for: .touchUpInside)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupElements()
        setupConstraints()
        showGiffViewModel.registerEvents(events: self)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedLike(_ sender: UIButton) {
        showGiffViewModel.saveGiffAsFavorite()
    }
    
    @objc func tappedShare(_ sender: UIButton) {
        showGiffViewModel.shareGiff()
    }
    
    private func toggleButtons() {
        likeButton.isHidden = false
        sharingButton.isHidden = false
    }
    
    public func setupGiffData(giff: Giff) {
        showGiffViewModel.loadImageGiff(urlString: giff.mediaUrl) { imageData in
            self.activityIndicator.stopAnimating()
            guard let giffImage = imageData else { return }
            let animatedImage = SDAnimatedImage(data: giffImage)
            self.giffImage.image = animatedImage
            self.giffDescription.text = giff.title
            self.toggleButtons()

        }
    }
    
    
    private func setupElements() {
        addSubview(giffDescription)
        addSubview(giffImage)
        addSubview(activityIndicator)
        addSubview(likeButton)
        addSubview(sharingButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            giffDescription.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            giffDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            giffDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            giffImage.topAnchor.constraint(equalTo: giffDescription.bottomAnchor, constant: 10),
            giffImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            giffImage.widthAnchor.constraint(equalToConstant: 300),
            giffImage.heightAnchor.constraint(equalToConstant: 300),
            
            likeButton.centerXAnchor.constraint(equalTo: giffImage.centerXAnchor, constant: -30),
            likeButton.topAnchor.constraint(equalTo: giffImage.bottomAnchor, constant: 13),
            
            sharingButton.centerXAnchor.constraint(equalTo: giffImage.centerXAnchor, constant: 30),
            sharingButton.topAnchor.constraint(equalTo: giffImage.bottomAnchor, constant: 10),
            
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
          

        ])
    }
    
    
}

extension ShowGiffScreen: ShowGiffEvents {
    func showBanner(message: String, style: NotificationBannerSwift.BannerStyle) {
        let banner = NotificationBanner(
            title: message,
            style: style
        )
        
        banner.duration = 1
        banner.show()
    }
    
    func toogleLikeButton(toggle: Bool) {
        likeButton.tintColor = toggle ? .red : .white
    }
    
}
