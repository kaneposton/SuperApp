// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

// MARK: POPUP MẪU, TỰ TẠO NHIỀU STRUCT DỰA THEO POPUP NÀY
struct BasePopup: View {
    @Binding var isShowPopup: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3817155394)))
                .onTapGesture {
                    self.isShowPopup = false
            }
            ZStack (alignment: .top) {
                Text("BODY")
            }.frame(width: W(325), height: H(350))
                .background(Color.white)
                .cornerRadius(11)
                .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1816673802)), radius: 7, x: 0, y: 10)
                .scaleEffect(isShowPopup ? 1 : 0.1)
        }.opacity(isShowPopup ? 1 : 0)
            .animation(.easeInOut(duration: 0.2))
            .edgesIgnoringSafeArea(.all)
    }
}
