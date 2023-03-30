//
//  GiffScreen.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 21/02/23.
//

import UIKit

class GiffScreen: UIView {
    var giffCollectionView: GiffCollectionView = GiffCollectionView()
    private let giffViewModel: GiffViewModel = GiffViewModel.shared
    
    lazy var getMoreGiffButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Carregar Mais", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.isHidden = true
        button.addTarget(self, action: #selector(tappedLoadMoreGiffs), for: .touchUpInside)

        
        return button
    }()
        
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
        activityIndicator.startAnimating()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedLoadMoreGiffs(_ sender: UIButton) {
        giffViewModel.getMoreGiffs()
        showButton(show: false)
    }
    
    public func configCollectionView(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource) {
        giffCollectionView.setupCollectionViewDelegate(delegate: delegate, datasource: datasource)
    }
    
    public func reloadCollectionViewData() {
        giffCollectionView.collection.reloadData()
    }
    
    public func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    public func showButton(show: Bool) {
        if show {
            UIView.animate(withDuration: 1) {
                self.getMoreGiffButton.isHidden = false
                self.getMoreGiffButton.transform = CGAffineTransform(translationX: 0, y: -70)
                
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.getMoreGiffButton.isHidden = false
                self.getMoreGiffButton.transform = CGAffineTransform(translationX: 0, y: self.getMoreGiffButton.frame.height)
                
            }
        }
    }
    
    private func setupElements() {
        addSubview(giffCollectionView.collection)
        addSubview(getMoreGiffButton)
        giffCollectionView.collection.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            giffCollectionView.collection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            giffCollectionView.collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            giffCollectionView.collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            giffCollectionView.collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            getMoreGiffButton.topAnchor.constraint(equalTo: giffCollectionView.collection.bottomAnchor, constant: 10),
            getMoreGiffButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            getMoreGiffButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            getMoreGiffButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerYAnchor.constraint(equalTo: giffCollectionView.collection.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: giffCollectionView.collection.centerXAnchor, constant: -20)
        ])
        
        giffCollectionView.collection.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
}
