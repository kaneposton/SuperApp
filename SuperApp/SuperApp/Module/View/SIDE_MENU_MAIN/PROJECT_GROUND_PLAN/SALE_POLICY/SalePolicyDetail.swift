// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct percentType: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var percent: Int
    var money: String
    var process: String
    var paidMoney: String
    var notice: String
    var isDiscout: Bool
}

struct Sale_Policy_Detail_Expand: View {
    @Binding var payTimes: Int

    @State var currentHeight: CGFloat = 0

    @State var arrPercent = [
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true)
    ]

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            ForEach(0 ..< arrPercent.count) { i in
                SalePolicyDetailBubble(
                    index: self.arrPercent[i].id,
                    title: self.arrPercent[i].title,
                    percent: self.arrPercent[i].percent,
                    money: self.arrPercent[i].money,
                    process: self.arrPercent[i].process,
                    paidMoney: self.arrPercent[i].paidMoney,
                    notice: self.arrPercent[i].notice,
                    isDiscout: self.arrPercent[i].isDiscout,
                    isEnd: self.arrPercent.endIndex - 1 == i ? true : false
                )
            }
        }.onAppear {
            self.payTimes = self.arrPercent.count + 1
        }.frame(width: FULL_W, alignment: .leading)
            .offset(x: W(
                FULL_H == H_SE && FULL_W == W_SE ? 27: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 21: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 17: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 17: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro
                    ))
    }
}

struct Sale_Policy_Detail_Collapse: View {
    @Binding var payTimes: Int
    @Binding var isMore: Bool
    @State var currentHeight: CGFloat = 0

    @State var arrPercent = [
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true),
        percentType(
            title: "Cọc lần 3",
            percent: 20,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 3",
            percent: 30,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "",
            notice: "",
            isDiscout: false),
        percentType(
            title: "Cọc lần 2",
            percent: 15,
            money: "350000000",
            process: "10 ngày sau cọc, ký HĐMB",
            paidMoney: "450000000",
            notice: "chưa VAT",
            isDiscout: true)
    ]

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            if self.arrPercent.count <= 2 {
                ForEach(0 ..< arrPercent.count) { i in
                    SalePolicyDetailBubble(
                        index: self.arrPercent[i].id,
                        title: self.arrPercent[i].title,
                        percent: self.arrPercent[i].percent,
                        money: self.arrPercent[i].money,
                        process: self.arrPercent[i].process,
                        paidMoney: self.arrPercent[i].paidMoney,
                        notice: self.arrPercent[i].notice,
                        isDiscout: self.arrPercent[i].isDiscout,
                        isEnd: self.arrPercent.endIndex - 1 == i ? true : false
                    )
                }
            } else {
                ForEach(0 ..< 3) { i in
                    SalePolicyDetailBubble(
                        index: self.arrPercent[i].id,
                        title: self.arrPercent[i].title,
                        percent: self.arrPercent[i].percent,
                        money: self.arrPercent[i].money,
                        process: self.arrPercent[i].process,
                        paidMoney: self.arrPercent[i].paidMoney,
                        notice: self.arrPercent[i].notice,
                        isDiscout: self.arrPercent[i].isDiscout,
                        isEnd: i == 2 ? true : false
                    )
                }
            }
        }.frame(width: FULL_W, alignment: .leading)
            .offset(x: W(
                FULL_H == H_SE && FULL_W == W_SE ? 27: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 21: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 17: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 17: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro
                    ))
            .onAppear {
                self.payTimes = self.arrPercent.count + 1
                if self.arrPercent.count <= 2 {
                    self.isMore = false
                }
        }
    }
}

struct SalePolicyDetailBubble: View {
    @State var index = UUID()
    @State var title = ""
    @State var percent = 0
    @State var money = ""
    @State var process = ""
    @State var paidMoney = ""
    @State var notice = ""

    @State var currentHeight: CGFloat = 0
    @State var count = 0
    @State var isDiscout = false
    @State var isEnd = false

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                ZStack (alignment: .top) {
                    ZStack (alignment: .bottom) {
                        Rectangle()
                            .frame(width: 2.5, height: self.currentHeight)
                            .foregroundColor(.clear)
                        VStack {
                            Rectangle()
                                .frame(width: 2.5, height: count == 3 ? H(27.5):
                                        count == 2 ? H(22):
                                        count == 1 ? H(17) : H(11.5))
                                .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                            Spacer()
                        }
                        Rectangle()
                            .frame(width: 2.5, height: count == 3 ? self.currentHeight - W(42) - H(27.5):
                                    count == 2 ? self.currentHeight - W(42) - H(22):
                                    count == 1 ? self.currentHeight - W(42) - H(17): self.currentHeight - W(42) - H(11.5))
                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                    }.frame(height: self.currentHeight)
                    ZStack (alignment: . bottom) {
                        Rectangle()
                            .frame(width: W(42), height: W(42))
                            .foregroundColor(.clear)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: W(14), height: W(14))
                            .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                            .cornerRadius(.infinity)
                            .shadow(color: .init(#colorLiteral(red: 0.5504639911, green: 0.5504639911, blue: 0.5504639911, alpha: 0.6955265411)), radius: 3)
                            .offset(y: H(-23))
                        TextCustom(text: "\(percent)%", font: MEDIUM, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                            .offset(y: H(-4))
                    }.offset(y:
                            count == 3 ? H(27.5):
                            count == 2 ? H(22):
                            count == 1 ? H(17) : H(11.5)
                    )
                }
                VStack (alignment: .leading, spacing: 5) {
                    HStack (spacing: 0) {
                        TextCustom(text: "\(title) - ", size: 20, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        TextCustom(text: "15%", font: REGULAR, size: 20, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        Spacer()
                        if isDiscout {
                            HStack (spacing: 0) {
                                TextCustom(text: "(", font: LIGHT_ITALIC, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                                TextCustomUnderLine(text: "Ưu đãi", font: LIGHT_ITALIC, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                                TextCustom(text: ")", font: LIGHT_ITALIC, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                            }
                            Spacer()
                        }
                    }
                    TextCustom(text: "\(Utils.formatHighNumber(Double(money) ?? 0)) (vnd)", size: 22, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    if !process.isEmpty {
                        HStack (spacing: 5) {
                            Circle().frame(width: W(6), height: W(6)).foregroundColor(.init(#colorLiteral(red: 0.6026069522, green: 0.6026815176, blue: 0.6025817394, alpha: 1)))
                            TextCustom(text: NSLocalizedString("sale_policy_detail_process", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
                            TextCustom(text: process, font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1215686275, blue: 0.1215686275, alpha: 1))
                        }
                    }
                    if !paidMoney.isEmpty {
                        HStack (spacing: 5) {
                            Circle().frame(width: W(6), height: W(6)).foregroundColor(.init(#colorLiteral(red: 0.6026069522, green: 0.6026815176, blue: 0.6025817394, alpha: 1)))
                            TextCustom(text: NSLocalizedString("sale_policy_detail_paid_money", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
                            TextCustom(text: "\(Utils.formatHighNumber(Double(paidMoney) ?? 0)) (vnd)", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1215686275, blue: 0.1215686275, alpha: 1))
                        }
                    }
                    if !notice.isEmpty {
                        HStack (spacing: 5) {
                            Circle().frame(width: W(6), height: (6)).foregroundColor(.init(#colorLiteral(red: 0.6026069522, green: 0.6026815176, blue: 0.6025817394, alpha: 1)))
                            TextCustom(text: NSLocalizedString("sale_policy_detail_paid_notice", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
                            TextCustom(text: notice, font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1215686275, blue: 0.1215686275, alpha: 1))
                        }
                    }
                }.padding(.vertical, 18)
                    .padding(.leading, W(30))
                    .padding(.trailing, W(26))
                    .background(
                        GeometryReader { geometry in
                            Image("union135")
                                .resizable()                               
                                .onAppear { self.currentHeight = geometry.size.height }
                        }
                    ).padding(.trailing, W(
                        FULL_H == H_SE && FULL_W == W_SE ? 75: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 62: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 53: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 53: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 62 : 0 // iPhone 11 Pro
                            ))
            }.frame(height: self.currentHeight)
                .onAppear {
                    if !self.process.isEmpty {
                        self.count += 1
                    }
                    if !self.paidMoney.isEmpty {
                        self.count += 1
                    }
                    if !self.notice.isEmpty {
                        self.count += 1
                    }
            }
            if !isEnd {
                ZStack {
                    Rectangle().frame(width: 2.5, height: H(31)).foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                }.frame(width: W(42))
            }
        }
    }
}
