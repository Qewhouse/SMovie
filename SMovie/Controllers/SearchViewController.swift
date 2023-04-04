
import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        setDelegates()
        setUpView()
    }
    
    private func setDelegates() {
        searchView.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
    
    private func setUpView() {
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
        return CGSize(width: collectionView.frame.width/2.5,
                      height: collectionView.frame.height/1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier,
                                                      for: indexPath)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.label.cgColor
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
}

//MARK: - Filter button
extension SearchViewController: SearchViewDelegate {
    func didTupFilterButton() {
        print("Azazaza")
    }
}
