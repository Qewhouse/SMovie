//
//  HomeViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//
protocol GoToSeeAllProtocol {
    
   func goToSeeAll ()
}



import UIKit

final class HomeViewController: UIViewController {
    
    var mockData = HomeMockData.shared
    
    var networkService = NetworkService.shared
    
    var genres = [Genre]()
    
    var media = [Media]()
    
    var localMedia = [Media]()
    
    
    private let categoriesArray : [(name:String, id: Int?)] = [("All", nil),
                                                               ("TV-series", nil),
                                                               ("Action", 28),
                                                               ("Horror",27),
                                                               ("Drama",18) ,
                                                               ("Thriller", 53) ,
                                                               ("Others", nil) ]
    
    let homeView: HomeView = {
        let view = HomeView()
        view.collectionView.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sections = HomeMockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        media = networkService.media
        genres = networkService.genre
        localMedia = media
        
        setupViews()
        setDelegates()
        setConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "appColor")
        view.addSubview(homeView)
        homeView.collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: ExampleCell.identifier)
        homeView.collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.identifier)
        homeView.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        homeView.collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.identifier)
        homeView.collectionView.register(HeaderSeeAllView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeeAllView.identifier)

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
        
        switch indexPath.section {
        case 0 :
            print ("poster at \(indexPath.item) place")
            print (media[indexPath.item].id!)
            
            let detailVC: DetailViewController = DetailViewController(id: media[indexPath.item].id!,
                                                                      mediaType: media[indexPath.item].mediaType!)
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        case 1 : print ("category at \(indexPath) place - \(categoriesArray[indexPath.row])")
            
            switch categoriesArray[indexPath.row].name {
                
            case categoriesArray[0].name:

                localMedia = media
                
                reloadCollection(collectionView, indexPath)
                
            case categoriesArray[1].name:

                localMedia = media.filter { $0.mediaType == .tv }
                
                reloadCollection(collectionView, indexPath)
                
            case categoriesArray[2].name:
                
                filterMedia(id: categoriesArray[2].id!, collection: collectionView, indexPath: indexPath)
                
            case categoriesArray[3].name:
                
                filterMedia(id: categoriesArray[3].id!, collection: collectionView, indexPath: indexPath)
                
            case categoriesArray[4].name:
                
                filterMedia(id: categoriesArray[4].id!, collection: collectionView, indexPath: indexPath)
                
                
            case categoriesArray[5].name:
                
                filterMedia(id: categoriesArray[5].id!, collection: collectionView, indexPath: indexPath)
                
            case categoriesArray[6].name:
                print ("others")
                
            default: break
                
            }
            
        case 2 :
            print ("example at \(indexPath.item) place")
            print(localMedia[indexPath.item].id!)
            
            let vc = DetailViewController(id: localMedia[indexPath.row].id!,
                                          mediaType: localMedia[indexPath.row].mediaType!)
            navigationController?.pushViewController(vc, animated: true)
            
        default: break
            
        }
    }
    
    func filterMedia (id: Int, collection : UICollectionView, indexPath: IndexPath) {
        
        localMedia = media.filter { $0.genreIds?.first == id && $0.mediaType == .movie }
        reloadCollection(collection, indexPath)
        
    }
    
    func reloadCollection (_ collection: UICollectionView, _ indexPath: IndexPath) {
        
        homeView.collectionView.reloadData()
        collection.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    func getGenre(_ indexPath: IndexPath, data: [Media]) -> String {
        
        var name = String()
        for genre in genres {
            if data[indexPath.row].genreIds!.first == genre.id {
                name = genre.name
            }
        }
        return name
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
        case 2: return localMedia.count
        default: return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
            //posters
            
        case .posters(_):
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
                                   category: self.getGenre(indexPath, data: movies))
            }
            
            return cell
            
            //categories
            
        case .categories(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(categoryText: categoriesArray[indexPath.row].name)
            
            return cell
            
            //examples
            
        case .examples(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCell.identifier, for: indexPath) as? ExampleCell else {return UICollectionViewCell()}
            
            let name = localMedia[indexPath.row].mediaType == .movie ? localMedia[indexPath.row].title! : localMedia[indexPath.row].name!
            let posterPath = localMedia[indexPath.row].posterPath
            let id = localMedia[indexPath.row].id!
            let date = localMedia[indexPath.row].mediaType == .movie ? localMedia[indexPath.row].releaseDate : localMedia[indexPath.row].firstAirDate
            let rank  = localMedia[indexPath.row].popularity!/1000
            
            networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.configureCell(id: id,
                                   image: image,
                                   category: self.getGenre(indexPath, data: self.localMedia),
                                   name: name,
                                   releaseDate: date!,
                                   rank: rank)
            }
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        print(indexPath)
        
        
        switch indexPath.section {
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSupplementaryView.identifier,
                for: indexPath) as! HeaderSupplementaryView
    
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        case 2:
            
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderSeeAllView.identifier,
                for: indexPath) as! HeaderSeeAllView
    
            header.configureHeader(categoryName: sections[indexPath.section].title, delegate: self)
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

extension HomeViewController: GoToSeeAllProtocol {
    func goToSeeAll() {
        let seeAllVC : SeeAllViewController = SeeAllViewController()
        seeAllVC.configureSeeAll(with: localMedia)
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
}
