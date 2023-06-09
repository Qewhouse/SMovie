//
//  SeeAllViewController.swift
//  SMovie
//
//  Created by Вова on 20.04.2023.
//

import UIKit

final class SeeAllViewController: UIViewController {
    
    private let seeAllView = SeeAllView()
    
    private var media = [Media]()
    
    var networkService = NetworkService.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        seeAllView.tableView.delegate = self
        seeAllView.tableView.dataSource = self

    }
    
    func configureSeeAll (with media: [Media]) {
        self.media = media
    }
    
    private func setUpView() {
        
        configureNavigationBar()
        self.view.backgroundColor = Theme.appColor
        view.addSubview(seeAllView)
        NSLayoutConstraint.activate([
            seeAllView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seeAllView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            seeAllView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            seeAllView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureNavigationBar() {
        navigationItem.title = "See All"
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        let backButtonImage = UIImage(named: "backArrow")
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.hidesBackButton = true
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

}



//MARK: - TableView
extension SeeAllViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath) as! SearchTableViewCell
        let item = media[indexPath.row]
        
        let mediaType = item.mediaType!
        let name = mediaType == .movie ? item.title : item.name
        let date = mediaType == .movie ? item.releaseDate : item.firstAirDate
        let posterPath = item.posterPath
        let id = item.id!
        let rank = item.popularity!/1000
   
        
        networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            
            self.networkService.fetchDetail(id: id, mediaType: mediaType) { detailData in
                
                let minutes = mediaType == .movie ? detailData?.runtime ?? 120 : (detailData?.episodeRunTime?.first ?? 40)
                
                cell.configure(with: image,
                               name: name,
                               minutes: minutes,
                               date: date)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(id: Int(media[indexPath.row].id!),
                                      mediaType: .movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}


