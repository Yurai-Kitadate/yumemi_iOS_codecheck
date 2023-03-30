import XCTest
@testable import iOSEngineerCodeCheck

class ImageLoaderTests: XCTestCase {

    var imageLoader: ImageLoader!

    override func setUp() {
        super.setUp()
        imageLoader = ImageLoader()
    }

    override func tearDown() {
        imageLoader = nil
        super.tearDown()
    }

    func testLoadImage() async throws {
        let owner = Owner(avatar_url: "https://avatars.githubusercontent.com/u/31836049?v=4")
        
        await imageLoader.load(owner: owner)

        XCTAssertNotNil(imageLoader.image)
    }

}

class GitHubAPIClientTests: XCTestCase {

    var apiClient: GitHubAPIClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        apiClient = GitHubAPIClient()
    }

    override func tearDownWithError() throws {
        apiClient = nil
        try super.tearDownWithError()
    }

    func testLoad() async throws {
        let searchBarWord = "swift"
        await apiClient.load(searchBarWord: searchBarWord)

        XCTAssertNotNil(apiClient.repo)
    }

}
