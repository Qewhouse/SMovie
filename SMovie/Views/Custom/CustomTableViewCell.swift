
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
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drifting Home"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = Theme.reversedAppColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.tintColor = Theme.grayColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "148 minutes"
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
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(heartTapped))
        heartImageView.addGestureRecognizer(tapGesture)
        
        addSubviews(customImageView, nameLabel, alarmImageView, timeLabel, dateLabel, dateImageView, movieImageView, movieAction, heartImageView)
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
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.topAnchor.constraint(equalTo: alarmImageView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: alarmImageView.trailingAnchor, constant: 3),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: alarmImageView.bottomAnchor),
            
            alarmImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            alarmImageView.heightAnchor.constraint(equalToConstant: 25),
            alarmImageView.widthAnchor.constraint(equalToConstant: 25),
            alarmImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            dateLabel.topAnchor.constraint(equalTo: dateImageView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: 3),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateImageView.bottomAnchor),
            
            dateImageView.topAnchor.constraint(equalTo: alarmImageView.bottomAnchor, constant: 2),
            dateImageView.heightAnchor.constraint(equalToConstant: 25),
            dateImageView.widthAnchor.constraint(equalToConstant: 25),
            dateImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            movieAction.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieAction.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 3),
            movieAction.widthAnchor.constraint(equalToConstant: 80),
            movieAction.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: dateImageView.bottomAnchor, constant: 2),
            movieImageView.heightAnchor.constraint(equalToConstant: 25),
            movieImageView.widthAnchor.constraint(equalToConstant: 25),
            movieImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            heartImageView.topAnchor.constraint(equalTo: customImageView.topAnchor),
            heartImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            heartImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
