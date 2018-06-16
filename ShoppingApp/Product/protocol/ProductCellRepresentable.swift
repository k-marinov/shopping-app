import Foundation

protocol ProductCellRepresentable: CollectionViewItem {

    var title: String { get }

    func imageUrl() -> URL?

    func priceNowFormatted() -> String

}
