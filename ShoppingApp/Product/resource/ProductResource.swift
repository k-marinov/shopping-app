import SwiftyJSON

struct ProductResource: Resource, HttpSchemeBuilder {

    private(set) var id: Int
    private(set) var title: String
    private(set) var imageUrl: String?
    private(set) var displaySpecialOffer: String
    private(set) var code: String
    private let priceResource: PriceResource

    init(json: JSON) {
        id = json["productId"].intValue
        title = json["title"].stringValue
        priceResource = PriceResource(json: json["price"])
        displaySpecialOffer = json["displaySpecialOffer"].stringValue
        code = json["code"].stringValue
        imageUrl = addHttpScheme(to: json["image"].stringValue)
    }

    func priceNowFormatted() -> String {
        return priceResource.priceNowFormatted()
    }

}
