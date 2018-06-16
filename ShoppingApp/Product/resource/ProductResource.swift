import SwiftyJSON

struct ProductResource: Resource, HttpSchemeBuilder {

    private(set) var id: Int
    private(set) var title: String
    private(set) var imageUrl: String?
    private(set) var displaySpecialOffer: String
    private(set) var code: String
    private let price: PriceResource
    private let details: ProductDetailsResource
    private let additionalServices: ProductAdditionalServicesResource
    private let media: ProductMediaResource

    init(json: JSON) {
        id = json["productId"].intValue
        title = json["title"].stringValue
        displaySpecialOffer = json["displaySpecialOffer"].stringValue
        code = json["code"].stringValue
        price = PriceResource(json: json["price"])
        details = ProductDetailsResource(json: json["details"])
        additionalServices = ProductAdditionalServicesResource(json: json["additionalServices"])
        media = ProductMediaResource(json: json["media"])
        imageUrl = addHttpScheme(to: json["image"].stringValue)
    }

    func priceNowFormatted() -> String {
        return price.priceNowFormatted()
    }

    func information() -> String {
        return details.information
    }

    func includedServicesFormatted() -> String {
        return additionalServices.includedServicesFormatted()
    }

    func features() -> [ProductFeatureResource] {
        return details.features
    }

    func imageUrls() -> [String] {
        return media.imageUrls
    }

}
