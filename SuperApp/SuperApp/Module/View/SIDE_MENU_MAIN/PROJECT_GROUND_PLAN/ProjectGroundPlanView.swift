// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct apartmentModel: Codable, Hashable {
    var id: Int
    var title: String
    var status: String
}

struct typeModel {
    var id: Int
    var name: String
}

struct floorModel {
    var id: Int
    var title: String
}

struct ProjectGroundPlanView: View {
    @Binding var areaName: String
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var isRoot: Bool
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var partName = ""
    @State var isShow = false
    @State var selectedApartmentID = 0
    @State var selectedApartment = ""
    @State var selectedStatus = ""
    @State var isNext = false
    @State var isNextChat = false
    @State var isChangeColor = false
    @State var selectedType = ""
    @State var selectedFloor = ""
    @State var selectedTypeID = 0
    @State var selectedFloorID = 0

    @State var arrApartment = [
        apartmentModel(id: 0, title: "Căn hộ A1 - F.1.01", status: "saling"),
        apartmentModel(id: 1, title: "Căn hộ A1 - F.1.02", status: "saling"),
        apartmentModel(id: 2, title: "Căn hộ A1 - F.0.05", status: "saled"),
        apartmentModel(id: 3, title: "Căn hộ B2 - F.0.07", status: "reserver"),
        apartmentModel(id: 4, title: "Căn hộ A1 - F.0.05", status: "saling"),
        apartmentModel(id: 5, title: "Căn hộ B2 - F.0.07", status: "saling")
    ]

    @State var dataType = [
        typeModel(id: 0, name: "2D"),
        typeModel(id: 1, name: "3D"),
        typeModel(id: 2, name: "AR")
    ]

    @State var dataFloor = [
        floorModel(id: 0, title: "Tầng trệt"),
        floorModel(id: 1, title: "Tầng 2 - 5"),
        floorModel(id: 2, title: "Tầng 6 - 10"),
        floorModel(id: 3, title: "Tầng 11 -15")
    ]

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                        .padding(.top, H(64))
                    ZStack (alignment: .top) {
                        HStack {
                            ImageCustom(name: "RoomSelectedSmall", w: 110, h: 80)
                                .shadow(color: .init(#colorLiteral(red: 0.8044495558, green: 0.8044495558, blue: 0.8044495558, alpha: 1)), radius: 3, x: 3, y: 3)
                            Spacer()
                        }
                        VStack (spacing: H(5)) {
                            TextCustom(text: "CĂN HỘ KHU A", font: MEDIUM, size: 18, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(width: FULL_W)
                            TextCustom(text: selectedFloor, font: REGULAR, size: 16, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .frame(width: FULL_W - W(244))
                        }
                    }.padding(.vertical, H(12))
                    Image("RoomSelected")
                        .resizable()
                        .scaledToFill()
                        .frame(width: FULL_W, height: H(321))
                        .clipped()
                    HStack(spacing: 0) {
                        Spacer()
                        HStack(spacing: 10) {
                            ImageCustom(name: "saling", w: 12, h: 13)
                            TextCustom(text: "\(NSLocalizedString("project_ground_plan_saling", comment: "")): 4", font: REGULAR, size: 14, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        }
                        Rectangle()
                            .frame(width: W(0.5), height: H(14))
                            .foregroundColor(.init(#colorLiteral(red: 0.6548312902, green: 0.6549437642, blue: 0.654815495, alpha: 1)))
                            .padding(.horizontal, 26)
                        HStack(spacing: 10) {
                            ImageCustom(name: "saled", w: 12, h: 13)
                            TextCustom(text: "\(NSLocalizedString("project_ground_plan_saled", comment: "")): 1", font: REGULAR, size: 14, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        }
                        Rectangle()
                            .frame(width: W(0.5), height: H(14))
                            .foregroundColor(.init(#colorLiteral(red: 0.6548312902, green: 0.6549437642, blue: 0.654815495, alpha: 1)))
                            .padding(.horizontal, 26)
                        HStack(spacing: 10) {
                            ImageCustom(name: "reserver", w: 16, h: 16)
                            TextCustom(text: "\(NSLocalizedString("project_ground_plan_sale_pending", comment: "")): 1", font: REGULAR, size: 14, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        }
                        Spacer()
                    }.padding(.top, H(16))
                    HStack (spacing: 0) {
                        TextCustom(text: "\(selectedFloor) [\(selectedType)]", font: MEDIUM, size: 18, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                            .padding(.leading, 30)
                            .opacity(!selectedFloor.isEmpty && !selectedType.isEmpty ? 1 : 0)
                        Spacer()
                        Button(action: {
                            self.isShow = true
                            self.isChangeColor = true
                        }) {
                            HStack (spacing: 0) {
                                ZStack {
                                    TextCustom(text: "\(arrApartment.count)", font: MEDIUM, size: 14, color: #colorLiteral(red: 0.4243853688, green: 0.1840572953, blue: 0.6637942195, alpha: 1))
                                }.frame(width: W(
                                    FULL_H == H_SE && FULL_W == W_SE ? 30: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 30: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 30: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 36: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 36 : 0) // iPhone 11 Pro
                                    , height: W(
                                        FULL_H == H_SE && FULL_W == W_SE ? 30: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? 30: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 30: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? 36: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 36 : 0) // iPhone 11 Pro
                                ).background(Color.init(#colorLiteral(red: 0.9108585715, green: 0.8677796721, blue: 0.9523963332, alpha: 1)))
                                    .padding(.trailing, 25)
                                ImageCustom(name: "downmenu", w: 14, h: 14)
                                    .padding(.trailing, 26)
                            }.frame(height: H(52))
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .background(Color.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                    }.frame(width: FULL_W, height: H(52))
                        .background(Color.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                        .padding(.top, H(17))
                    List {
                        VStack (spacing: 0) {
                            ForEach(arrApartment, id: \.id) { apartment in
                                apartmentTabb(
                                    selectedApartmentID: self.$selectedApartmentID,
                                    selectedApartment: self.$selectedApartment,
                                    selectedStatus: self.$selectedStatus,
                                    apartment: apartment,
                                    isNext: self.$isNext
                                )
                            }
                        }.listRowInsets(EdgeInsets())
                    }.onAppear {
                        UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().showsVerticalScrollIndicator = true
                    }
                }
                Rectangle()
                    .opacity(isShow || isOpenSideMenu ? 0.75 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShow = false
                        self.isChangeColor = false
                }
                ShowProjectGroundPlanPopUpView(
                    isChangeColor: $isChangeColor,
                    isShow: $isShow,
                    selectedType: $selectedType,
                    selectedFloor: $selectedFloor,
                    selectedTypeID: $selectedTypeID,
                    selectedFloorID: $selectedFloorID,
                    dataType: $dataType,
                    dataFloor: $dataFloor
                )
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
                        self.isSideMenuAppear = true
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
                        ProjectGroupPlanDetailView(
                            areaName: $areaName,
                            isNextOld: $isNext,
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectName: $projectName,
                            selectedFloor: $selectedFloor,
                            selectedApartment: $selectedApartment,
                            selectedStatus: $selectedStatus,
                            selectedType: $selectedType,
                            selectedTypeID: $selectedTypeID,
                            selectedFloorID: $selectedFloorID,
                            selectedApartmentID: $selectedApartmentID,
                            isRoot: $isRoot,
                            isShow: $isShow,
                            isChangeColorOld: $isChangeColor,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.onAppear {
                self.selectedType = self.dataType[self.selectedTypeID].name
                self.selectedFloor = self.dataFloor[self.selectedFloorID].title
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

struct apartmentTabb: View {
    @Binding var selectedApartmentID: Int
    @Binding var selectedApartment: String
    @Binding var selectedStatus: String
    @State var apartment: apartmentModel
    @Binding var isNext: Bool

    var body: some View {
        VStack (spacing: 0) {
            Button(action: {
                if self.selectedApartmentID == self.apartment.id {
                    self.selectedApartmentID = self.apartment.id
                    self.selectedApartment = self.apartment.title
                    self.selectedStatus = self.apartment.status
                    self.isNext = true
                } else {
                    self.selectedApartmentID = self.apartment.id
                    self.selectedApartment = ""
                }
            }) {
                ZStack (alignment: .leading) {
                    HStack {
                        ZStack {
                            ImageCustom(name: "EmptyPicture", w: 16, h: 16)
                            ImageCustom(name: apartment.status.isEmpty ? "EmptyPicture" : apartment.status,
                                w: apartment.status == "saling" ? 10:
                                    apartment.status == "saled" ? 12 : 16,
                                h: apartment.status == "reserver" ? 16 : 13)
                        }
                        Spacer()
                    }.padding(.leading, 36)
                    TextCustom(text: apartment.title, font: MEDIUM, size: 16, color: selectedApartmentID == apartment.id ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        .padding(.leading, 72)
                }.background(Color.white)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .padding(.vertical, H(16))
                .background(Color.white)
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371340871, alpha: 1)))
        }
    }
}
