import Foundation

class EnkaCacheService {
    
    let session: URLSession
    let testText: String = "123123"
    
    init(session: URLSession) {
        self.session = session
    }
    
    private var cacheDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func setupCache() {
        if let cacheDirectory = cacheDirectory {
            let fileURL = cacheDirectory.appendingPathComponent("file.txt")
            
            do {
                try testText.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Error writing to cache")
                print(error)
            }
            
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print(text2)
            } catch {
                print("Error reading file")
                print(error)
            }
        }
    }
    
}
