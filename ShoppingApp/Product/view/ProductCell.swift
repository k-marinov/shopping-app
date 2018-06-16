import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with product: ProductCellRepresentable) {
        resetContent()
        titleLabel.text = product.title
        priceLabel.text = product.priceNowFormatted()
        _ = product.imageUrl()
            .map { imageUrl in
                imageView.kf.setImage(with: imageUrl)
        }
    }

    private func resetContent() {
        titleLabel.text = nil
        priceLabel.text = nil
        imageView.image = nil
    }

}
