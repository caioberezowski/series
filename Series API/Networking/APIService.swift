//
//  APIService.swift
//  Series API
//
//  Created by Caio Berezowski on 12/12/20.
//

import Foundation

class APIService {
    private var dataTask: URLSessionDataTask?
    
    func getPopularSeriesData(completion:  @escaping (Result<SeriesData, Error>) -> Void) {
       
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/tv/week?&language=pt-BR")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyOGViOWU2NTE2NjhlNWUxN2Y4MzBhZTNiM2YzNWM1OSIsInN1YiI6IjVmY2U5NmVlNmFmOGY4MDAzYzA5MWNmZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IFjBo3uHyIxVV8Aut2sDDvQb7frM0mFREyLomu2X1-Y", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        let popularSeriesURL = "https://api.themoviedb.org/3/trending/tv/week?api_key=28eb9e651668e5e17f830ae3b3f35c59&language=pt-BR&page=1"
//        guard let url = URL(string: popularSeriesURL) else { return }
//
//        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else{
                print("Empty Data")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SeriesData.self, from: data)
                
                DispatchQueue.main.async{
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
