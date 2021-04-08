// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ParticipatedProjectView: View {
    @Binding var isNextOld: Bool

    @State var isTapSearch = false
    @State var strSearch = ""
    @State var selectedName = ""
    @State var selectedIndex = 0
    @State var isShowCombobox = false
    @State var showDetailSum = false
    @State var isNext = false
    @State var isShowing = false
    @State var isPull = false
    @State var tempPullScreen = false
    @State var currentHeight: CGFloat = 0
    @State var isEndFor = false
    @State var isSearch = false
    @State var labelCombobox = "parti_chooseProject"
    @State var selectedHouseName = ""
    @State var selectedProjectName = ""

    @State var tempStrSearch = ""
   
    @State var arrParticipated = [
        DataParitipatedProject(
            imageName: "parti_1",
            houseName: "Căn hộ B6 - F1.01",
            price: "2.154.000.000",
            cost: "3.000.000.000",
            alreadyPay: "1.500.000.000",
            payFirst: 0,
            payCurrent: 3,
            paySum: 10,
            projectName: "Royal Garden",
            areaName: "Valencia",
            groupName: "B1",
            status: "late",
            isPayFirst: false,
            isHaveNoti: false
        ),
        DataParitipatedProject(
            imageName: "parti_2",
            houseName: "Biệt thự BT250 ven sông Sài Gòn",
            price: "3.250.000.000",
            cost: "4.750.000.000",
            alreadyPay: "3.500.000.000",
            payFirst: 0,
            payCurrent: 5,
            paySum: 10,
            projectName: "Sunshine Paradise",
            areaName: "The Stella",
            groupName: "C1",
            status: "onTime",
            isPayFirst: false,
            isHaveNoti: true
        ),
        DataParitipatedProject(
            imageName: "parti_3",
            houseName: "Biệt thự mặt phố 75/10 Sài Gòn",
            price: "6.500.000.000",
            cost: "4.750.000.000",
            alreadyPay: "3.500.000.000",
            payFirst: 1,
            payCurrent: 0,
            paySum: 12,
            projectName: "Royal Garden",
            areaName: "Valencia",
            groupName: "B",
            status: "stop",
            isPayFirst: true,
            isHaveNoti: false
        )
    ]

    @State var dataCombo = [
        typeCombobox(id: 0, name: "Tất cả dự án"),
        typeCombobox(id: 1, name: "Dự án chưa thanh toán xong"),
        typeCombobox(id: 2, name: "Dự án đã thanh toán xong")
    ]

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                if tempPullScreen { Text("") }
                if keyboardHeight > 0 {
                    if self.strSearch != self.tempStrSearch {
                        Text("").onAppear {
                            self.showDetailSum = false
                            self.isEndFor = false
                        }
                    }
                } else {
                    Text("").onAppear {
                        self.tempStrSearch = self.strSearch
                    }
                }
                VStack (spacing: 0) {
                    //MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: $isTapSearch,
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: $strSearch,
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "account_project_list",
                        backFunc: {
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true,
                        isHideIconFilter: true
                    )
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                        .padding(.bottom, H(20))
                    VStack (spacing: H(10)) {
                        ZStack {
                            Button(action: {
                                self.isShowCombobox = true
                                UIApplication.shared.endEditing()
                            }) {
                                ZStack (alignment: .leading) {
                                    Rectangle()
                                        .foregroundColor(.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                                        .cornerRadius(4)
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)), lineWidth: 1))
                                        .shadow(color: .init(#colorLiteral(red: 0.6098809909, green: 0.6098809909, blue: 0.6098809909, alpha: 0.4048353692)), radius: 2)
                                    TextCustom(text: selectedIndex != -1 ? selectedName : "---", font: REGULAR, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                        .padding(.leading, 14)
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "comboIconOnline", w: 14.5, h: 8)
                                            .padding(.trailing, 16)
                                    }
                                }.frame(width: FULL_W - 40, height: H(42))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: isTapSearch ? 0.4 : 0.1))
                        }
                        List {
                            ZStack (alignment: .top) {
                                if !isPull {
                                    VStack (spacing: H(16)) {
                                        if arrParticipated.count > 0 {
                                            if strSearch.isEmpty {
                                                ForEach(arrParticipated, id: \.self) { data in
                                                    ListParti(
                                                        isNext: self.$isNext,
                                                        selectedHouseName: self.$selectedHouseName,
                                                        selectedProjectName: self.$selectedProjectName,
                                                        data: data
                                                    )
                                                }
                                            } else if arrParticipated.firstIndex(where: ({ $0.houseName.localizedStandardContains(strSearch) })) == nil {
                                                HStack {
                                                    Spacer()
                                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                                    Spacer()
                                                }.padding(.top, H(100))
                                                    .frame(width: FULL_W - 40)
                                            } else {
                                                ForEach(arrParticipated.filter({ $0.houseName.localizedStandardContains(strSearch) }), id: \.self) { data in
                                                    ListParti(
                                                        isNext: self.$isNext,
                                                        selectedHouseName: self.$selectedHouseName,
                                                        selectedProjectName: self.$selectedProjectName,
                                                        data: data
                                                    )
                                                }
                                            }
                                        } else {
                                            HStack {
                                                Spacer()
                                                ImageCustom(name: "NoResult", w: 219, h: 150)
                                                Spacer()
                                            }.padding(.top, H(100))
                                                .frame(width: FULL_W - 40)
                                        }
                                    }.padding(.top, currentHeight + H(24))
                                        .padding(.leading, 20)
                                    VStack (alignment: .leading, spacing: 0) {
                                        ZStack (alignment: .leading) {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                            TextCustom(text: NSLocalizedString("parti_sumAmount", comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: .white)
                                                .padding(.leading, 14)
                                            HStack (spacing: 0) {
                                                Spacer()
                                                TextCustom(text: "7.2 tỷ đồng", size: 18, lineLimit: 1, color: .white)
                                                    .padding(.trailing, 18)
                                                ZStack {
                                                    ImageCustom(name: "nextWhite", w: 8, h: 14)
                                                        .rotationEffect(.degrees(!showDetailSum ? 0 : 90))
                                                }.frame(width: W(14.5))
                                                    .padding(.trailing, 16)
                                            }
                                        }.frame(width: FULL_W - 40, height: H(56))
                                            .animation(.easeInOut(duration: 0.1))
                                            .onTapGesture {
                                                self.showDetailSum.toggle()
                                                if !self.showDetailSum {
                                                    self.isEndFor = false
                                                }
                                        }
                                        if showDetailSum {
                                            VStack (spacing: H(14)) {
                                                ForEach(0 ..< arrParticipated.count) { i in
                                                    if i == self.arrParticipated.count - 1 {
                                                        ExpandSumParticipate(
                                                            index: i,
                                                            data: self.arrParticipated[i],
                                                            isEnd: true
                                                        ).onAppear {
                                                            self.isEndFor = true
                                                        }
                                                    } else {
                                                        ExpandSumParticipate(
                                                            index: i,
                                                            data: self.arrParticipated[i]
                                                        )
                                                    }
                                                }
                                            }.padding(.top, H(11))
                                                .padding(.bottom, H(15))
                                                .padding(.leading, 24)
                                                .padding(.trailing, 14)
                                                .background(Color.white)
                                        }
                                    }.cornerRadius(4)
                                        .shadow(color: .init(#colorLiteral(red: 0.3119646256, green: 0.3119646256, blue: 0.3119646256, alpha: 0.6360800182)), radius: 3)
                                        .background(
                                            GeometryReader { geometry in
                                                ZStack {
                                                    if self.isEndFor {
                                                        Image("EmptyPicture")
                                                            .resizable()
                                                            .onAppear { self.currentHeight = geometry.size.height }
                                                    } else {
                                                        Image("EmptyPicture")
                                                            .resizable()
                                                            .onAppear { self.currentHeight = geometry.size.height }
                                                    }
                                                }
                                            }
                                        ).padding(.top, H(4))
                                        .padding(.leading, 20)
                                }
                            }.listRowInsets(EdgeInsets())
                                .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                .padding(.bottom, H(35))
                        }.resignKeyboardOnDragGesture()
                            .background(PullToRefresh(action: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isPull = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.showDetailSum = false
                                            self.isShowing = false
                                            self.isPull = false
                                        }
                                    }
                            }, isShowing: self.$isShowing))
                    }
                }.animation(isTapSearch ? .easeInOut(duration: 0.4) : .none)
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isShowCombobox ? 0.5 : 0)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowCombobox = false
                }
                ShowComboboxView(
                    selectedIndexPage: Binding.constant(0),
                    dataOtherSalary: Binding.constant([]),
                    dataCombo4Value: Binding.constant([]),
                    dataTreasure: Binding.constant([]),
                    indexForEach: Binding.constant(0),
                    isChangeColor: Binding.constant(false),
                    isShowCombobox: $isShowCombobox,
                    selectedComboIndex: $selectedIndex,
                    selectedComboName: $selectedName,
                    label: $labelCombobox,
                    data: $dataCombo,
                    isParticipate: true
                )
                NavigationLink(destination:
                        ParticipatedDetailView(
                            isNextOld: $isNext,
                            houseName: $selectedHouseName,
                            projectName: $selectedProjectName
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.keyboardAppear(keyboardHeight: $keyboardHeight)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }.onAppear {
                    self.selectedName = self.dataCombo[self.selectedIndex].name
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

struct ExpandSumParticipate: View {
    @State var index = 0
    @State var data = DataParitipatedProject(imageName: "", houseName: "", price: "", cost: "", alreadyPay: "", payFirst: 0, payCurrent: 0, paySum: 0, projectName: "", areaName: "", groupName: "", status: "", isPayFirst: false, isHaveNoti: false)
    @State var isEnd = false

    var body: some View {
        HStack (spacing: 17) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: W(29), height: W(29))
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.infinity)
                TextCustom(text: "\(index + 1)", font: MEDIUM, size: 13, lineLimit: 1, color: .white)
            }
            VStack (alignment: .leading, spacing: 0) {
                TextCustom(text: data.houseName, font: MEDIUM, size: 14, lineLimit: 2, color: #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1))
                    .padding(.bottom, H(7))
                Rectangle()
                    .frame(width: 64, height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.9636391997, green: 0.9496440291, blue: 0.9981387258, alpha: 1)))
                    .padding(.bottom, H(6))
                HStack (spacing: 0) {
                    ImageCustom(name: "moneyParti", w: 16, h: 16)
                        .padding(.trailing, 7.2)
                    TextCustom(text: "\(NSLocalizedString("parti_cost", comment: "")):", font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    Spacer()
                    TextCustom(text: data.cost, font: MEDIUM, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)).padding(.trailing, 0.5)
                    TextCustom(text: "đ", font: MEDIUM, size: 9, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)).offset(y: -7)
                }.padding(.bottom, H(5))
                HStack (spacing: 0) {
                    ImageCustom(name: "paidMoneyParti", w: 16, h: 16)
                        .padding(.trailing, 7.2)
                    TextCustom(text: "\(NSLocalizedString("parti_alreadyPay", comment: "")):", font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    Spacer()
                    TextCustom(text: data.alreadyPay, font: MEDIUM, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)).padding(.trailing, 0.5)
                    TextCustom(text: "đ", font: MEDIUM, size: 9, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)).offset(y: -7)
                }.padding(.bottom, !isEnd ? H(12) : 0)
                if !isEnd {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)))
                }
            }.frame(width: FULL_W - 124)
        }.background(Color.white)
    }
}

struct DataParitipatedProject: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var houseName: String
    var price: String
    var cost: String
    var alreadyPay: String
    var payFirst: Int
    var payCurrent: Int
    var paySum: Int
    var projectName: String
    var areaName: String
    var groupName: String
    var status: String
    var isPayFirst: Bool
    var isHaveNoti: Bool
}

struct ListParti: View {
    @Binding var isNext: Bool
    @Binding var selectedHouseName: String
    @Binding var selectedProjectName: String
    @State var data = DataParitipatedProject(imageName: "", houseName: "", price: "", cost: "", alreadyPay: "", payFirst: 0, payCurrent: 0, paySum: 0, projectName: "", areaName: "", groupName: "", status: "", isPayFirst: false, isHaveNoti: false)

    var body: some View {
        ZStack (alignment: .topTrailing) {
            Button(action: {
                self.isNext = true
                self.selectedHouseName = self.data.houseName
                self.selectedProjectName = self.data.projectName
            }) {
                VStack (alignment: .leading, spacing: 0) {
                    ZStack (alignment: .topLeading) {
                        Image(data.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: FULL_W - 40, height: H(180))
                            .clipped()
                        HStack (spacing: 8) {
                            ZStack {
                                ImageCustom(name: "EmptyPicture", w: 14, h: 14)
                                ImageCustom(name: data.status == "late" ? "alarmWhite" : data.status == "onTime" ? "doneCheck" : "stopWhite"
                                    , w: data.status == "late" ? 14 : 11, h: data.status == "late" ? 14 : 11)
                            }
                            TextCustom(text: NSLocalizedString(data.status == "late" ? "parti_late" : data.status == "onTime" ? "parti_onTime" : "parti_stop", comment: ""), font: REGULAR, size: 13, color: .white)
                        }.padding(8)
                            .background(Color.init(data.status == "late" ? #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1): data.status == "onTime" ? #colorLiteral(red: 0.3190362453, green: 0.7693782449, blue: 0.442176193, alpha: 1): #colorLiteral(red: 0.9814428687, green: 0.5754714608, blue: 0.2055899501, alpha: 1)))
                            .cornerRadius(0)
                            .shadow(color: .init(#colorLiteral(red: 0.3171002538, green: 0.3171002538, blue: 0.3171002538, alpha: 0.4252193921)), radius: 3, y: 2)
                            .padding(.top, H(21))
                            .padding(.leading, 18)
                    }
                    VStack (alignment: .leading, spacing: 0) {
                        ZStack (alignment: .trailing) {
                            HStack {
                                TextCustom(text: data.houseName, font: MEDIUM, size: 18, lineLimit: 2, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(width: 200, alignment: .leading)
                                Spacer()
                            }
                            HStack (spacing: 0) {
                                TextCustom(text: "\(data.price)", size: 18, lineLimit: 1, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1)).padding(.trailing, 0.5)
                                TextCustom(text: "đ", size: 13, lineLimit: 1, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1)).offset(y: -7)
                            }.frame(width: FULL_W - 246, alignment: .trailing)
                        }.padding(.bottom, H(7))
                        VStack (alignment: .leading, spacing: H(9)) {
                            TextCustom(text: "\(NSLocalizedString(data.isPayFirst ? "parti_payFirstTimes" : "parti_paymentTimes", comment: "")) \(data.payCurrent) | \(data.paySum) \(NSLocalizedString("parti_paytime", comment: ""))", font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1))
                            HStack (alignment: .top, spacing: 6) {
                                ImageCustom(name: "projectParti", w: 14, h: 14)
                                TextCustom(text: "\(NSLocalizedString("filter_project", comment: "")) \(data.projectName)", font: MEDIUM, size: 14, lineLimit: 2, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                            }
                            HStack (alignment: .top, spacing: 6) {
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 14, h: 14)
                                    ImageCustom(name: "locationParti", w: 9.5, h: 12.3)
                                }
                                TextCustom(text: "\(NSLocalizedString("parti_area", comment: "")) \(data.areaName) | \(NSLocalizedString("parti_group", comment: "")) \(data.groupName)", font: MEDIUM, size: 14, lineLimit: 2, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                            }
                        }
                    }.padding(.top, H(12))
                        .padding(.bottom, H(15))
                        .padding(.leading, 16)
                        .padding(.trailing, 10)
                        .background(Color.white)
                        .frame(width: FULL_W - 40)
                }.cornerRadius(4)
                    .shadow(color: .init(#colorLiteral(red: 0.5304766815, green: 0.5304766815, blue: 0.5304766815, alpha: 0.6360800182)), radius: 3)
            }.buttonStyle(ButtonTapScale())
            Button(action: {

            }) {
                ZStack (alignment: .top) {
                    ImageCustom(name: "noti1", w: 35, h: 35)
                    Rectangle()
                        .frame(width: W(8), height: W(8))
                        .cornerRadius(.infinity)
                        .foregroundColor(.init(#colorLiteral(red: 0.9738317132, green: 0.1184293255, blue: 0.1201106384, alpha: 1)))
                        .offset(x: 3, y: 7)
                        .opacity(data.isHaveNoti ? 1 : 0)
                }
            }.buttonStyle(ButtonTapScale())
                .padding(.top, H(18))
                .padding(.trailing, 18)
        }.animation(.easeInOut(duration: 0.1))
    }
}
