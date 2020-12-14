//
//  SerieTableViewCell.swift
//  Series API
//
//  Created by Caio Berezowski on 12/12/20.
//

import UIKit

class SerieTableViewCell: UITableViewCell {

    @IBOutlet weak var seriePoster: UIImageView!
    @IBOutlet weak var serieTitulo: UILabel!
    @IBOutlet weak var serieSinopse: UILabel!
    @IBOutlet weak var serieEstrela: UILabel!
    @IBOutlet weak var serieAvaliacoes: UILabel!
    
    
    private var urlString: String = ""
    
    func  setCellWithValuesOf(_ serie:Serie) {
        updateUI(name: serie.title, overview: serie.overview, vote_avarage: serie.rate, poster_path: serie.posterImage, vote_count: serie.count)
    }
    
    private func updateUI(name: String?, overview: String?, vote_avarage: Double?, poster_path: String?, vote_count: Int?){
        self.serieTitulo.text = name
        self.serieSinopse.text = overview
        self.serieEstrela.text = String(vote_avarage!)
        self.serieAvaliacoes.text = String(vote_count!)
        
        guard let posterString = poster_path else { return }
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.seriePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.seriePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error{
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
        
        DispatchQueue.main.async {
            if let image = UIImage(data: data){
                self.seriePoster.image = image
            }
        }
    }.resume()
    }
}
