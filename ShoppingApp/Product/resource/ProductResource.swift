import SwiftyJSON

struct ProductResource: Resource {

    private(set) var id: Int
    private(set) var title: String
    private(set) var imageUrl: String = ""
    private let priceResource: PriceResource

    init(json: JSON) {
        id = json["productId"].intValue
        title = json["title"].stringValue
        priceResource = PriceResource(json: json["price"])
        imageUrl = addSchemeToImageUrlIfRequired(to: json["image"].stringValue)
    }

    func priceNowFormatted() -> String {
        return priceResource.priceNowFormatted()
    }

    private mutating func addSchemeToImageUrlIfRequired(to image: String) -> String {
        if StringUtil.isNilOrEmpty(image) {
            return ""
        }

        if image.hasPrefix("https:") || image.hasPrefix("http:") {
            return image
        }

        return "https:" + image
    }

}
