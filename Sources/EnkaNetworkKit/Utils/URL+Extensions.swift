import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URL {
    func appending(paths: [String]) -> URL {
        var url = self
        for path in paths {
            url = url.appendingPathComponent(path)
        }
        return url
    }
    
    func appending(query: [URLQueryItem]) -> URL {
        var urlComps = URLComponents(string: absoluteString)!
        urlComps.queryItems = query
        let url = urlComps.url!
        return url
    }
    
    public func directoryContents() -> [URL] {
         do {
             let directoryContents = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
             return directoryContents
         } catch let error {
             print("Error: \(error)")
             return []
         }
     }

   public func folderSize() -> UInt {
         let contents = self.directoryContents()
         var totalSize: UInt = 0
         contents.forEach { url in
             let size = url.fileSize()
             totalSize += size
         }
         return totalSize
     }

     public func fileSize() -> UInt {
         let attributes = URLFileAttribute(url: self)
         return attributes.fileSize ?? 0
     }
}
