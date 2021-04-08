// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

public extension Array where Element: Hashable {
  static func removeDuplicates(_ elements: [Element]) -> [Element] {
    var seen = Set<Element>()
    return elements.filter{ seen.insert($0).inserted }
  }
}

extension Array {
    func chunk(by predicate: @escaping (Iterator.Element, Iterator.Element) -> Bool) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j = index(after: i)
        while i != endIndex {
            j = self[j..<endIndex].firstIndex(where: { !predicate(self[i], $0) }) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
