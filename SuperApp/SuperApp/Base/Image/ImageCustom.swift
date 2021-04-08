// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ImageCustom: View {
    var name = ""
    var w: CGFloat = 50
    var h: CGFloat = 50

    var body: some View {
        Image(name)
            .resizable()
            .frame(width: W(w), height: W(h))
    }
}
