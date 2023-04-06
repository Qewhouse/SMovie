
import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let nameLabel = UILabel(text: "Testttt", font: .systemFont(ofSize: 30))
    
    private let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "timer")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let timeLabel = UILabel(text: "148 minutes", font: .systemFont(ofSize: 20))
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar.badge.clock")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let dateLabel = UILabel(text: "Sep. 17 2022", font: .systemFont(ofSize: 20))
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet.clipboard")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieAction: UIButton = {
        let button = UIButton()
        button.setTitle("Action", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(customImageView, nameLabel, alarmImageView, timeLabel, dateLabel, dateImageView, movieImageView, movieAction, heartImageView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            customImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
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
            alarmImageView.heightAnchor.constraint(equalToConstant: 30),
            alarmImageView.widthAnchor.constraint(equalToConstant: 30),
            alarmImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            dateLabel.topAnchor.constraint(equalTo: dateImageView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: 3),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateImageView.bottomAnchor),
            
            dateImageView.topAnchor.constraint(equalTo: alarmImageView.bottomAnchor, constant: 2),
            dateImageView.heightAnchor.constraint(equalToConstant: 30),
            dateImageView.widthAnchor.constraint(equalToConstant: 30),
            dateImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            movieAction.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            movieAction.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 3),
            movieAction.widthAnchor.constraint(equalToConstant: 80),
            movieAction.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: dateImageView.bottomAnchor, constant: 2),
            movieImageView.heightAnchor.constraint(equalToConstant: 30),
            movieImageView.widthAnchor.constraint(equalToConstant: 30),
            movieImageView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 7),
            
            heartImageView.topAnchor.constraint(equalTo: customImageView.topAnchor),
            heartImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            heartImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageName: String, name: String, time: String) {
        customImageView.image = UIImage(named: imageName)
        nameLabel.text = name
        timeLabel.text = time
    }
}
