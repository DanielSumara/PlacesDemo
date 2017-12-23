//
//  PlaceListViewController.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public final class PlaceListViewController: UITableViewController, PlaceListView {
    
    // MARK:- Properties
    
    private var viewModel: PlaceListViewModel
    
    // MARK:- Lifecycle
    
    public init(with viewModel: PlaceListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.view = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ostatnio oglądane"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadData()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.bind(with: viewModel.model(for: indexPath.row))
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.bind(with: viewModel.model(for: indexPath.row))
            return cell
        }
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectPlace(at: indexPath.row)
    }
    
    // MARK:- API
    
    public func reload() {
        tableView.reloadData()
    }
    
}

private extension UITableViewCell {
    
    func bind(with place: Place) {
        textLabel?.text = place.name
        detailTextLabel?.text = Coordinates(from: place).description
    }
    
}
