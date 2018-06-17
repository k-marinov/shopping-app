import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell, CollectionViewCell {

    static var identifier: String = "\(ProductCell.self)"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellBorderStyle()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(with collectionViewItem: CollectionViewItem) {
        let representable = collectionViewItem as! ProductCellRepresentable
        resetContent()

        titleLabel.text = representable.title
        priceLabel.text = representable.priceNowFormatted()
        _ = representable.imageUrl()
            .map { imageUrl in
                imageView.kf.setImage(with: imageUrl)
        }
    }

    private func setUpCellBorderStyle() {
        contentView.layer.borderColor = Color.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
    }

    private func resetContent() {
        titleLabel.text = nil
        priceLabel.text = nil
        imageView.image = nil
    }

}
