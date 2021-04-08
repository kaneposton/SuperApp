//  Created by Tran Thien Phu on 5/5/20.
import SwiftUI

struct LoanRuleStep_2: View {
    @Binding var step: Int
    @Binding var selectedMethod: CGFloat
    @Binding var isShowDatePicker: Bool
    @Binding var isChangeColor: Bool
    @Binding var labelDatePicker: String
    @Binding var showNextFailed: Bool
    @Binding var isPaddingBottomKeyboard: Bool
    @Binding var isKeyboardPush: Bool
    @Binding var loanMoney: String
    @Binding var year: String
    @Binding var month: String
    @Binding var isCheckBox2_3: Bool
    @Binding var time: String
    @Binding var fee: String
    @Binding var isCheckBox2_2: Bool
    @Binding var time2_2: String
    @Binding var fee2_2: String
    @Binding var date_Step_1: Date
    @Binding var date_Step_2: Date
    @Binding var initValue: Int
    @Binding var purple: Int
    @Binding var sumMoney: String
    @Binding var green: Int
    @Binding var typeAlert: Int

    var body: some View {
        ZStack (alignment: .top) {
            VStack (spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 0) {
                        HStack (spacing: 8) {
                            TextCustom(text: NSLocalizedString("sale_policy_step2", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_step2_title", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                        }.padding(.top, H(20))
                            .padding(.bottom, H(19))
                        ZStack {
                            Rectangle()
                                .frame(height: H(4))
                                .foregroundColor(.init(#colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1)))
                                .padding(.horizontal, 95)
                            HStack(spacing: 0) {
                                SalePolicyCustomImage(step: 2, imageName: "stepCheck", index: 1)
                                Spacer()
                                SalePolicyCustomImage(step: 2, imageName: "calculatorPurple", index: 2)
                                Spacer()
                                SalePolicyCustomImage(step: 2, imageName: "addCheckWhite", index: 3)
                            }.frame(width: FULL_W - 190)
                        }
                    }
                }
            }.padding(.top, H(64))
        }
    }
}

