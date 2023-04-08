
import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let categoriesArray = ["All", "Action", "Adventure", "Mystery", "Fantasy", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegates()
        setUpView()
    }
    
    private func setUpDelegates() {
        searchView.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
    
    private func setUpView() {
        title = "Search"
        tabBarItem.title = nil
        
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier,
                                                 for: indexPath) as! SearchTableViewCell
        
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
