// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanOnlineResultView: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool

    @State var isNext = false
    @State var label = """
        Cảm ơn bạn đã điền hồ sơ, chúng tôi sẽ xem xét và duyệt hồ sơ của bạn sớm nhất có thể. Bạn thể xem tiếp dữ án hoặc vào phần "Quản lý tài khoản" để xem lại thông tin.
        """
    @State var title_btn = """
        Đến "Quản lý tài khoản"
        """

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                        .padding(.top, H(64))
                        .padding(.bottom, H(112))
                    ImageCustom(name: "resultSuccess", w: 120, h: 120)
                    TextCustom(text: NSLocalizedString("loan_online_result_success", comment: ""), size: 24, color: #colorLiteral(red: 0.214740485, green: 0.2495550513, blue: 0.3447138667, alpha: 1))
                        .padding(.top, H(54))
                    TextCustom(text: label, font: REGULAR, size: 16, color: #colorLiteral(red: 0.1401897073, green: 0.1228597537, blue: 0.1228597537, alpha: 1))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 36)
                        .padding(.top, H(30))
                        .padding(.bottom, H(40))

                    // MARK: BUTTON QUAY VỀ DỰ ÁN
                    Button(action: {
                        self.isRoot = false
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 72, height: H(38))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                            TextCustom(text: NSLocalizedString("sale_policy_contact_back", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))

                    // MARK: BUTTON ĐẾN "QUẢN LÝ HỒ SƠ"
                    Button(action: {

                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 72, height: H(38))
                                .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                .cornerRadius(4)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                            TextCustom(text: NSLocalizedString("\(title_btn)", comment: "")
                                , font: MEDIUM, size: 16, color: .white)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.top, H(15))
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "loan_online_title",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: { },
                    textFunc: { },
                    isCallAndTextBlack: true,
                    noCallAndText: true
                )
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

