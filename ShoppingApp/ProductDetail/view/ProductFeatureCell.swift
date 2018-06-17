import UIKit

class ProductFeatureCell: UITableViewCell, TableViewCell {

    static var identifier: String = "\(ProductFeatureCell.self)"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with tableViewItem: TableViewItem) {
        let feature = tableViewItem as! ProductFeatureResource
        resetContent()
        nameLabel.text = feature.attributeName
        valueLabel.text = feature.attributeValue
    }

    private func resetContent() {
        nameLabel.text = nil
        valueLabel.text = nil
    }

}
