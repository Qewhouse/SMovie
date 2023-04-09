
import UIKit

final class PlayTableViewCell: UITableViewCell {
    
    static let identifier = "PlayTableViewCell"
    private let customTableViewCell = CustomTableViewCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(customTableViewCell)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            customTableViewCell.topAnchor.constraint(equalTo: topAnchor),
            customTableViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTableViewCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            customTableViewCell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func configure(with imageName: String, name: String, time: String) {
        customTableViewCell.customImageView.image = UIImage(named: imageName)
        customTableViewCell.nameLabel.text = name
        customTableViewCell.timeLabel.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
