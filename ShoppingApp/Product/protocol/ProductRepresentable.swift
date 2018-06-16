import Foundation

protocol ProductCellRepresentable {

    var title: String { get }

    func imageUrl() -> URL?

    func priceNowFormatted() -> String

}
