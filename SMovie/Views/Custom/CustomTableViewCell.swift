
import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func didTappedHeartButton(index indexPath: IndexPath)
}

final class CustomTableViewCell: UIView {
    
    public var index: IndexPath?
    public weak var delegate: CustomTableViewCellDelegate?
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Movie-grad-blur")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drifting Home"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = Theme.reversedAppColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.tintColor = Theme.grayColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "10.0"
        label.font = .systemFont(ofSize: 18)
        label.textColor = Theme.lightGrayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.tintColor = Theme.grayColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "17 Sep 2021"
        label.font = .systemFont(ofSize: 18)
        label.textColor = Theme.lightGrayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "film")
        imageView.tintColor = Theme.grayColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieAction: UIButton = {
        let button = UIButton()
        button.setTitle("Action", for: .normal)
        button.backgroundColor = Theme.violetColor
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Favorite")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = .label
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Theme.appColor
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(heartTapped))
        heartImageView.addGestureRecognizer(tapGesture)
        
        addSubviews(customImageView,
                    nameLabel,
                    clockImageView,
                    rankLabel,
                    dateLabel,
                    dateImageView,
                    movieImageView,
                    movieAction,
                    heartImageView)
        addConstraints()
    }
    
    @objc
    private func heartTapped(_ sender: UITapGestureRecognizer) {
        guard let index = index else { return }
        delegate?.didTappedHeartButton(index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTableViewCell {
    private func addConstraints() {
        NSLayoutConstraint.activate([
            customImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            customImageView.heightAnchor.constraint(equalToConstant: 160),
            customImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: customImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: heartImageView.leadingAnchor, constant: -10),
//            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            rankLabel.topAnchor.constraint(equalTo: clockImageView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 3),
            rankLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rankLabel.bottomAnchor.constraint(equalTo: clockImageView.bottomAnchor),
            
            clockImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            clockImageView.heightAnchor.constraint(equalToConstant: 20),
            clockImageView.widthAnchor.constraint(equalToConstant: 20),
            clockImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: dateImageView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: 3),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateImageView.bottomAnchor),
            
            dateImageView.topAnchor.constraint(equalTo: clockImageView.bottomAnchor, constant: 10),
            dateImageView.heightAnchor.constraint(equalToConstant: 20),
            dateImageView.widthAnchor.constraint(equalToConstant: 20),
            dateImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            
            movieAction.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieAction.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 3),
            movieAction.widthAnchor.constraint(equalToConstant: 80),
            movieAction.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: dateImageView.bottomAnchor, constant: 10),
            movieImageView.heightAnchor.constraint(equalToConstant: 20),
            movieImageView.widthAnchor.constraint(equalToConstant: 20),
            movieImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            
            heartImageView.topAnchor.constraint(equalTo: topAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            heartImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
