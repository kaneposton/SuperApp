// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation
import Mapbox

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func writeFile(coordinate: [CLLocationCoordinate2D]) -> URL? {
    let url = getDocumentsDirectory().appendingPathComponent("ListCoordinates.geojson")
    let myString: String = containListCoordinates(coordinate: coordinate)
    do {
        try myString.write(to: url, atomically: true, encoding: .utf8)
        return url
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

func containListCoordinates(coordinate: [CLLocationCoordinate2D]) -> String {
    var contain = ""
    var count = 0
    let header = """
{
"type": "FeatureCollection",
"features": [
  {
    "type": "Feature",
    "properties": {
      "TYPE": "neighborhood-region"
    },
    "geometry": {
      "type": "Polygon",
      "coordinates": [
        [
"""
    var body = ""
    let footer = """
            ]
        ]
      }
    }
  ]
}
"""
    for item in coordinate {
        body += "[\(item.longitude), \(item.latitude)]"
        if count != coordinate.count - 1 {
            body += ","
        }
        count += 1
    }
    contain = header + body + footer
    return contain
}
