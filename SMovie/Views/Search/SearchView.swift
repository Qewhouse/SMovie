
import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTupFilterButton()
}

final class SearchView: UIView {
    
    public weak var delegate: SearchViewDelegate?
    lazy var customTVC = CustomTableViewCell()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = Theme.appColor
        searchBar.searchTextField.backgroundColor = Theme.appColor
        searchBar.searchTextField.textColor = .label
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Theme.violetColor.cgColor
        searchBar.searchTextField.layer.cornerRadius = 17
        searchBar.searchTextField.clipsToBounds = true
        searchBar.barStyle = .default
        searchBar.placeholder = "Enter movie"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = Theme.appColor
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = Theme.appColor
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter")?.withTintColor(Theme.reversedAppColor, renderingMode: .alwaysOriginal),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        filterButton.addTarget(self,
                               action: #selector(filterButtonTapped),
                               for: .touchUpInside)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier:
                                    SearchCollectionViewCell.identifier)
        tableView.register(SearchTableViewCell.self,
                           forCellReuseIdentifier: SearchTableViewCell.identifier)
        addConstraints()
    }
    
    @objc func filterButtonTapped() {
        delegate?.didTupFilterButton()
    }
    
    private func addConstraints() {
        addSubviews(searchBar, collectionView, tableView)
        searchBar.addSubview(filterButton)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
            filterButton.centerYAnchor.constraint(equalTo: searchBar.searchTextField.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -15),
            filterButton.widthAnchor.constraint(equalToConstant: 25),
            filterButton.heightAnchor.constraint(equalToConstant: 25),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:25),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 1),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
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

