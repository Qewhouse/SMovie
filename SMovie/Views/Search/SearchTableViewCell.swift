
import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
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
    
    public func configure(with image: UIImage, name: String?, time: String?) {
        customTableViewCell.customImageView.image = image
        customTableViewCell.nameLabel.text = name
        customTableViewCell.timeLabel.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
