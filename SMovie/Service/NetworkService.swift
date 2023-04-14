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
    private var lastLoadedPage = 1

    private(set) var detailMovie: DetailMovie?
    private(set) var detailTv: DetailTv?
    private(set) var genre = [Genre]()
    private(set) var image = UIImage()
    private(set) var media = [Media]()
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    func fetchMedia(_ mediaType: MediaType) {
        guard let request = makeRequest(lastLoadedPage, mediaType.rawValue) else {return assertionFailure("Error photo request")}
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<MediaResult, Error>) in
            
            guard let self else { return }
            switch result {
            case .success(var media):
                for result in media.results {
                    var media = result
                    media.mediaType = mediaType
                    self.media.append(Media(from: media))
                }
                self.lastLoadedPage += 1
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
                print(self.genre)
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
    }
    
    func fetchImage(_ posterPath: String?, id: Int?, completion: @escaping (UIImage?) -> ()) {
        guard let posterPath, let id else { return }
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
    
    func fetchFind(text: String, completion: @escaping (MediaResult?) -> ()) {
        guard let request = makeRequestSearch(text: text) else {return assertionFailure("Error photo request")}

        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<MediaResult, Error>) in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                assertionFailure("Error - \(error)")
            }
        }
        task.resume()
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
    
    private func makeRequestSearch(text: String) -> URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = "/3/search/multi"
        urlComponents?.queryItems = [
            .init(name: "api_key", value: "\(apiKey)"),
            .init(name: "query", value: text)
        ]
        
        guard let url = urlComponents?.url else {
            assertionFailure("Failed to create URL")
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
