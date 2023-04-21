
import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = "FavoritesTableViewCell"
    private let customTableViewCell = CustomTableViewCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addConstraints()
    }
    
    private func addConstraints() {
        contentView.addSubview(customTableViewCell)
        NSLayoutConstraint.activate([
            customTableViewCell.topAnchor.constraint(equalTo: topAnchor),
            customTableViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTableViewCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            customTableViewCell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func configure(with imageName: Data, name: String, time: String) {
        customTableViewCell.customImageView.image = UIImage(data: imageName)
        customTableViewCell.nameLabel.text = name
        customTableViewCell.rankLabel.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
