//
//  HomeViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var mockData = HomeMockData.shared
    
    let homeView: HomeView = {
        let view = HomeView()
        view.collectionView.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sections = HomeMockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "appColor")
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(homeView)
        homeView.collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: ExampleCell.identifier)
        homeView.collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.identifier)
        homeView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        homeView.collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.identifier)
        homeView.collectionView.collectionViewLayout = createLayout()
        
        
    }
    
    private func setDelegates () {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at \(indexPath.row)")
    }
}


//MARK: - UICollectionViewDataSource

extension HomeViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections [section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        //posters
            
        case .posters(let posters):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.identifier, for: indexPath) as? PosterCell else { return UICollectionViewCell()
                
            }
            cell.configureCell(image: UIImage(named: posters[indexPath.row].image) ?? UIImage(),
                               name: posters[indexPath.row].title,
                               category: posters[indexPath.row].category)
            return cell
            
        //categories
            
        case .categories(let category):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(categoryText: category[indexPath.row].category)
        
            return cell
            
        //examples
            
        case .examples(let examples):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCell.identifier, for: indexPath) as? ExampleCell else {return UICollectionViewCell()}
            cell.configureCell(image: UIImage(named: examples[indexPath.row].image) ?? UIImage(),
                               category: examples[indexPath.row].category,
                               name: examples[indexPath.row].title,
                               time: examples[indexPath.row].time,
                               rank: examples[indexPath.row].rank)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSupplementaryView.identifier,
                for: indexPath) as! HeaderSupplementaryView
            
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

//MARK: - Create Layout

extension HomeViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else {return nil}
            let section = self.sections[sectionIndex]
            switch section {
            case .posters(_):
                return self.createPosterSection()
            case .categories(_):
                return self.createCategorySection()
            case .examples(_):
                return self.createExampleSection()
            }
        }
    }
    
    //Poster Section
    
    private func createPosterSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.55),
                                                                         heightDimension: .fractionalHeight(0.5)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPagingCentered,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [],
                                          contentInsets: false)
         
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.7
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    // Category Section
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        

        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.2),
                                                                         heightDimension: .fractionalHeight(0.06)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 20,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
         
        section.contentInsets = .init(top: 5, leading: 30, bottom: 5, trailing: 0)
        return section
    }
    
    //Example Section
    
    private func createExampleSection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.17)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.85),
                                                                       heightDimension: .fractionalHeight(0.33)),
                                                                       subitem: item,
                                                                       count: 2)

        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
         
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }

    private func supplementaryHeaderItem () -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(20)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
    
    private func createLayoutSection (group: NSCollectionLayoutGroup,
                                      behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                      interGroupSpacing: CGFloat,
                                      supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                      contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
}

//MARK: - Set Constraints

extension HomeViewController {
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    
}
