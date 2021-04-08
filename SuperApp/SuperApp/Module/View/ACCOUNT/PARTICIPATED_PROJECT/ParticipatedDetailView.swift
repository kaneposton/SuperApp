// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ParticipatedDetailView: View {
    @Binding var isNextOld: Bool
    @Binding var houseName: String
    @Binding var projectName: String

    @State var tempPullScreen = false
    @State var isShowing = false
    @State var isPull = false
    @State var isNext = false

    var body: some View {
        NavigationView {
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
                    List {
                        ZStack (alignment: .top) {
                            if !isPull {
                                VStack (alignment: .leading, spacing: H(12)) {
                                    ZStack (alignment: .leading) {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.5098039216, green: 0.631372549, blue: 1, alpha: 1)), .init(#colorLiteral(red: 0.3019607843, green: 0.4117647059, blue: 1, alpha: 1))]), startPoint: .trailing, endPoint: .leading))
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                ImageCustom(name: "companyWhite", w: 38, h: 56)
                                            }
                                        }
                                        VStack (alignment: .leading, spacing: H(7)) {
                                            TextCustom(text: NSLocalizedString("filter_project", comment: ""), font: MEDIUM, size: 14, lineLimit: 1, color: .white)
                                            TextCustom(text: projectName, size: 16, lineLimit: 1, color: .white)
                                        }.padding(.horizontal, 16)
                                    }.frame(width: FULL_W - 40, height: H(66))
                                        .cornerRadius(4)
                                        .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.5100064212)), radius: 3, x: 3, y: 3)
                                        .padding(.leading, 20)
                                    HStack (spacing: 12) {
                                        ZStack (alignment: .leading) {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.5725490196, green: 0.8862745098, blue: 0.6588235294, alpha: 1)), .init(#colorLiteral(red: 0.08235294118, green: 0.7568627451, blue: 0.2901960784, alpha: 1))]), startPoint: .trailing, endPoint: .leading))
                                            HStack {
                                                Spacer()
                                                ImageCustom(name: "moneyWhiteParti", w: 42, h: 47)
                                            }
                                            VStack (alignment: .leading, spacing: H(7)) {
                                                TextCustom(text: NSLocalizedString("parti_moneyCost", comment: ""), font: MEDIUM, size: 14, lineLimit: 1, color: .white)
                                                TextCustom(text: "13.000.000.000", size: 16, lineLimit: 1, color: .white)
                                            }.padding(.horizontal, 16)
                                        }.frame(width: (FULL_W - 40) / 2 - 6, height: H(70))
                                            .cornerRadius(4)
                                            .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.5100064212)), radius: 3, x: 3, y: 3)
                                        ZStack (alignment: .leading) {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 1, green: 0.6901960784, blue: 0.4941176471, alpha: 1)), .init(#colorLiteral(red: 0.9882352941, green: 0.5450980392, blue: 0.2666666667, alpha: 1))]), startPoint: .trailing, endPoint: .leading))
                                            HStack {
                                                Spacer()
                                                ImageCustom(name: "paymentTimes", w: 48, h: 58)
                                            }
                                            VStack (alignment: .leading, spacing: H(7)) {
                                                TextCustom(text: NSLocalizedString("parti_paytimeUp", comment: ""), font: MEDIUM, size: 14, lineLimit: 1, color: .white)
                                                TextCustom(text: "15 \(NSLocalizedString("parti_timetimes", comment: ""))", size: 16, lineLimit: 1, color: .white)
                                            }.padding(.horizontal, 16)
                                        }.frame(width: (FULL_W - 40) / 2 - 6, height: H(70))
                                            .cornerRadius(4)
                                            .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.5100064212)), radius: 3, x: 3, y: 3)
                                    }.padding(.leading, 20)
                                    Rectangle()
                                        .frame(width: FULL_W - 40, height: 1)
                                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                                        .padding(.leading, 20)
                                    VStack (spacing: H(12)) {
                                        ParticipateEarch(houseName: $houseName, index: 1)
                                        ParticipateEarch(houseName: $houseName, index: 2)
                                        ParticipateEarch(houseName: $houseName, index: 3)
                                    }.padding(.leading, 20)
                                }
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                            .padding(.top, H(20))
                            .padding(.bottom, H(
                                FULL_H == H_SE && FULL_W == W_SE ? 117: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 117: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 117: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 127: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 127 : 117 // iPhone 11 Pro
                                    )
                            )
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
                VStack {
                    Spacer()
                    ZStack (alignment:
                            FULL_H == H_SE && FULL_W == W_SE ? .center: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? .center: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? .center: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? .top: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? .top : .center // iPhone 11 Pro
                    ) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 97: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 97: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 97: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 107: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 107 : 97 // iPhone 11 Pro
                                    ))
                            .shadow(color: .init(#colorLiteral(red: 0.5813372462, green: 0.5813372462, blue: 0.5813372462, alpha: 0.2016802226)), radius: 3, y: -3)
                        Button(action: {
                            self.isNext = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.5148331523, green: 0.3035488725, blue: 0.7222019434, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .frame(width: FULL_W - 40, height: H(49))
                                    .cornerRadius(4)
                                TextCustom(text: NSLocalizedString("parti_watchPayProcess", comment: ""), font: MEDIUM, size: 18, color: .white)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.top, H(
                                FULL_H == H_SE && FULL_W == W_SE ? 0: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 0: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 0: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 24: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 24 : 0 // iPhone 11 Pro
                                    )
                            )
                    }
                }
                NavigationLink(destination:
                        ParticipatePayProcessView(
                            isNextOld: $isNext,
                            houseName: $houseName
                        ), isActive: $isNext) {
                    EmptyView()
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
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ParticipateEarch: View {
    @Binding var houseName: String
    @State var index = 0

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack (spacing: 6) {
                ImageCustom(name: index == 1 ? "product" : index == 2 ? "salesPolicy" : "loanPolicy", w: 40, h: 40)
                VStack (alignment: .leading, spacing: H(4)) {
                    TextCustom(text: NSLocalizedString(
                        index == 1 ? "parti_product":
                            index == 2 ? "parti_sale_way" : "sale_policy_planning_rent"
                        , comment: ""), font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    TextCustom(text:
                            index == 1 ? houseName:
                            index == 2 ? "Tiêu chuẩn" : "Vay thả nổi - SCB",
                        font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1))
                }
                Spacer()
            }
            Rectangle()
                .foregroundColor(.init(#colorLiteral(red: 0.8714131117, green: 0.8864725828, blue: 0.9028440714, alpha: 1)))
                .frame(width: FULL_W - 73 - W(40), height: 1)
                .offset(x: 6 + W(40))
                .padding(.vertical, H(8))
            ZStack (alignment: .leading) {
                HStack (spacing: 6) {
                    ZStack {
                        ImageCustom(name: index == 1 ? "paperId" : index == 2 ? "deposit" : "loanAmount", w: 24, h: 24)
                    }.frame(width: W(40), height: W(40))
                    VStack (alignment: .leading, spacing: H(4)) {
                        TextCustom(text: NSLocalizedString(
                            index == 1 ? "parti_idSheet":
                                index == 2 ? "parti_moneyFirstCost" : "parti_moneyRent"
                            , comment: ""), font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                        TextCustom(text:
                                index == 1 ? "HS0938":
                                index == 2 ? "100.000.000" : "500.000.000",
                            font: MEDIUM, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                    }
                }
                HStack (spacing: 6) {
                    ZStack {
                        ImageCustom(name: index == 1 ? "typesRealEstate" : index == 2 ? "paymentTime" : "loanPeriod", w: 24, h: 24)
                    }.frame(width: W(40), height: W(40))
                    VStack (alignment: .leading, spacing: H(4)) {
                        TextCustom(text: NSLocalizedString(
                            index == 1 ? "parti_type":
                                index == 2 ? "parti_countPayBack" : "parti_timeRent"
                            , comment: ""), font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                        TextCustom(text:
                                index == 1 ? "Căn hộ":
                                index == 2 ? "15" : "10 năm",
                            font: MEDIUM, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                    }
                }.padding(.leading, (FULL_W / 2) - 20)
            }.padding(.bottom, H(6))
            HStack (spacing: 6) {
                ZStack {
                    ImageCustom(name: index == 1 ? "salesAgent" : index == 2 ? "sumMoney" : "moneyPaid", w: 24, h: 24)
                }.frame(width: W(40), height: W(40))
                VStack (alignment: .leading, spacing: H(4)) {
                    TextCustom(text: NSLocalizedString(
                        index == 1 ? "parti_locationSale":
                            index == 2 ? "parti_sumPayCost" : "parti_sumPayBackCost"
                        , comment: ""), font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                    TextCustom(text:
                            index == 1 ? "Đại lý Hưng Phát":
                            index == 2 ? "3.000.000.000" : "597.256.000",
                        font: MEDIUM, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                }
            }
        }.padding(.leading, 10)
            .padding(.vertical, 14)
            .padding(.trailing, 17)
            .background(Color.white)
            .frame(width: FULL_W - 40)
            .cornerRadius(4)
            .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.5992615582)), radius: 3)
    }
}
