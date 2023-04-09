
import UIKit

final class FavouriteViewController: UIViewController {
    
    private let favoritesView = FavoritesView()

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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier,
                                                 for: indexPath) as! FavoritesTableViewCell
        
        return cell
    }
}
