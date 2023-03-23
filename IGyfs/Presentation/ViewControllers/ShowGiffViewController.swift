//
//  ShowGiffViewController.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 24/02/23.
//

import UIKit

class ShowGiffViewController: UIViewController {
    private var showGiffScrene:ShowGiffScreen?
    private var showGiffViewModel = ShowGiffViewModel.shared
    
    var giffData:Giff?
    
    override func loadView() {
        showGiffScrene = ShowGiffScreen()
        view = showGiffScrene
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showGiffViewModel.delegate(delegate: self)
        showGiffViewModel.setCurrentGiff(giff: giffData!)
        showGiffScrene?.setupGiffData(giff: giffData!)

    }

}

extension ShowGiffViewController: ShowGiffViewModelProtocol {
    
    func success(giff: Giff?) {
        if let giffData = giff {
            showGiffScrene?.setupGiffData(giff: giffData)
        }
    }
    
    func failure() {
        print("Erro ao buscar dados do giff")
    }
    
    
    
}
