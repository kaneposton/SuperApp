// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct DetailStep_3: View {
    @Binding var loanMoney: String
    @Binding var purple: Int
    @Binding var green: Int
    @Binding var isNextLoanContact: Bool
    @Binding var isNextLoanOnline: Bool

    @State var startAnimation = false
    @State var orange = 42583334

    var body: some View {
        VStack (spacing: 0) {
            VStack (spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        TextCustom(text: NSLocalizedString("sale_policy_step3_resultCount", comment: ""), size: 16, color: #colorLiteral(red: 0.3971883059, green: 0.1756276488, blue: 0.624458909, alpha: 1))
                        Spacer()
                    }.padding(.top, H(20))
                        .padding(.leading, 14)
                    TextCustom(text: NSLocalizedString("sale_policy_step3_sumPay", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.5373396873, green: 0.5373396873, blue: 0.5373396873, alpha: 1))
                        .padding(.top, H(9))
                    TextCustom(text: Utils.formatHighNumber(Double(purple + orange)), size: 40, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                        .padding(.top, H(5))
                        .padding(.bottom, H(23))

                    // MARK: CHART
                    CircleChartCustom(purple: $purple, green: $green).padding(.bottom, H(19))
                }.background(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        TextCustom(text: NSLocalizedString("sale_policy_step3_firstTimePay", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.5373396873, green: 0.5373396873, blue: 0.5373396873, alpha: 1))
                        TextCustom(text: Utils.formatHighNumber(Double(5208334)), size: 20, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                            .padding(.top, H(10))
                        TextCustom(text: NSLocalizedString("sale_policy_step3_saveMoneyPay", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.5373396873, green: 0.5373396873, blue: 0.5373396873, alpha: 1))
                            .padding(.top, H(25))
                        TextCustom(text: "0", size: 20, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                            .padding(.top, H(10))
                        TextCustom(text: NSLocalizedString("sale_policy_step3_payEarlyCost", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.5373396873, green: 0.5373396873, blue: 0.5373396873, alpha: 1))
                            .padding(.top, H(25))
                        TextCustom(text: "0", size: 20, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                            .padding(.top, H(10))
                    }.padding(.top, H(21))
                        .padding(.bottom, H(19))
                        .padding(.leading, W(14))
                    Spacer()
                }.background(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .padding(.top, H(30))

                VStack (alignment: .leading, spacing: H(20)) {
                    TextCustom(text: NSLocalizedString("sale_policy_step3_tableDetailPay", comment: ""), size: 14, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                        .padding(.top, H(20))
                        .padding(.leading, 14)
                    HStack {
                        Button(action: {

                        }) {
                            ZStack (alignment: .trailing) {
                                ZStack (alignment: .leading) {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.3220589161, green: 0.2225066423, blue: 0.7712993026, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                                        .frame(width: W(126), height: W(37))
                                        .cornerRadius(4)
                                    TextCustom(text: NSLocalizedString("sale_policy_step3_downloadFile", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                        .padding(.leading, 13)
                                }
                                ImageCustom(name: "path20922", w: 16, h: 16)
                                    .padding(.trailing, 12)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                    }.padding(.leading, 14)
                        .padding(.bottom, H(23))
                }.background(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .padding(.top, H(16))
            }.padding(.vertical, H(30))
                .padding(.horizontal, 16)
                .cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)

            // MARK: BUTTON LIÊN HỆ MUA
            Button(action: {
                self.isNextLoanContact = true
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: FULL_W - 34, height: H(38))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                        .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                    TextCustom(text: NSLocalizedString("sale_policy_step3_button_contactBuy", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: startAnimation ? 0.1 : 0))
                .padding(.bottom, H(12))

            // MARK: BUTTON ĐẶT CHỖ
            Button(action: {

            }) {
                ZStack {
                    Rectangle()
                        .frame(width: FULL_W - 34, height: H(38))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                        .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                    TextCustom(text: NSLocalizedString("sale_policy_step3_button_order", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: startAnimation ? 0.1 : 0))
                .padding(.bottom, H(11))

            // MARK: BUTTON NỘP HỒ SƠ VAY ONLINE
            Button(action: {
                self.isNextLoanOnline = true
            }) {
                ZStack {
                    TextCustom(text: NSLocalizedString("sale_policy_step3_button_rentOnline", comment: ""), font: MEDIUM, size: 16, color: .white)
                }.frame(width: FULL_W - 32, height: H(40))
                    .background(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                    .cornerRadius(4)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4005511558)), radius: 6, x: 3, y: 3)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: startAnimation ? 0.1 : 0))
                .padding(.bottom, H(35))
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.startAnimation = true
            }
        }
    }
}

struct CircleChartCustom: View {
    @Binding var purple: Int
    @Binding var green: Int

    @State var percent: CGFloat = 50
    @State var type = 0
    @State var orange = 42583334
    @State var frameInclude: CGFloat = 0
    @State var paddingFromChart: CGFloat = 0
    @State var rangeCircle: CGFloat = 0
    @State var widthStroke: CGFloat = 0

    let timer = Timer.publish(every: 0.07, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack (alignment: .leading) {
            HStack {
                ZStack {
                    ZStack {
                        Circle()
                            .stroke(Color.init(#colorLiteral(red: 0.316752702, green: 0.7668554187, blue: 0.4452946782, alpha: 1)), lineWidth: widthStroke)
                            .frame(width: rangeCircle, height: rangeCircle)
                    }
                    VStack (spacing: H(3)) {
                        TextCustom(text: "\(Utils.formatIntNumber(Double(percent)))%", size: 32, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                        TextCustom(text: NSLocalizedString("sale_policy_step3_summaryCash", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                    }
                    ZStack {
                        Circle()
                            .trim(from: 0, to: CGFloat(Float(orange + purple) / Float(green) + 0.015))
                            .stroke(Color.white, lineWidth: widthStroke)
                            .frame(width: rangeCircle, height: rangeCircle)
                            .rotationEffect(.degrees(-2.7))
                        Circle()
                            .trim(from: 0, to: CGFloat(Float(orange + purple) / Float(green)))
                            .stroke(Color.init(#colorLiteral(red: 0.9764705882, green: 0.5719811916, blue: 0.2055700123, alpha: 1)), lineWidth: widthStroke)
                            .frame(width: rangeCircle, height: rangeCircle)
                        Circle()
                            .trim(from: 0, to: CGFloat(Float(purple) / Float(green) + 0.015))
                            .stroke(Color.white, lineWidth: widthStroke)
                            .frame(width: rangeCircle, height: rangeCircle)
                            .rotationEffect(.degrees(-2.7))
                        Circle()
                            .trim(from: 0, to: CGFloat(Float(purple) / Float(green)))
                            .stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: widthStroke)
                            .frame(width: rangeCircle, height: rangeCircle)
                            .onAppear {
                                self.percent = CGFloat(truncating: NumberFormatter().number(from: Utils.formatIntNumber(Double((CGFloat(self.purple) / CGFloat(self.green)) * 100))) ?? 0)
                        }
                    }.rotationEffect(.degrees(270 + 1))
                }.frame(width: frameInclude, height: frameInclude)
                    .padding(.leading, type == 0 ? 14 : 0)
                if type == 0 {
                    Spacer()
                }
            }
            if type == 0 {
                VStack (alignment: .leading) {
                    describeChartCircle(color: #colorLiteral(red: 0.316752702, green: 0.7668554187, blue: 0.4452946782, alpha: 1), label: "sale_policy_step3_summaryCash", value: green)
                    Spacer()
                    describeChartCircle(color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1), label: "sale_policy_step3_rentCash", value: purple)
                    Spacer()
                    describeChartCircle(color: #colorLiteral(red: 0.977475822, green: 0.5719811916, blue: 0.2055700123, alpha: 1), label: "sale_policy_step3_sumMoreCash", value: orange)
                }.frame(height: frameInclude)
                    .padding(.leading, paddingFromChart)
                    .padding(.trailing, 14)
            }
        }.onAppear {
            self.rangeCircle = self.type == 0 ?
            FULL_H == H_SE && FULL_W == W_SE ? 135: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 168: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 190: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 190: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 170 : 0 // iPhone 11 Pro
            : FULL_H == H_SE && FULL_W == W_SE ? 115: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 140: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 160: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 160: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 150 : 0 // iPhone 11 Pro

            self.widthStroke = self.type == 0 ?
            FULL_H == H_SE && FULL_W == W_SE ? 15: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 20: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 20: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro
            : FULL_H == H_SE && FULL_W == W_SE ? 15: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 20: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 20: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro

            self.frameInclude = self.widthStroke + self.rangeCircle
            self.paddingFromChart = 14 + self.frameInclude + 27
        }
    }
}

struct describeChartCircle: View {
    @State var color = #colorLiteral(red: 0.316752702, green: 0.7668554187, blue: 0.4452946782, alpha: 1)
    @State var label = ""
    @State var value = 0

    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            HStack (spacing: 6) {
                Rectangle()
                    .frame(width: W(8), height: W(8))
                    .cornerRadius(.infinity)
                    .foregroundColor(.init(color))
                TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
            }
            TextCustom(text: Utils.formatHighNumber(Double(value)), size: 18, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
        }
    }
}
