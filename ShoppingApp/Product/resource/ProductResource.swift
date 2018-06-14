import SwiftyJSON

struct ProductResource: Resource {

    private(set) var id: Int
    private(set) var title: String
    private(set) var imageUrl: String = ""

    init(json: JSON) {
        id = json["productId"].intValue
        title = json["title"].stringValue
        imageUrl = addSchemeToImageUrlIfRequired(to: json["image"].stringValue)
    }

    private mutating func addSchemeToImageUrlIfRequired(to image: String) -> String {
        if image.hasPrefix("https:") || image.hasPrefix("http:") {
            return image
        }
        return "https:" + image
    }

}
