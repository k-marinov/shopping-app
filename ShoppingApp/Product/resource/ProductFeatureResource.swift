import SwiftyJSON

struct ProductFeatureResource: Resource, TableViewItem {

    private(set) var attributeName: String
    private(set) var attributeValue: String

    init(json: JSON) {
        attributeName = json["name"].stringValue
        attributeValue = json["value"].stringValue
    }

}
