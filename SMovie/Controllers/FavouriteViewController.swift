
import UIKit

final class FavouriteViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    var moviesArray: [MoviesCR] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesArray = MovieCoreDataModel.shared.getAllMovies()
        favoritesView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        favoritesView.tableView.delegate = self
        favoritesView.tableView.dataSource = self
    }
    
    private func setUpView() {
        title = "Favorites"
        tabBarItem.title = nil
        
        view.addSubview(favoritesView)
        NSLayoutConstraint.activate([
            favoritesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier,
                                                 for: indexPath) as! FavoritesTableViewCell
        
        let movie = self.moviesArray[indexPath.row]
        
        cell.configure(with: movie.image!,
                       name: movie.name ?? "",
                       time: movie.time ?? "")
        return cell
    }
}
