import XCTest
@testable import iOSEngineerCodeCheck

class ImageViewModelTests: XCTestCase {
    
    var imageViewModel: ImageViewModel?
    
    override func setUp() {
        super.setUp()
        imageViewModel =  ImageViewModel()
    }
    
    override func tearDown() {
        imageViewModel = nil
        super.tearDown()
    }
    
    func testLoad() async throws {
        let owner = Owner(avatar_url: "https://avatars.githubusercontent.com/u/31836049?v=4")
        
        self.imageViewModel?.getImage(from: owner.avatar_url ?? "") { [weak self] image in
            DispatchQueue.main.async {
                XCTAssertNotNil(image)
            }
            
        }
    }
    
}

class RepositoriesViewModelTests: XCTestCase {
    
    var repositoriesViewModel : RepositoriesViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoriesViewModel = RepositoriesViewModel()
    }
    
    override func tearDownWithError() throws {
        repositoriesViewModel = nil
        try super.tearDownWithError()
    }
    
    func testLoad() async throws {
        let searchBarWord = "swift"
        await repositoriesViewModel?.load(searchBarWord: searchBarWord)
        sleep(3)
        XCTAssertNotNil(repositoriesViewModel?.repositories)
    }
    
}
