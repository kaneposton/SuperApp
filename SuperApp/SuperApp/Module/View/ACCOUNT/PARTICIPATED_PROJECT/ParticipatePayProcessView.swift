// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct dataPayment: Identifiable, Hashable {
    var id = UUID()
    var isPayFirst: Bool
    var payTimes: String
    var calendar: String
    var value: String
    var status: String
    var noti: Bool
}

struct ParticipatePayProcessView: View {
    @Binding var isNextOld: Bool
    @Binding var houseName: String

    @State var isShowing = false
    @State var isPull = false
    @State var tempPullScreen = false
    @State var isPayFinish = false

    @State var dataAlreadyPay = [
        dataPayment(isPayFirst: true, payTimes: "", calendar: "10/02/2020", value: "100.000.000", status: "onTime", noti: false),
        dataPayment(isPayFirst: false, payTimes: "1", calendar: "01/03/2020", value: "125.000.000", status: "late", noti: true),
        dataPayment(isPayFirst: false, payTimes: "2", calendar: "01/04/2020", value: "215.000.000", status: "onTime", noti: false),
        dataPayment(isPayFirst: true, payTimes: "", calendar: "01/05/2020", value: "325.000.000", status: "onTime", noti: false)
    ]

    @State var dataPayLeft = [
        dataPayment(isPayFirst: false, payTimes: "4", calendar: "01/07/2020", value: "100.000.000", status: "stop", noti: true),
        dataPayment(isPayFirst: false, payTimes: "5", calendar: "01/08/2020", value: "125.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "6", calendar: "01/09/2020", value: "215.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "7", calendar: "01/10/2020", value: "325.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "8", calendar: "01/11/2020", value: "125.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "9", calendar: "01/12/2020", value: "215.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "10", calendar: "01/01/2021", value: "325.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "11", calendar: "01/02/2021", value: "215.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "12", calendar: "01/03/2021", value: "325.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "13", calendar: "01/04/2021", value: "125.000.000", status: "", noti: false),
        dataPayment(isPayFirst: false, payTimes: "14", calendar: "01/05/2021", value: "215.000.000", status: "", noti: false)
    ]

    var body: some View {
        ZStack (alignment: .top) {
            if tempPullScreen { Text("") }
            Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: 0) {
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: houseName,
                    backFunc: {
                        self.isNextOld = false
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: { },
                    textFunc: { },
                    isSearchTapAppear: true,
                    isHideIconFilter: true,
                    isHideSearchIcon: true
                )
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                    .padding(.bottom, H(20))
                TextCustom(text: NSLocalizedString(isPayFinish ? "parti_payFinish" : "sale_policy_progress_pay", comment: ""), font: MEDIUM, size: 20, lineLimit: 1, color: isPayFinish ? #colorLiteral(red: 0.1789830029, green: 0.6985920072, blue: 0.3089067936, alpha: 1): #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    .padding(.leading, 20)
                    .padding(.bottom, H(13))
                List {
                    ZStack {
                        if !isPull {
                            VStack (spacing: H(20)) {
                                ParticipateKindProcess(type: 1, data: dataAlreadyPay)
                                if !isPayFinish {
                                    ParticipateKindProcess(type: 2, data: dataPayLeft)
                                }
                            }.padding(.leading, 20)
                        }
                    }.listRowInsets(EdgeInsets())
                        .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                        .padding(.bottom, H(35))
                }.background(PullToRefresh(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isPull = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isShowing = false
                            self.isPull = false
                        }
                    }
                }, isShowing: self.$isShowing))
                Spacer()
            }
        }.onAppear {
            self.tempPullScreen = true
            UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
            UITableView.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().showsVerticalScrollIndicator = false
        }.edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ParticipateKindProcess: View {
    @State var type = -1
    @State var data = [dataPayment(isPayFirst: false, payTimes: "", calendar: "", value: "", status: "", noti: false)]

    @State var collapseData: [dataPayment] = []
    @State var isExpand = false
    @State var isHaveCollapseData = false

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: type == 1 ? [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))] : [.init(#colorLiteral(red: 0.9921568627, green: 0.3843137255, blue: 0.3803921569, alpha: 1)), .init(#colorLiteral(red: 0.9333333333, green: 0.2509803922, blue: 0.2470588235, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: FULL_W - 40, height: H(56))
                HStack (spacing: 0) {
                    TextCustom(text: NSLocalizedString(type == 1 ? "parti_alreadyPay" : "parti_moneyLeft", comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: .white)
                    Spacer()
                    TextCustom(text: type == 1 ? "765.000.000" : "2.235.000.000", size: 18, lineLimit: 1, color: .white)
                    TextCustom(text: "đ", size: 12, lineLimit: 1, color: .white)
                        .offset(y: -7)
                }.padding(.leading, 14)
                    .padding(.trailing, 26)
            }
            VStack (spacing: 0) {
                if data.count >= 4 {
                    if isExpand {
                        ForEach(0 ..< data.count) { i in
                            TimesPaidParticipate(data: self.data[i])
                        }
                    } else {
                        if isHaveCollapseData {
                            ForEach(0 ..< collapseData.count) { i in
                                TimesPaidParticipate(data: self.collapseData[i])
                            }
                        }
                    }
                } else {
                    ForEach(0 ..< data.count) { i in
                        if i == self.data.count - 1 {
                            TimesPaidParticipate(data: self.data[i], isEnd: true)
                        } else {
                            TimesPaidParticipate(data: self.data[i])
                        }
                    }
                }
            }
            if data.count >= 4 {
                HStack {
                    Spacer()
                    Button(action: {
                        self.isExpand.toggle()
                    }) {
                        TextCustom(text: NSLocalizedString(isExpand ? "sale_policy_see_less" : "sale_policy_see_more", comment: ""), font: MEDIUM, size: 14, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                    Spacer()
                }.padding(.vertical, H(16))
                    .background(Color.white)
            }
        }.onAppear {
            if self.data.count >= 4 {
                for i in 0 ..< 3 {
                    self.collapseData.append(self.data[i])
                }
                self.isHaveCollapseData = true
            }
        }.frame(width: FULL_W - 40)
            .cornerRadius(4)
            .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.5992615582)), radius: 3)
    }
}

struct TimesPaidParticipate: View {
    @State var data = dataPayment(isPayFirst: false, payTimes: "", calendar: "", value: "", status: "", noti: false)
    @State var isEnd = false

    var body: some View {
        VStack (alignment: .trailing, spacing: 0) {
            HStack (spacing: 0) {
                VStack (spacing: 0) {
                    ZStack {
                        ImageCustom(name: data.status == "onTime" ? "onTime":
                                data.status == "late" ? "late":
                                data.status == "stop" ? "stopOrange" : "unknownGray"
                            , w: 22, h: 22)
                    }.frame(width: W(22) + 52)
                    TextCustom(text: NSLocalizedString(
                        data.status == "onTime" ? "parti_onTime":
                            data.status == "late" ? "parti_late":
                            data.status == "stop" ? "parti_stop" : "parti_statusUnk"
                        , comment: ""), font: REGULAR, size: 12, color:
                            data.status == "onTime" ? #colorLiteral(red: 0.2105111778, green: 0.8000764251, blue: 0.3518656492, alpha: 1):
                            data.status == "late" ? #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1):
                            data.status == "stop" ? #colorLiteral(red: 0.9805251956, green: 0.54465729, blue: 0.2654898763, alpha: 1): #colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)
                    )
                }
                VStack (alignment: .leading, spacing: H(8)) {
                    HStack (spacing: 0) {
                        TextCustom(text: "\(NSLocalizedString(data.isPayFirst ? "parti_tienCoc" : "parti_thanhToanDot", comment: ""))", size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        if !data.isPayFirst {
                            TextCustom(text: " \(data.payTimes)", size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        }
                    }
                    HStack (spacing: 6) {
                        ImageCustom(name: "calendarParti", w: 14, h: 14)
                        TextCustom(text: data.calendar, font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    }.frame(height: H(18))
                }
                Spacer()
                VStack (alignment: .trailing, spacing: H(8)) {
                    HStack (spacing: 0) {
                        TextCustom(text: data.value, size: 14, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        TextCustom(text: "đ", size: 12, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)).offset(y: -5)
                    }
                    ImageCustom(name: data.noti ? "noti18Red" : "noti18Gray", w: 18, h: 18)
                }.padding(.trailing, 26)
            }.padding(.bottom, H(13))
            if !isEnd {
                Rectangle()
                    .frame(width: FULL_W - W(22) - 118, height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)))
                    .padding(.trailing, 26)
            }
        }.frame(width: FULL_W - 40)
            .padding(.top, H(13))
            .background(Color.white)
    }
}
