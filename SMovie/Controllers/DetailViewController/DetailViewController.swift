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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 45)
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        collectionView.register(CastAndCrewCell.self, forCellWithReuseIdentifier: String(describing: CastAndCrewCell.self))
        
        layout.scrollDirection = .horizontal
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addSubviews()
        addViewConstraints()
        setupNavigationBar()
    }
    
    @objc private func addTappedLeftNavButton() {
        print("Back")
    }
    
    @objc private func addTappedFavorite() {
        print("Favourite")
    }
    
    @objc private func didTapWatchButton() {
        print("Watch now")
    }
    
    private func setupViews() {
        aboutStack.distribution = .fillEqually
        aboutStack.spacing = 24
        
        ratingStack.spacing = 6
        
        applyStyleLabel(
            releaseDateLabel,
            text: "17 Sep 2021",
            image: "calendar"
        )
        
        applyStyleLabel(
            timeLabel,
            text: "148 Minutes",
            image: "clock"
        )
        
        applyStyleLabel(
            genreLabel,
            text: "Action",
            image: "film"
        )
        
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Arrow Back"), style: .plain, target: self, action: #selector(addTappedLeftNavButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Favorite"), style: .done, target: self, action: #selector(addTappedFavorite))
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastAndCrewCell.self), for: indexPath) as? CastAndCrewCell else { fatalError("error")}
        
        let image = images[indexPath.row]
        let name = names[indexPath.row]
        let vocabulary = vocabularys[indexPath.row]
        myCell.setupCell(withImage: UIImage(named: image) ?? UIImage(), name: name, vocabulary: vocabulary)
        return myCell
    }
}

