//
//  NetworkService.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

//    private let urlImage = "https://image.tmdb.org/t/p/w500/A6uiMhZaJA6KHmzx1qTJfNMaWuf.jpg"

import Foundation

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
    
    func fetchDiscoverMovie() {
        guard let request = makeRequest(lastLoadedPageMovie, "movie") else {return assertionFailure("Error photo request")}
        print(request)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Swift.Result<MovieResult, Error>) in
            
            guard let self else { return }
            switch result {
            case .success(let discoverMovie):
                for movie in discoverMovie.results {
                    self.movies.append(Movie(from: movie))
                }
                print(self.movies)
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
                    self.tv.append(TV(from: movie))
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
        print(request)
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
        print(request)
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
    
    func fetchGenre() {
        guard let url = URL(string: baseURL + "/3/genre/movie/list?api_key=\(apiKey)") else { return  }
        print(url)
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
