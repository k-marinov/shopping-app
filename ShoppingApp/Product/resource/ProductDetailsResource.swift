import SwiftyJSON

struct ProductDetailsResource: Resource {

    private(set) var information: String
    private(set) var features: [ProductFeatureResource] = [ProductFeatureResource]()

    init(json: JSON) {
        information = json["productInformation"].stringValue
        mapFeatures(from: json)
    }

    private mutating func mapFeatures(from json: JSON) {
        let first: JSON? = json["features"].arrayValue.first
        let jsonObjecs: [JSON] = (first?["attributes"].arrayValue ?? [JSON]())
        let newFeatures: [ProductFeatureResource] = jsonObjecs.compactMap {ProductFeatureResource(json: $0) }
        features.append(contentsOf: newFeatures)
    }

}
