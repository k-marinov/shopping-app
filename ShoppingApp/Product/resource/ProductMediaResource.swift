import SwiftyJSON

struct ProductMediaResource: Resource, HttpSchemeBuilder {

    private(set) var imageUrls: [String] = [String]()

    init(json: JSON) {
        mapImageUrls(from: json)
    }

    private mutating func mapImageUrls(from json: JSON) {
        let newImageUrls: [String] = json["images"]["urls"].arrayValue
            .compactMap { addHttpScheme(to: $0.stringValue ) }
        imageUrls.append(contentsOf: newImageUrls)
    }

}
