// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import UIKit

// MARK: - Extension UIImage
extension UIImage {
    /*
     * Description: Resize image
     */
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    /*
     * Description: Resize image by Height
     */
    func resizeImage(newHeight: CGFloat) -> UIImage {

        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    /*
     * Description: Normalize image
     */
    func normalizeImage() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        else {
            UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
            self.draw(in: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: self.size))
            var normalizeImage = self
            if UIGraphicsGetImageFromCurrentImageContext() != nil {
                normalizeImage = UIGraphicsGetImageFromCurrentImageContext()!
            }
            UIGraphicsEndImageContext()
            return normalizeImage
        }
    }

    /*
     * Description: Scale image to under 1MB
     */
    func scaleImage() -> UIImage {
        let sizeScale = (1 * 1024 * 1024)
        var imageData: Data? = self.pngData()
        var scaleImage: UIImage = self
        var adjustment: CGFloat = 0.9

        // Check and resize data image
        if imageData != nil {
            while (imageData!.count > sizeScale) {
                NSLog("While start - The imagedata size is currently: %f KB", roundf(Float(imageData!.count / 1024)));

                // Update adjustment
                adjustment = CGFloat(sizeScale) / CGFloat(imageData!.count)
                if adjustment < 0.5 { adjustment = 0.5 }
                if adjustment > 0.95 { adjustment = 0.95 }

                // While the imageData is too large scale down the image

                // Resize the image
                let newSize = CGSize(width: scaleImage.size.width * adjustment, height: scaleImage.size.height * adjustment)
                let rect = CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                scaleImage.draw(in: rect)
                if UIGraphicsGetImageFromCurrentImageContext() != nil {
                    scaleImage = UIGraphicsGetImageFromCurrentImageContext()!
                }
                UIGraphicsEndImageContext()

                // Pass the NSData out again
                imageData = scaleImage.pngData()
                if imageData == nil { break }
            }
        }

        return scaleImage
    }

    // MARK: - Run Gif

    /*
     * Description: Gif Image With Data
     */
    public class func gifImageWithData(data: NSData) -> UIImage? {
        var imageReturn: UIImage? = nil
        if let source = CGImageSourceCreateWithData(data, nil) {
            imageReturn = UIImage.animatedImageWithSource(source: source)
        }
        return imageReturn
    }

    /*
     * Description: Gif Image With Name
     */
    public class func gifImageWithName(name: String) -> UIImage? {
        var imageReturn: UIImage? = nil
        if let bundleURL: URL = Bundle.main.url(forResource: name, withExtension: "gif") {
            if let imageData: NSData = NSData(contentsOf: bundleURL) {
                imageReturn = UIImage.gifImageWithData(data: imageData)
            }
        }
        return imageReturn
    }

    // MARK: -

    /*
     * Created by: cuongkt
     * Description: delayForImageAtIndex
     */
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.001

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)

        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)

        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        delay = delayObject as! Double

        if delay < 0.001 {
            delay = 0.001
        }

        return delay
    }

    /*
     * Created by: cuongkt
     * Description: gcdForPair
     */
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }

        if a! < b! {
            let c = a!
            a = b!
            b = c
        }

        var rest: Int
        while true {
            rest = a! % b!

            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }

    /*
     * Created by: cuongkt
     * Description: gcdForArray
     */
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }

        return gcd
    }

    /*
     * Created by: cuongkt
     * Description: AnimatedImageWithSource
     */
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }

            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)

        return animation
    }
    func _resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func scaleImageForFrame(image: UIImage?) -> UIImage {
        let float: CGFloat = 1024
        let imgWidth: CGFloat = (image?.size.width) ?? 0.0
        let imgHeight: CGFloat = (image?.size.height) ?? 0.0
        if (imgWidth) < float || (imgHeight) < float {
            return image!
        } else {
            if imgWidth > imgHeight {
                let strWidth = "\(imgWidth)"
                let digitsWidth = strWidth.compactMap { Int(String($0)) }
                let firstIntWidth: Int = digitsWidth.first!

                let digitsFloatWidth: CGFloat = CGFloat(firstIntWidth)

                let imgWidth1: CGFloat = imgWidth / digitsFloatWidth
                let imgHeight2: CGFloat = imgHeight / digitsFloatWidth

                let newSize = CGSize(width: imgWidth1, height: imgHeight2)
                let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                self.draw(in: rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return newImage!
            } else {
                let strHeight = "\(imgHeight)"
                let digitsHeight = strHeight.compactMap { Int(String($0)) }
                let firstIntHeight: Int = digitsHeight.first!

                let digitsFloatHeight: CGFloat = CGFloat(firstIntHeight)

                let imgWidth1: CGFloat = imgWidth / digitsFloatHeight
                let imgHeight2: CGFloat = imgHeight / digitsFloatHeight

                let newSize = CGSize(width: imgWidth1, height: imgHeight2)
                let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                self.draw(in: rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return newImage!
            }

        }
    }
}
