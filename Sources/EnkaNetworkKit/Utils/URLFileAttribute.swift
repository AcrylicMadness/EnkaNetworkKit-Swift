import Foundation

// MARK: - URLFileAttribute
struct URLFileAttribute {
   private(set) var fileSize: UInt? = nil
   private(set) var creationDate: Date? = nil
   private(set) var modificationDate: Date? = nil

   init(url: URL) {
       let path = url.path
       guard let dictionary: [FileAttributeKey: Any] = try? FileManager.default
               .attributesOfItem(atPath: path) else {
           return
       }

       if dictionary.keys.contains(FileAttributeKey.size),
           let value = dictionary[FileAttributeKey.size] as? UInt {
           print("UInt size is \(value)")
           self.fileSize = value
       }

       if dictionary.keys.contains(FileAttributeKey.creationDate),
           let value = dictionary[FileAttributeKey.creationDate] as? Date {
           self.creationDate = value
       }

       if dictionary.keys.contains(FileAttributeKey.modificationDate),
           let value = dictionary[FileAttributeKey.modificationDate] as? Date {
           self.modificationDate = value
       }
   }
}
