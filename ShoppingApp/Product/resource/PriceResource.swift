import SwiftyJSON

struct PriceResource: Resource {

    private var now: String

    init(json: JSON) {
        now = json["now"].stringValue
    }

    func priceNowFormatted() -> String {
        if StringUtil.isNilOrEmpty(now) {
            return ""
        }
        return "£\(now)"
    }

}
