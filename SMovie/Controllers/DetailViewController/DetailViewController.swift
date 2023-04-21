//
//  DetailViewController.swift
//  SMovie
//
//  Created by Eduard Tokarev on 06.04.2023.
//

//let detailViewController = DetailViewController()
//let navigationDetailViewController = UINavigationController(rootViewController: detailViewController)
//navigationDetailViewController.modalPresentationStyle = .fullScreen
//present(navigationDetailViewController, animated: true)

import UIKit

final class DetailViewController: UIViewController {
    let rating = 4
    
    let images = ["luck", "luck", "luck"]
    let names = ["Jon Watts", "Chris McKenna", "Some Text"]
    let vocabularys = ["Directors", "Writers", "Actor"]
    
    private let networkService = NetworkService.shared
    private let idMedia: Int
    private let mediaType: MediaType
    private var credits = [Cast]()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "luck")
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let labelMovie: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Luck"
        return label
    }()
    
    private let aboutStack = UIStackView()
    private let releaseDateLabel = UILabel()
    private let timeLabel = UILabel()
    private let genreLabel = UILabel()
    
    private let ratingStack = UIStackView()
    private var stars = [UIImageView]()
    private let numberOfStars = 5
    
    private let storyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Story Line"
        return label
    }()
    
    private let storyLineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = Theme.grayColor
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
        return label
    }()
    
    private let castAndCrewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Cast and Crew"
        return label
    }()
    
    lazy var castAndCrewViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 45)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        collectionView.register(CastAndCrewCell.self, forCellWithReuseIdentifier: String(describing: CastAndCrewCell.self))
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var watchNowButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapWatchButton), for: .touchUpInside)
        button.layer.cornerRadius = 24
        button.setTitle("Watch now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(Theme.appColor, for: .normal)
        button.backgroundColor = Theme.violetColor
        return button
    }()
    
    init(id: Int, mediaType: MediaType) {
        self.idMedia = id.self
        self.mediaType = mediaType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        setupViews()
        addSubviews()
        addViewConstraints()
        setupNavigationBar()
        fetchCredits()
    }
    
    @objc private func addTappedLeftNavButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addTappedFavorite() {
        print("Favourite")
    }
    
    @objc private func didTapWatchButton() {
        print("Watch now")
    }
    
    private func setupViews() {
        self.view.backgroundColor = Theme.appColor
        
        aboutStack.distribution = .fillEqually
        aboutStack.spacing = 24
        
        ratingStack.spacing = 6
        
        styleForLabel()
        
        for _ in 0 ..< rating {
            let star = UIImageView()
            star.image = UIImage(named: "star")
            stars.append(star)
        }
        
        for _ in 0 ..< numberOfStars - rating {
            let star = UIImageView()
            star.image = UIImage(named: "star_grey")
            stars.append(star)
        }
    }
    
    private func styleForLabel(
        releaseDate: String = "17 Sep 2021",
        timeInt: Int = 148,
        genreText: String = "Action"
    ) {
        applyStyleLabel(
            releaseDateLabel,
            text: releaseDate,
            image: "calendar"
        )
        
        applyStyleLabel(
            timeLabel,
            text: "\(timeInt) Minutes",
            image: "clock"
        )
        
        applyStyleLabel(
            genreLabel,
            text: genreText,
            image: "film"
        )
    }
    
    private func applyStyleLabel(
        _ label: UILabel,
        text: String = "",
        image: String = "",
        font: UIFont? = .systemFont(ofSize: 12, weight: .bold),
        textColor: UIColor = Theme.grayColor,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1
    ) {
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: image)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        completeText.append(NSAttributedString(string: " "))
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        label.attributedText = completeText
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Movie Detail"
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Arrow Back"), style: .plain, target: self, action: #selector(addTappedLeftNavButton))
        
        let backButtonImage = UIImage(named: "backArrow")
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(addTappedLeftNavButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorite"), style: .done, target: self, action: #selector(addTappedFavorite))
    }
    
    private func createViews() {
        networkService.fetchDetail(id: idMedia, mediaType: mediaType) { data in
            var name = ""
            var date = ""
            var minutes = 0
            
            if let title = data?.name {
                name = title
            } else if let title = data?.title {
                name = title
            }
            
            if let time = data?.firstAirDate {
                date = time
            } else if let time = data?.releaseDate {
                date = time
            }
            
            if let minute = data?.runtime {
                minutes = minute
            } else if let minute = data?.episodeRunTime {
                var sum = minute.reduce(0, +)
                minutes = sum
            }

            self.labelMovie.text = name
            self.releaseDateLabel.text = date
            let genreText = data?.genres?[0].name
            self.styleForLabel(releaseDate: date, timeInt: minutes, genreText: genreText ?? "")
            
            let posterPath = data?.posterPath
            let id = data?.id
            self.networkService.fetchImage(posterPath, id: id) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                self.imageView.image = image
            }
        }
    }
    
    private func addSubviews() {
        [imageView, labelMovie, aboutStack, ratingStack, storyLabel, storyLineLabel, castAndCrewLabel, castAndCrewViews, watchNowButton].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
        }
        
        [releaseDateLabel, timeLabel, genreLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            aboutStack.addArrangedSubview(item)
        }
        
        stars.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            ratingStack.addArrangedSubview(item)
        }
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -75),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            labelMovie.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            labelMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aboutStack.topAnchor.constraint(equalTo: labelMovie.bottomAnchor, constant: 16),
            aboutStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42),
            aboutStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -41),
            aboutStack.heightAnchor.constraint(equalToConstant: 17),
            
            ratingStack.topAnchor.constraint(equalTo: aboutStack.bottomAnchor, constant: 16),
            ratingStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            storyLabel.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 32),
            storyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            storyLineLabel.topAnchor.constraint(equalTo: storyLabel.bottomAnchor, constant: 16),
            storyLineLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            storyLineLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            storyLineLabel.bottomAnchor.constraint(equalTo: castAndCrewLabel.topAnchor, constant: -24),
            
            castAndCrewLabel.bottomAnchor.constraint(equalTo: castAndCrewViews.topAnchor, constant: -24),
            castAndCrewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            castAndCrewViews.bottomAnchor.constraint(equalTo: watchNowButton.topAnchor, constant: -23),
            castAndCrewViews.heightAnchor.constraint(equalToConstant: 45),
            castAndCrewViews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            castAndCrewViews.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            watchNowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -22),
            watchNowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            watchNowButton.heightAnchor.constraint(equalToConstant: 56),
            watchNowButton.widthAnchor.constraint(equalToConstant: 181)
        ])
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(credits.count)
        return credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastAndCrewCell.self), for: indexPath)
        
        guard let myCell = cell as? CastAndCrewCell else { return UICollectionViewCell() }
        
        configCellCollectionView(for: myCell, with: indexPath)
        return myCell
    }
    
    private func configCellCollectionView(for cell: CastAndCrewCell, with indexPath: IndexPath) {
        let profilePath = self.credits[indexPath.row].profilePath
        let id = self.credits[indexPath.row].id
        let name = self.credits[indexPath.row].name
        var jobs = ""

        if let job = self.credits[indexPath.row].character {
            jobs = job
        } else if let job = self.credits[indexPath.row].job {
            jobs = job
        }
        
        networkService.fetchImage(profilePath, id: id) { [weak self] (image) in
            guard let self = self, let image = image else { return }
            cell.setupCell(withImage: image, name: name, vocabulary: jobs)
        }
    }
    
    private func fetchCredits() {
        networkService.fetchCredits(id: idMedia, mediaType: mediaType) { [weak self] credits in
            guard let self = self else { return }
            self.credits = credits.cast + credits.cast
            self.castAndCrewViews.reloadData()
        }
        
    }
}
