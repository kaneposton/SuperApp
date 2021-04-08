// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SalePolicyStandardView: View {
    @Binding var payTimes: Int
    @Binding var moneyFirst: String
    @Binding var sumMoney: String
    @Binding var isExpand: Bool
    @Binding var isNextLoanRule: Bool
    @Binding var isNextLoanContact: Bool
    @Binding var isShowComboboxStandard: Bool
    @Binding var selectedComboStartdard: Int
    @Binding var isChangeColor: Bool
    @Binding var selectedComboStartdardName: String

    @State var strDeposit = ""
    @State var isMore = true

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack (spacing: H(5)) {
                    TextCustom(text: NSLocalizedString("sale_policy_total_coin", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.9881314635, green: 0.9882968068, blue: 0.9881082177, alpha: 1))
                    TextCustom(text: Utils.formatHighNumber(Double(sumMoney) ?? 0), size: 30, color: #colorLiteral(red: 0.97636801, green: 0.976531446, blue: 0.9763450027, alpha: 1))
                }.frame(width: FULL_W - 72, height: H(90))
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)), .init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(4)
                VStack (alignment: .leading, spacing: H(8)) {
                    HStack {
                        TextCustom(text: NSLocalizedString("sale_policy_progress_pay", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                        Spacer()
                    }
                    Button(action: {
                        self.isShowComboboxStandard = true
                        self.isChangeColor = true
                    }) {
                        ZStack (alignment: .trailing) {
                            HStack {
                                ZStack (alignment: .leading) {
                                    TextCustom(text: NSLocalizedString("sale_policy_pickup_progress", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                                        .opacity(selectedComboStartdard == -1 ? 1 : 0)
                                    TextCustom(text: selectedComboStartdardName, font: REGULAR, size: 16, color: #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1))
                                        .opacity(selectedComboStartdard != -1 ? 1 : 0)
                                }.padding(.leading, 16)
                                Spacer()
                            }
                            ImageCustom(name: "path21405", w: 13.2, h: 7.4)
                                .padding(.trailing, 16)
                        }.frame(height: H(40))
                            .background(Color.white)
                            .overlay(Rectangle().stroke(Color.init(#colorLiteral(red: 0.9018655419, green: 0.9020171762, blue: 0.9018443227, alpha: 1)), lineWidth: 1))
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                }.padding(.top, H(34))
                    .padding(.horizontal, 16)
                VStack (alignment: .trailing, spacing: H(8)) {
                    HStack {
                        TextCustom(text: NSLocalizedString("sale_policy_deposit_coin", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                        Spacer()
                    }
                    ZStack (alignment: .trailing) {
                        Rectangle()
                            .frame(height: H(40))
                            .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                        HStack {
                            TextCustom(text: Utils.formatHighNumber(Double(sumMoney) ?? 0), font: REGULAR, size: 16, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                .padding(.leading, 16)
                            Spacer()
                        }
                        TextCustom(text: "VND", font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                            .padding(.trailing, 16)
                    }
                }.padding(.top, H(20))
                    .padding(.horizontal, 16)
                VStack (spacing: H(14)) {
                    Button(action: {
                        self.isNextLoanContact = true
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_contact_buy", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        }.frame(width: FULL_W - 106, height: H(40))
                    }.buttonStyle(ButtonTapScale())
                    Button(action: {
                        self.isNextLoanRule = true
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_planning_rent", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        }.frame(width: FULL_W - 106, height: H(40))
                    }.buttonStyle(ButtonTapScale())
                }.animation(.easeInOut(duration: 0.1))
                    .padding(.top, H(30))
                    .padding(.bottom, H(25))
            }.frame(width: FULL_W - 72)
                .background(Color.init(#colorLiteral(red: 0.958314185, green: 0.958314185, blue: 0.958314185, alpha: 1)))
                .cornerRadius(4, corners: [.topLeft, .topRight])
                .padding(.top, H(10))
            if selectedComboStartdard != -1 {
                ZStack {
                    Rectangle()
                        .frame(width: FULL_W - 74, height: H(56))
                        .foregroundColor(.white)
                        .overlay(Rectangle().stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                    TextCustom(text: "\(NSLocalizedString("sale_policy_first_money", comment: "")) \(Utils.formatHighNumber(Double(moneyFirst) ?? 0))", font: REGULAR, size: 22, color: #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1))
                }.padding(.top, H(30))
                ZStack (alignment: .bottom) {
                    if isExpand {
                        Sale_Policy_Detail_Expand(payTimes: $payTimes).padding(.top, H(39.5))
                    } else {
                        Sale_Policy_Detail_Collapse(payTimes: $payTimes, isMore: $isMore).padding(.top, H(39.5))
                        if isMore {
                            ZStack (alignment: .top) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: H(150))
                                Button(action: {
                                    self.isExpand = true
                                }) {
                                    VStack (spacing: H(6)) {
                                        TextCustom(text: NSLocalizedString("sale_policy_see_more", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2466594875, green: 0.294318378, blue: 0.4133430123, alpha: 1))
                                        ImageCustom(name: "collapse", w: 10, h: 10)
                                            .rotationEffect(.degrees(180))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                    .padding(.top, H(8))
                            }.offset(y: H(10))
                        }
                    }
                }
                if !isMore {
                    Button(action: {

                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 74, height: H(56))
                                .foregroundColor(.white)
                                .overlay(Rectangle().stroke(Color.init(#colorLiteral(red: 0.6713281274, green: 0.6665424109, blue: 0.6665092111, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_paydone", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.3147253096, green: 0.7686968446, blue: 0.4422957301, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.top, H(30.5))
                } else if isExpand {
                    Button(action: {

                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 74, height: H(56))
                                .foregroundColor(.white)
                                .overlay(Rectangle().stroke(Color.init(#colorLiteral(red: 0.6713281274, green: 0.6665424109, blue: 0.6665092111, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_paydone", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.3147253096, green: 0.7686968446, blue: 0.4422957301, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.top, H(30.5))
                    Button(action: {
                        self.isExpand = false
                    }) {
                        VStack (spacing: H(6)) {
                            TextCustom(text: NSLocalizedString("sale_policy_see_less", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2466594875, green: 0.294318378, blue: 0.4133430123, alpha: 1))
                            ImageCustom(name: "collapse", w: 10, h: 10)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.top, H(25))
                        .padding(.bottom,
                            FULL_H == H_SE && FULL_W == W_SE ? H(25): // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? H(25): // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? H(25) : 0
                        )
                }
            }
        }.frame(width: FULL_W)
    }
}
