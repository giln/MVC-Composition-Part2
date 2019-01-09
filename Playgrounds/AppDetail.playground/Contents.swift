import PlaygroundSupport
import UIKit

@testable import AppStoreFramework


public class MockFetcher: DataFetching {
    public func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        print("toto")
        completion(nil,nil)
    }
}

let ressource = AppStoreRessource()

ressource.dataFetcher = MockFetcher()

ressource.getApps(top: 10, appType: .free) { (apps, error) in
    print(apps)
}
