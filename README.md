# Shopping App

## Developer Prerequisites

### macOS High Sierra

10.13.4 (17E202)

### Xcode

Xcode Version  9.4.1 (9F2000)

### Swift

Apple Swift version 4.1.2 (swiftlang-902.0.54 clang-902.0.39.2)

### Deployment Target 

iOS 10.0

### Cocoapods

Pod Version 1.5.3


### Quick Start Guide 

```git clone https://github.com/k-marinov/shopping-app.git```

```cd shopping-app```

```pod install (In the shopping-app directory where the Podfile is located, Once pod install is completed, It will generate ShoppingApp.xcworkspace file)```

```open ShoppingApp.xcworkspace```

```CMD + R```


## TEST COVERAGE

89% of the classes are tested, including all the resources, services, view models and view controllers, some views are unit tested, There are also http stub tests by using OHTTPStubs library which also enable classes to be tested in integration. Below the service level api requests are tested with http stubbing. At View model level mock service responses are used.


## App Architecture

**MVVM** with Routers and layered service architecture. Dependency injection with Component creator for services and routers.

Main components of MVVM with Routers and Services architecture are

• Router - Navigation

• ViewController - Views

• ViewModel - Model for view controller/Views

• ComponentCreator - Dependency injection for view model, services, routers

• Service - Handle business logic, make api request, read write to disk

• Remote  - Makes api request, convert response into different types

• Dao  -  protocol or class for reading, writing from local storage (if needed)

• Request - api request that has the http request,response and resource 

• Response - it holds the success logic for the request

• Resource - equivalent dto of json object

## Libraries


**RxSwift / RxCocoa**

• Concurrency 

• Binding ui 

• Functional reactive programming style

• Allows easy testing capabilities 

• It enables developer to write more immutable style of coding


**Kingfisher** 

• Images


**Quick/Nimble**

• Bdd style testing framewrok

• It allows to write more expressive tests with  / less set up that would require using XCTest framework

• My purpose to include Quick and Nimble was just to demonstrate the difference between BDD style testing and XCUnit testing.

• StringUtilSpec and HttpSchemeProtocolSpec are the only classes that uses Quick and Nimble, rest of tests are implemented with XCTest


**SwiftyJSON**

• For json mapping

• SwiftyJSON is far more practical than Codable in some case, for complex nested json object SwiftyJSON seems to be the only viable option, however both SwiftyJSON and Codable Protocol can be used as well.

**OHTTPStubs**

• For stubbing your network requests

• It enables complex scenarios to be tested in isolation.

• Useful for testing your service layer.

# Screenshots
 Test Coverage 89.56% 

 <img src="https://raw.githubusercontent.com/k-marinov/shopping-app/master/shopping-app-test-coverage.png" width="720">

 Products Page 

 <img src="https://raw.githubusercontent.com/k-marinov/shopping-app/master/screen-1.png" width="720">

 Product Detail Page 

 <img src="https://raw.githubusercontent.com/k-marinov/shopping-app/master/screen-2.png" width="720">



