//  Created by Tran Thien Phu on 5/5/20.
import SwiftUI

struct LoanRuleStep_1: View {
    @Binding var step: Int
    @Binding var selectedMethod: CGFloat
    @Binding var initValue: Int
    
    var body: some View {
        VStack (spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
            ScrollView (showsIndicators: false) {
                VStack (spacing: 0) {
                    HStack (spacing: 8) {
                        TextCustom(text: NSLocalizedString("sale_policy_step_1", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                        TextCustom(text: NSLocalizedString("sale_policy_step_1_title", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                    }.padding(.top, H(20))
                        .padding(.bottom, H(19))
                    ZStack {
                        Rectangle()
                            .frame(height: H(4))
                            .foregroundColor(.init(#colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1)))
                            .padding(.horizontal, 95)
                        HStack(spacing: 0) {
                            SalePolicyCustomImage(step: 1, imageName: "creditCard", index: 1)
                            Spacer()
                            SalePolicyCustomImage(step: 1, imageName: "calculatorWhite", index: 2)
                            Spacer()
                            SalePolicyCustomImage(step: 1, imageName: "addCheckWhite", index: 3)
                        }.frame(width: FULL_W - 190)
                    }
                }
            }
        }.padding(.top, H(64))
    }
}
