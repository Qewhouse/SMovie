
import UIKit

final class SearchViewController: UIViewController {
    private let networkService = NetworkService.shared
    private let searchView = SearchView()
    private let categoriesArray = ["All", "Action", "Adventure", "Mystery", "Fantasy", "Others"]
    private var media = [Media]()
    private let movieCoreDataModel = MovieCoreDataModel.shared // создаем экземпляр класса
    
    override func viewDidLoad() {
        super.viewDidLoad()
        media = networkService.media
        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        searchView.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.searchBar.delegate = self
    }
    
    private func setUpView() {
        title = "Search"
        tabBarItem.title = nil
        
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath) as! SearchTableViewCell
        cell.selectionStyle = .none
        cell.customTableViewCell.delegate = self
        cell.customTableViewCell.index = indexPath
        
        var name = ""
        var date = ""
        
        if let title = media[indexPath.row].name {
            name = title
        } else if let title = media[indexPath.row].title {
            name = title
        }
        
        if let time = media[indexPath.row].firstAirDate {
            date = time
        } else if let time = media[indexPath.row].releaseDate {
            date = time
        }
        
        let posterPath = media[indexPath.row].posterPath
        let id = media[indexPath.row].id
        networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                cell.configure(with: image, name: name, time: date)
            }
        return cell
    }
}

//MARK: - CollectionView
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categoriesArray[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 40.0
        return CGSize(width: cellWidth, height: collectionView.frame.height/1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            fatalError("Unable to dequeue SearchCollectionViewCell.")
        }
        cell.layer.cornerRadius = 17
        cell.layer.borderWidth = 1
        cell.backgroundColor = .secondarySystemBackground
        cell.configure(categoryText: categoriesArray[indexPath.row])
        return cell
    }
}

//MARK: - Filter button
extension SearchViewController: SearchViewDelegate {
    func didTupFilterButton() {
        print("Azazaza")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        networkService.fetchFind(text: searchText) { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.media.removeAll()
            for media in result.results {
                self.media.append(Media(from: media))
            }
            self.searchView.tableView.reloadData()
        }
    }
}

//MARK: - FavoriteButton
extension SearchViewController: CustomTableViewCellDelegate {
    func didTappedHeartButton(index indexPath: IndexPath) {
        let favVC = FavouriteViewController()
        
        var name = ""
        var date = ""

        if let title = media[indexPath.row].name {
            name = title
        } else if let title = media[indexPath.row].title {
            name = title
        }
        if let time = media[indexPath.row].firstAirDate {
            date = time
        } else if let time = media[indexPath.row].releaseDate {
            date = time
        }
        
        let posterPath = media[indexPath.row].posterPath
        let id = media[indexPath.row].id
        
        networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            let movie = self.movieCoreDataModel.saveMovie(name: name,
                                                          date: date,
                                                          time: date,
                                                          image: image)
            favVC.moviesArray.append(movie)
        }
    }
}
 
