//
//  PopulationViewController.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import UIKit

class PopulationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // MARK: - private - Parameters
    private let viewModel: PopulationViewModel
    
    // MARK: - ViewController life cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: PopulationViewModel = DefaultPopulationViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: PopulationViewController.self), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViews()
    }
    
    // MARK: - private - Sync DataSource & Views
    private func updateViews() {
        if segmentedControl.selectedSegmentIndex == 0 {
            viewModel.getStates(completion: { [weak self] error in
                DispatchQueue.main.sync {
                    self?.tableView.reloadData()
                }
            })
        } else {
            viewModel.getNations(completion: { [weak self] error in
                DispatchQueue.main.sync {
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    // MARK: - @IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        updateViews()
    }
}


extension PopulationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ?
        viewModel.statesData.count : viewModel.nationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: restorationIdentifier)
        let placeHolder = "N/D"
        if segmentedControl.selectedSegmentIndex == 0 {
            let data = viewModel.statesData[indexPath.row]
            cell.textLabel?.text = data.State ?? placeHolder
            cell.detailTextLabel?.text = data.Population != nil ? String(data.Population!) : placeHolder
        } else {
            let data = viewModel.nationsData[indexPath.row]
            cell.textLabel?.text = data.Nation ?? placeHolder
            cell.detailTextLabel?.text = data.Population != nil ? String(data.Population!) : placeHolder
        }
        return cell
    }
}

