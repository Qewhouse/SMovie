//
//  NetworkService.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation
import UIKit

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    private let baseURL = "https://api.themoviedb.org"
    private let apiKey = "61642e1d2f11d7fd3210b7397b95fb9c"
    private var lastLoadedPageMovie = 1
    private var lastLoadedPageTv = 1
    
    private(set) var movies = [Movie]()
    private(set) var tv = [TV]()
    private(set) var detailMovie: DetailMovie?
    private(set) var detailTv: DetailTv?
    private(set) var genre = [Genre]()
    private(set) var image = UIImage()
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    func fetchDiscoverMovie() {
        guard let request = makeRequest(lastLoadedPageMovie, "movie") else {return assertionFailure("Error photo request")}
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<MovieResult, Error>) in
            
            guard let self else { return }
            switch result {
            case .success(let discoverMovie):
                for movie in discoverMovie.results {
                    movies.append(Movie(from: movie))
                }
                self.lastLoadedPageMovie += 1
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchDiscoverTv() {
        guard let request = makeRequest(lastLoadedPageTv, "tv") else {return assertionFailure("Error photo request")}
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<TvResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let discoverTv):
                for movie in discoverTv.results {
                    tv.append(TV(from: movie))
                }
                self.lastLoadedPageTv += 1
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchDetailMovie(id: Int) {
        guard let request = makeRequestMedia(id, "media") else {return assertionFailure("Error photo request")}
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<DetailMovieResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.detailMovie = DetailMovie(from: result)
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchDetailTv(id: Int) {
        guard let request = makeRequestMedia(id, "tv") else {return assertionFailure("Error photo request")}
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<DetailTvResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.detailTv = DetailTv(from: result)
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchGenre(media: Media) {
        guard let url = URL(string: baseURL + "/3/genre/\(media)/list?api_key=\(apiKey)") else { return  }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<GenreResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.genre = result.genres
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchImage(_ posterPath: String, id: Int, completion: @escaping (UIImage?) -> ()) {
        let itemNumber = NSNumber(value: id)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            completion(cachedImage)
        } else {
            utilityQueue.async {
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                    self.cache.setObject(image ?? UIImage(), forKey: itemNumber)
                }
            }
        }
    }
    
    private func makeRequest(_ page: Int, _ discover: String) -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = "/3/discover/\(discover)"
        urlComponents?.queryItems = [
            .init(name: "api_key", value: "\(apiKey)"),
            .init(name: "page", value: "\(page)")
        ]
        
        guard let url = urlComponents?.url else {
            assertionFailure("Failed to create URL")
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
    
    private func makeRequestMedia(_ id: Int, _ media: String) -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = "/3/\(media)/\(id)"
        urlComponents?.queryItems = [.init(name: "api_key", value: "\(apiKey)")]
        
        guard let url = urlComponents?.url else {
            assertionFailure("Failed to create URL")
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
