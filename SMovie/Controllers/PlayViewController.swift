
import UIKit

final class PlayViewController: UIViewController {
    
    private let playView = PlayView()
    private let categoriesArray = ["All", "Action", "Adventure", "Mystery", "Fantasy", "Others"]
    var moviesArray: [PlayesCR] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesArray = PlayCoreDataModel.shared.getAllMovies()
        playView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        playView.tableView.delegate = self
        playView.tableView.dataSource = self
        playView.collectionView.delegate = self
        playView.collectionView.dataSource = self
    }
    
    private func setUpView() {
        title = "Recent Watch"
        tabBarItem.title = nil
        
        view.addSubview(playView)
        NSLayoutConstraint.activate([
            playView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            playView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            playView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView
extension PlayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayTableViewCell.identifier,
                                                 for: indexPath) as! PlayTableViewCell
        let movie = self.moviesArray[indexPath.row]
        cell.configure(with: movie.image!,
                       name: movie.name ?? "",
                       time: movie.time ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = DetailViewController(id: 502356, mediaType: .movie)

//        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CollectionView
extension PlayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categoriesArray[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 40.0
        return CGSize(width: cellWidth, height: collectionView.frame.height/1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayCollectionViewCell.identifier, for: indexPath) as? PlayCollectionViewCell else {
            fatalError("Unable to dequeue SearchCollectionViewCell.")
        }
        cell.layer.cornerRadius = 17
        cell.layer.borderWidth = 1
        cell.backgroundColor = .secondarySystemBackground
        cell.configure(categoryText: categoriesArray[indexPath.row])
        return cell
    }
}
