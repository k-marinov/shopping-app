import SwiftyJSON

struct ProductResource: Resource {

    private(set) var id: Int

    init(json: JSON) {
        id = json["productId"].intValue
    }

}
