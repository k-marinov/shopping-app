import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell, CollectionViewCell {

    static var identifier: String = "\(ImageCell.self)"

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(with collectionViewItem: CollectionViewItem) {
        let imageUrl = collectionViewItem as! String
        resetContent()

        _ = URL(string: imageUrl).map { imageUrl in
                imageView.kf.setImage(with: imageUrl)
        }
    }

    private func resetContent() {
        imageView.image = nil
    }

}
