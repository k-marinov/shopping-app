import SwiftyJSON

@testable import ShoppingApp

class FileHelper {

    func createData(fromFilename filename: String, ofType: String) -> Data? {
        do {
            let bundle: Bundle = Bundle(for: type(of: self))
            if let url: URL = bundle.url(forResource: filename, withExtension: ofType) {
                return try Data(contentsOf: url, options: NSData.ReadingOptions.init(rawValue: 0))
            }
        } catch {
        }
        return nil
    }

    func createJson(fromFilename filename: String) -> JSON {
        return try! JSON(data: createData(fromFilename: filename, ofType: "json")!)
    }

}
