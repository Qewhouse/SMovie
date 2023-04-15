//
//  HomeViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var mockData = HomeMockData.shared
    
    var networkService = NetworkService.shared
    
    private var isMovie = true
    
    private var genreId: Int?
    
    var genres = [Genre]()
    
    var media = [Media]()
    
    private let categoriesArray = ["All", "TV-series", "Action", "Adventure", "Mystery", "Fantasy", "Others"]
    
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
        media = networkService.media
        genres = networkService.genre
        
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
    
    func getGenre(_ indexPath: IndexPath) -> String {
        var name = String()
        for genre in genres {
            if media[indexPath.row].genreIds![0] == genre.id {
                name = genre.name
            }
        }
        return name
    }
    
}



//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 : print ("poster at \(indexPath.item) place")
        case 1 : print ("category at \(indexPath) place - \(categoriesArray[indexPath.row])")
            
            switch categoriesArray[indexPath.row] {
                
            case "All":
                isMovie = true
                homeView.collectionView.reloadData()
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            case "TV-series":
                isMovie = false
                homeView.collectionView.reloadData()
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            case "Action":
                isMovie = true
                genreId = 28
                homeView.collectionView.reloadData()
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            default:
                print("default")
            }
        case 2 :
            print ("example at \(indexPath.item) place")
        default: break
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedPoster = IndexPath(item: 1, section: 0)
        let selectedCategory = IndexPath(item: 0, section: 1)
        
        //        homeView.collectionView.scrollToItem(at: selectedPoster, at: .centeredVertically, animated: true)
        //        collectionView.selectItem(at: selectedCategory, animated: false, scrollPosition: [])
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension HomeViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return categoriesArray.count
        case 2: return 10
        default: return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
            //posters
            
        case .posters(let posters):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.identifier, for: indexPath) as? PosterCell else { return UICollectionViewCell()
            }
            
            let movies = media.compactMap { $0.mediaType == MediaType.movie ? $0 : nil }
            let name = movies[indexPath.row].title!
            let posterPath = media[indexPath.row].posterPath
            let id = media[indexPath.row].id
            networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.configureCell(id: id!,
                                   image: image,
                                   name: name,
                                   category: self.getGenre(indexPath))
            }
            
            return cell
            
            //categories
            
        case .categories(let category):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(categoryText: categoriesArray[indexPath.row])
            
            return cell
            
            //examples
            
        case .examples(let examples):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCell.identifier, for: indexPath) as? ExampleCell else {return UICollectionViewCell()}
            //
            //            let movies = media.compactMap { $0.mediaType == MediaType.movie ? $0 : nil }
            //            print (movies)
            var data = isMovie ? media.compactMap { $0.mediaType == MediaType.movie ? $0 : nil } : media.compactMap { $0.mediaType == MediaType.tv ? $0 : nil }
            
            var sorted = [Media]()
            
            if genreId != nil {
                
                for item in data {
                    
                    if item.genreIds![0] == genreId {
                        
                        sorted.append(item)
                        
                        //                    for genre in item.genreIds! {
                        //
                        //                        if genreId == genre {
                        //                            sorted.append(item)
                        //                        }
                        //
                        //                    }
                        
                    }
                    
                }
                data.removeAll()
                data = sorted
            }
            
            print("=======\(data)")
            
            
            let name = isMovie ? data[indexPath.row].title! : data[indexPath.row].name!
            let posterPath = data[indexPath.row].posterPath
            let id = data[indexPath.row].id!
            let date = isMovie ? data[indexPath.row].releaseDate : data[indexPath.row].firstAirDate
            let rank  = data[indexPath.row].popularity!/1000
            
            networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.configureCell(id: id,
                                   image: image,
                                   category: self.getGenre(indexPath),
                                   name: name,
                                   releaseDate: date!,
                                   rank: rank)
            }
            
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
            
            switch sectionIndex {
            case 0:
                return self.createPosterSection()
            case 1:
                return self.createCategorySection()
            case 2:
                return self.createExampleSection()
            default: return nil
            }
        }
    }
    
    //Poster Section
    
    private func createPosterSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.55),
                                                                         heightDimension: .fractionalHeight(0.45)),
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
        
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100),
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(100),
                                                                         heightDimension: .fractionalHeight(0.06)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 20,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        
        section.contentInsets = .init(top: 5, leading: 30, bottom: 5, trailing: 10)
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
                                heightDimension: .estimated(40)),
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

import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 12 Pro Max")
            .previewDisplayName("iPhone 12 Pro Max")
        
        ContainterView().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE (3rd generation)")
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        let listVC = HomeViewController()
        func makeUIViewController(context:
                                  UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> HomeViewController {
            return listVC
        }
        
        func updateUIViewController(_ uiViewController:
                                    ListProvider.ContainterView.UIViewControllerType, context:
                                    UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
        }
    }
}
