import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductMediaMother {

    private static let media: String =
    """
    { "images": { "urls": [
        "//johnlewis.scene7.com/is/image/JohnLewis/236888507?",
        "//johnlewis.scene7.com/is/image/JohnLewis/236888507alt1?",
        "//johnlewis.scene7.com/is/image/JohnLewis/236888507alt10?",
        "//johnlewis.scene7.com/is/image/JohnLewis/236888507alt2?"
        ] }
    }
    """

    class func mediaJson() -> JSON {
        let data: Data = media.data(using: .utf8)!
        return JSON(data)
    }

    class func expectedImageUrls() -> [String] {
        return ["https://johnlewis.scene7.com/is/image/JohnLewis/236888507?",
                "https://johnlewis.scene7.com/is/image/JohnLewis/236888507alt1?",
                "https://johnlewis.scene7.com/is/image/JohnLewis/236888507alt10?",
                "https://johnlewis.scene7.com/is/image/JohnLewis/236888507alt2?"]
    }

}
