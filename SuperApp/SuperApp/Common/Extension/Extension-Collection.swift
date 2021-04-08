// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
    #if swift(>=4.1)
    #else
      func compactMap<ElementOfResult>(
        _ transform: (Element) throws -> ElementOfResult?
      ) rethrows -> [ElementOfResult] {
        return try flatMap(transform)
      }
    #endif
}
