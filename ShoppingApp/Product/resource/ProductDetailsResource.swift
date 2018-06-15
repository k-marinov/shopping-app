import SwiftyJSON

struct ProductDetailsResource: Resource {

    private(set) var information: String

    init(json: JSON) {
        information = json["productInformation"].stringValue
    }

}
