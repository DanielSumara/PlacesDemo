//
//  PlaceDetailsViewController.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public final class PlaceDetailsViewController: UIViewController {
    
    // MARK:- Properties
    
    private lazy var detailsView = View()
    
    private var viewModel: PlaceDetailsViewModel
    
    // MARK:- Lifecycle
    
    public init(with viewModel: PlaceDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.view = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = detailsView
        detailsView.initialize()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateView()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.persistPlace()
    }
    
}

extension PlaceDetailsViewController: PlaceDetailsView {
    
    public func set(title: String) {
        self.title = title
    }
    
    public func set(image: UIImage) {
        detailsView.set(image: image)
    }
    
    public func set(coordinates: Coordinates) {
        detailsView.set(coordinates: coordinates)
    }
    
}
