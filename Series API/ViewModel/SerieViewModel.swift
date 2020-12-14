//
//  SerieViewModel.swift
//  Series API
//
//  Created by Caio Berezowski on 12/12/20.
//

import Foundation

class SerieViewModel {
    private var apiService = APIService()
    private var popularSeries = [Serie]()
    
    func  fetchPopularSeriesData(completion: @escaping () -> ()) {
        apiService.getPopularSeriesData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.popularSeries = listOf.series
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularSeries.count != 0  {
            return popularSeries.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Serie {
        return popularSeries[indexPath.row]
    }
}
