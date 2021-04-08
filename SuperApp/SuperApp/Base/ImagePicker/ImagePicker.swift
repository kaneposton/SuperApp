// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isVisible: Bool
    @Binding var image: Image?
    @Binding var uiImg: UIImage?
    var sourceType: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(isVisible: $isVisible, image: $image, uiImg: $uiImg)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = sourceType == 1 ? .photoLibrary : .camera
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isVisible: Bool
        @Binding var image: Image?
        @Binding var uiImg: UIImage?

        init(isVisible: Binding<Bool>, image: Binding<Image?>, uiImg: Binding<UIImage?>) {
            _isVisible = isVisible
            _image = image
            _uiImg = uiImg
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let uiimage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            image = Image(uiImage: uiimage)
            print(image as Any)
            isVisible = false
            uiImg = uiimage
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isVisible = false
        }
    }
}
