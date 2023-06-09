
import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    let customTableViewCell = CustomTableViewCell()
   
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
    
    public func configure(with image: UIImage, name: String?, minutes: Int, date: String?) {
        customTableViewCell.customImageView.image = image
        customTableViewCell.nameLabel.text = name
        customTableViewCell.minutesLabel.text = "\(minutes) Minutes"
        customTableViewCell.dateLabel.text = date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
