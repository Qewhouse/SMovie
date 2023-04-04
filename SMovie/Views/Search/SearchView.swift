
import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTupFilterButton()
}

final class SearchView: UIView {
    
    public weak var delegate: SearchViewDelegate?

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.textColor = .label
        searchBar.barStyle = .default
        searchBar.placeholder = "Enter movie"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 200
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .systemBackground
        filterButton.addTarget(self,
                               action: #selector(filterButtonTapped),
                               for: .touchUpInside)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier:
                                    SearchCollectionViewCell.identifier)
        tableView.register(SearchTableViewCell.self,
                           forCellReuseIdentifier: SearchTableViewCell.identifier)
        addSubviews(searchBar, collectionView, tableView)
        searchBar.addSubview(filterButton)
        addConstraints()
    }
    
    @objc func filterButtonTapped() {
        delegate?.didTupFilterButton()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterButton.centerYAnchor.constraint(equalTo: searchBar.searchTextField.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -15),
            filterButton.widthAnchor.constraint(equalToConstant: 25),
            filterButton.heightAnchor.constraint(equalToConstant: 25),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 3),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    // меняем стиль searchBar при переходе на темную тему
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            searchBar.barStyle = traitCollection.userInterfaceStyle == .dark ? .black : .default
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

