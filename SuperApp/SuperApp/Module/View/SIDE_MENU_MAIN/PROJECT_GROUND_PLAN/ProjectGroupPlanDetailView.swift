// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ProjectGroupPlanDetailView: View {
    @Binding var areaName: String
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var selectedFloor: String
    @Binding var selectedApartment: String
    @Binding var selectedStatus: String
    @Binding var selectedType: String
    @Binding var selectedTypeID: Int
    @Binding var selectedFloorID: Int
    @Binding var selectedApartmentID: Int
    @Binding var isRoot: Bool
    @Binding var isShow: Bool
    @Binding var isChangeColorOld: Bool
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    @State var review = ""
    @State var showPopUpDetail = false
    @State var isNextChat = false
    @State var isChangeColor = false
    @State var selectedTypeDetail = ""
    @State var isNext = false

    @State var dataType = [
        typeModel(id: 0, name: "2D"),
        typeModel(id: 1, name: "3D"),
        typeModel(id: 2, name: "AR")
    ]

    @State var dataFloor = [
        floorModel(id: 0, title: "Tầng trệt"),
        floorModel(id: 1, title: "Tầng 2 - 5"),
        floorModel(id: 2, title: "Tầng 6 - 10"),
        floorModel(id: 3, title: "Tầng 11 -15"),
        floorModel(id: 4, title: "Căn hộ A1 - F.1.02"),
        floorModel(id: 5, title: "Căn hộ B2 - F.0.07"),
        floorModel(id: 6, title: "Căn hộ A1 - F.0.05"),
        floorModel(id: 7, title: "Căn hộ B2 - F.0.07"),
    ]

    @State var arrApartment = [
        apartmentModel(id: 0, title: "Căn hộ A1 - F.1.01", status: "saling"),
        apartmentModel(id: 1, title: "Căn hộ A1 - F.1.02", status: "saling"),
        apartmentModel(id: 2, title: "Căn hộ A1 - F.0.05", status: "saled"),
        apartmentModel(id: 3, title: "Căn hộ B2 - F.0.07", status: "reserver"),
        apartmentModel(id: 4, title: "Căn hộ A1 - F.0.05", status: "saling"),
        apartmentModel(id: 5, title: "Căn hộ B2 - F.0.07", status: "saling")
    ]

    var body: some View {
        //MARK:Body
        NavigationView {
            ZStack (alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                    List {
                        VStack(spacing: 0) {
                            ZStack (alignment: .top) {
                                HStack {
                                    ImageCustom(name: "apartment1", w: 110, h: 80)
                                        .shadow(color: .init(#colorLiteral(red: 0.8044495558, green: 0.8044495558, blue: 0.8044495558, alpha: 1)), radius: 3, x: 3, y: 3)
                                    Spacer()
                                }
                                VStack (spacing: H(5)) {
                                    TextCustom(text: "CĂN HỘ KHU A", font: MEDIUM, size: 18, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                        .fixedSize(horizontal: true, vertical: false)
                                        .frame(width: FULL_W)
                                    TextCustom(text: "\(selectedFloor) - \(selectedApartment)", font: REGULAR, size: 16, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .frame(width: FULL_W - W(244))
                                }
                            }.padding(.vertical, H(12))
                            Image("apartment1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: FULL_W, height: H(321))
                                .clipped()
                            HStack (spacing: 0) {
                                TextCustom(text: "\(selectedApartment) [\(selectedType)]", font: MEDIUM, size: 18, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                    .padding(.leading, 30)
                                Spacer()
                                Button(action: {
                                    self.showPopUpDetail = true
                                    self.isChangeColor = true
                                }) {
                                    ZStack (alignment: .trailing) {
                                        ImageCustom(name: "downmenu", w: 14, h: 14)
                                    }.frame(width: H(52), height: H(52), alignment: .trailing)
                                }.buttonStyle(ButtonTapScale())
                                    .background(Color.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                                    .animation(.easeInOut(duration: 0.1))
                                    .padding(.trailing, 26)
                            }.frame(width: FULL_W, height: H(52))
                                .background(Color.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                                .padding(.top, H(17))
                            HStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: W(6), height: W(6))
                                    .foregroundColor(.init(#colorLiteral(red: 0.6038560271, green: 0.6039603949, blue: 0.6038413644, alpha: 1)))
                                    .clipShape(Circle())
                                    .padding(.leading, 30)
                                TextCustom(text: "\(NSLocalizedString("project_ground_plan_status", comment: "")) ", font: ITALIC, size: 16, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                                    .padding(.leading, 9)
                                TextCustom(text: NSLocalizedString(
                                    selectedStatus == "saling" ? "project_ground_plan_saling":
                                        selectedStatus == "saled" ? "project_ground_plan_saled" : "project_ground_plan_sale_pending"
                                    , comment: ""), font: MEDIUM, size: 16, color:
                                        selectedStatus == "saling" ? #colorLiteral(red: 0.3190362453, green: 0.7693782449, blue: 0.442176193, alpha: 1):
                                        selectedStatus == "saled" ? #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1): #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                                ).padding(.leading, 2)
                                Spacer()
                            }.padding(.top, H(14))
                            ProjectGroundDetailCustom()
                        }.listRowInsets(EdgeInsets())
                            .padding(.bottom, H(20))
                    }.onAppear {
                        UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().showsVerticalScrollIndicator = false
                    }.edgesIgnoringSafeArea(.bottom)
                }.padding(.top, H(64))
                VStack {
                    Spacer()
                    ZStack (alignment: .top) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 10, height: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 89: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 89: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 89 : 104)
                            )
                        Button(action: {
                            self.isNext = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(4)
                                    .frame(width: FULL_W - 40, height: H(49))
                                    .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                TextCustom(text: NSLocalizedString("project_ground_plan_budget_estimates", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .offset(y: H(20))
                    }.frame(width: FULL_W, height: H(
                        FULL_H == H_SE && FULL_W == W_SE ? 89: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 89: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 89 : 104)
                    ).background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                        .cornerRadius(0)
                        .shadow(color: .init(#colorLiteral(red: 0.5813372462, green: 0.5813372462, blue: 0.5813372462, alpha: 0.2016802226)), radius: 3, y: -3)
                }.edgesIgnoringSafeArea(.bottom)
                Rectangle()
                    .opacity(showPopUpDetail ? 0.75 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.showPopUpDetail = false
                        self.isChangeColor = false
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: $isChangeColor,
                    isOpenSideMenu: $isOpenSideMenu,
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "projectDetailHome_Plan",
                    title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName) | \(areaName)",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                        UITableView.appearance().showsVerticalScrollIndicator = true
                        self.isShow = false
                        self.isChangeColorOld = false
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: {
                        callPhone()
                        UIApplication.shared.endEditing()
                    },
                    textFunc: {
                        UIApplication.shared.endEditing()
                        self.isNextChat = true
                        self.isSideMenuAppear = false
                    },
                    isCallAndTextBlack: true
                )
                ShowApartment(
                    isChangeColor: $isChangeColor,
                    isShow: $showPopUpDetail,
                    selectedType: $selectedType,
                    selectedApartment: $selectedApartment,
                    selectedTypeID: $selectedTypeID,
                    selectedApartmentID: $selectedApartmentID,
                    dataType: $dataType,
                    dataApartment: $arrApartment,
                    selectedStatus: $selectedStatus
                )
                NavigationLink(destination:
                        ChatView(
                            isNextOld: $isNextChat,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData,
                            isHaveSideMenu: false
                        ), isActive: $isNextChat) {
                    EmptyView()
                }
                NavigationLink(destination:
                        SalePolicyView(
                            isNextOld: $isNext,
                            isRoot: $isRoot,
                            projectURL: $projectURL
                        ),
                    isActive: $isNext) {
                    EmptyView()
                }
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.background(Color.white)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct ProjectGroundDetailCustom: View {
    var body: some View {
        VStack (spacing: 0) {
            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    TextCustom(text: NSLocalizedString("project_ground_plan_main_inform", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.5188521147, green: 0.3111524284, blue: 0.7261000872, alpha: 1))
                    Spacer()
                }.padding(.bottom, H(11))
                DetailGroundLine(label: "project_ground_plan_expect_sale_price", value: "25", milPerM2: true)
                DetailGroundLine(label: "project_ground_plan_using_area", value: "110")
                DetailGroundLine(label: "project_ground_plan_total_area", value: "120")
            }.padding(.horizontal, 30)
                .padding(.top, H(12))
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371340871, alpha: 1)))
                .padding(.top, H(4))
            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    TextCustom(text: NSLocalizedString("project_ground_plan_inform_detail", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.5188521147, green: 0.3111524284, blue: 0.7261000872, alpha: 1))
                    Spacer()
                }.padding(.bottom, H(11))
                DetailGroundLine(label: "project_ground_plan_living_room", value: "36")
                DetailGroundLine(label: "project_ground_plan_bedroom1", value: "16")
                DetailGroundLine(label: "project_ground_plan_bedroom2", value: "12")
                DetailGroundLine(label: "project_ground_plan_rest_room", value: "6")
                DetailGroundLine(label: "project_ground_plan_balcony", value: "3")
                DetailGroundLine(label: "project_ground_plan_direction_house", value: "Đông Nam", isM2: false)
            }.padding(.horizontal, 30)
                .padding(.top, H(14))
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371340871, alpha: 1)))
                .padding(.top, H(4))
            TextCustom(text: "\(NSLocalizedString("project_ground_plan_total_money", comment: "")) : 3.0 (tỷ vnd)", font: MEDIUM, size: 20, color: #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1))
                .padding(.vertical, H(13))
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371340871, alpha: 1)))
                .padding(.bottom, H(
                    FULL_H == H_SE && FULL_W == W_SE ? 94: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 94: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 94 : 104)
                )
        }
    }
}

struct DetailGroundLine: View {
    @State var label = ""
    @State var value = ""
    @State var isM2 = true
    @State var milPerM2 = false

    var body: some View {
        HStack (spacing: 0) {
            Rectangle()
                .frame(width: W(6), height: W(6))
                .foregroundColor(.init(#colorLiteral(red: 0.6038560271, green: 0.6039603949, blue: 0.6038413644, alpha: 1)))
                .clipShape(Circle())
            TextCustom(text: NSLocalizedString(label, comment: ""), font: ITALIC, size: 16, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                .fixedSize(horizontal: true, vertical: false)
                .padding(.leading, 9)
            TextCustom(text: " : ", font: ITALIC, size: 16, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
            TextCustom(text: "\(value) ", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
            if milPerM2 || isM2 {
                TextCustom(text: milPerM2 ? "(triệu/m" : "(m", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                TextCustom(text: "2", font: MEDIUM, size: 9, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)).offset(y: H(-3))
                TextCustom(text: ")", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
            }
        }.padding(.bottom, H(10))
    }
}
