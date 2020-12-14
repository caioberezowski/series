//
//  SerieViewController.swift
//  Series API
//
//  Created by Caio Berezowski on 12/12/20.
//

import UIKit

class SerieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = SerieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPopularSerieData()
    }

    private func loadPopularSerieData() {
        viewModel.fetchPopularSeriesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }

}

extension SerieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SerieTableViewCell
            
            let serie = viewModel.cellForRowAt(indexPath: indexPath)
            cell.setCellWithValuesOf(serie)
            
            return cell
        }
    }

