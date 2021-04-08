// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SalePolicyContactBuyFinish: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool

    @State var strSearch = ""
    @State var strName = ""
    @State var strNumber = ""
    @State var isNextFinishBuy = false

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                        .padding(.top, H(64))
                    VStack (alignment: .leading, spacing: H(28)) {
                        TextCustom(text: NSLocalizedString("sale_policy_contact_bigTitle", comment: ""), font: MEDIUM, size: 26, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                        TextCustom(text: NSLocalizedString("sale_policy_contact_finish", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    }.padding(.top, H(55))
                        .padding(.horizontal, 20)
                        .frame(width: FULL_W)
                    Image ("group12557")
                        .resizable()
                        .frame(width: W(207), height: W(210))
                        .padding(.top, H(48))
                        .padding(.bottom, H(20))
                    Button(action: {
                        self.isRoot = false
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 72, height: H(40))
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                            TextCustom(text: NSLocalizedString("sale_policy_contact_back", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                    Spacer()
                }

                //MARK: NAVIGATION BAR
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "sale_policy_contact_buy",
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
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .edgesIgnoringSafeArea(.bottom)
        }.navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
    }
}
