// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI
import RxSwift
import Combine

struct ListDataView: View {
    @Binding var isTapSearch: Bool
    @Binding var projectURL: String
    @Binding var project_id: Int
    @Binding var projectName: String
    @Binding var isNext: Bool
    @Binding var data: [HomeProjectListModel]
    @Binding var strSearch: String
    @Binding var setting_type: [Int]
    @Binding var province_id: [Int]
    @Binding var district_id: [Int]
    @Binding var project_status: [Int]
    @State var isSell = false

    @State var disposables = Set<AnyCancellable>()
    @State var isHasDataLocal = false
    @State var isHasDataHighLightLocal = false
    @State var dataLocalFilter = [HomeProjectListModel]()
    @ObservedObject var dataFilterViewModel = HomeViewModel()
    @ObservedObject var dataHighLightViewModel = HomeViewModel()
    @State var dataSource = false

    @State var isShowing = false
    @State var isFromDiscover = false
    @State var provinceFromDiscover = -1

    var body: some View {
        VStack {
            List {
                VStack (alignment: .leading, spacing: 0) {
                    if dataSource {
                        VStack (spacing: H(12)) {
                            if data.count > 0 {
                                if strSearch.isEmpty {
                                    ForEach(data, id: \.self) { model in
                                        ListDataContentView(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNext: self.$isNext, data: model, isSell: self.isSell)
                                    }
                                } else if data.firstIndex(where: ({ ($0.project_name?.localizedStandardContains(strSearch))! })) == nil {
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                        Spacer()
                                    }.padding(.top, H(100))
                                } else {
                                    ForEach(data.filter({ ($0.project_name?.localizedStandardContains(strSearch))! }), id: \.self) { model in
                                        ListDataContentView(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNext: self.$isNext, data: model, isSell: self.isSell)
                                    }
                                }
                            } else {
                                HStack {
                                    Spacer()
                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                    Spacer()
                                }.padding(.top, H(100))
                            }
                        }
                    }
                    else if isHasDataLocal {
                        if dataLocalFilter.count > 0 {
                            VStack (alignment: .leading, spacing: H(12)) {
                                if strSearch.isEmpty {
                                    ForEach(dataLocalFilter, id: \.self) { model in
                                        ListDataContentView(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNext: self.$isNext, data: model, isSell: self.isSell)
                                    }
                                } else if dataLocalFilter.firstIndex(where: ({ ($0.project_name?.localizedStandardContains(strSearch))! })) == nil {
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                        Spacer()
                                    }.padding(.top, H(100))
                                } else {
                                    ForEach(dataLocalFilter.filter({ ($0.project_name?.localizedStandardContains(strSearch))! }), id: \.self) { model in
                                        ListDataContentView(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNext: self.$isNext, data: model, isSell: self.isSell)
                                    }
                                }
                            }
                        } else
                        if isHasDataHighLightLocal {
                            HStack {
                                Spacer()
                                ImageCustom(name: "NoResult", w: 219, h: 150)
                                Spacer()
                            }.padding(.bottom, H(36))
                            HStack {
                                TextCustom(text: NSLocalizedString("list_highlight_project", comment: ""), size: 24, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                    .padding(.leading, 20)
                                Spacer()
                            }.padding(.bottom, H(16))
                            if data.count == 0 {
                                HStack {
                                    Spacer()
                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                    Spacer()
                                }.padding(.top, H(11))
                            }
                            else {
                                VStack (spacing: H(12)) {
                                    ForEach(data, id: \.self) { model in
                                        ListDataContentView(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNext: self.$isNext, data: model, isSell: self.isSell)
                                    }
                                }
                            }
                        }
                    }
                }.listRowInsets(EdgeInsets())
                    .padding(.bottom, H(30))
                    .background(Color.white)
            }.resignKeyboardOnDragGesture()
                .frame(width: FULL_W)
                .background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if !self.dataSource {
                                self.isHasDataLocal = false
                                self.isHasDataHighLightLocal = false

                                // MARK: DATA FILTER
                                self.dataFilterViewModel.fetchDataProjectList(
                                    settingType: self.isFromDiscover ? [0] : self.setting_type,
                                    provinceId: self.isFromDiscover ? [self.provinceFromDiscover] : self.province_id,
                                    projectStatus: self.isFromDiscover ? [0, 1] : self.project_status,
                                    language: VIETNAM,
                                    districtId: self.isFromDiscover ? [] : self.district_id
                                )

                                // MARK: DATA HIGHLIGHT
                                self.dataHighLightViewModel.fetchDataProjectList(
                                    settingType: [0],
                                    provinceId: [],
                                    projectStatus: [0, 1],
                                    language: VIETNAM,
                                    districtId: []
                                )

                                // MARK: DATA HIGHLIGHT
                                self.dataHighLightViewModel.vldFilterProjectList.sink { rs in
                                    self.data = self.dataHighLightViewModel.homeProjectList ?? []
                                    self.isHasDataHighLightLocal = true
                                    self.isShowing = false
                                }.store(in: &self.disposables)

                                // MARK: DATA FILTER
                                self.dataFilterViewModel.vldFilterProjectList.sink { rs in
                                    self.dataLocalFilter = self.dataFilterViewModel.homeProjectList ?? []
                                    self.isHasDataLocal = true
                                    self.isShowing = false
                                }.store(in: &self.disposables)
                            } else {
                                self.dataSource = false

                                // MARK: DATA HIGHLIGHT
                                self.dataHighLightViewModel.fetchDataProjectList(
                                    settingType: [0],
                                    provinceId: [],
                                    projectStatus: [0, 1],
                                    language: VIETNAM,
                                    districtId: []
                                )

                                // MARK: DATA HIGHLIGHT
                                self.dataHighLightViewModel.vldFilterProjectList.sink { rs in
                                    self.data = self.dataHighLightViewModel.homeProjectList ?? []
                                    self.dataSource = true
                                    self.isShowing = false
                                }.store(in: &self.disposables)
                            }
                        }
                }, isShowing: self.$isShowing))
            Spacer()
        }.animation(isTapSearch ? .easeInOut(duration: 0.4) : .none)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                if !self.dataSource {
                    // MARK: DATA FILTER
                    self.dataFilterViewModel.fetchDataProjectList(
                        settingType: self.isFromDiscover ? [0] : self.setting_type,
                        provinceId: self.isFromDiscover ? [self.provinceFromDiscover] : self.province_id,
                        projectStatus: self.isFromDiscover ? [0, 1] : self.project_status,
                        language: VIETNAM,
                        districtId: self.isFromDiscover ? [] : self.district_id
                    )

                    // MARK: DATA HIGHLIGHT
                    self.dataHighLightViewModel.fetchDataProjectList(
                        settingType: [0],
                        provinceId: [],
                        projectStatus: [0, 1],
                        language: VIETNAM,
                        districtId: []
                    )

                    // MARK: DATA HIGHLIGHT
                    self.dataHighLightViewModel.vldFilterProjectList.sink { rs in
                        self.data = self.dataHighLightViewModel.homeProjectList ?? []
                        self.isHasDataHighLightLocal = true
                    }.store(in: &self.disposables)

                    // MARK: DATA FILTER
                    self.dataFilterViewModel.vldFilterProjectList.sink { rs in
                        self.dataLocalFilter = self.dataFilterViewModel.homeProjectList ?? []
                        self.isHasDataLocal = true
                    }.store(in: &self.disposables)
                }
                UITableViewCell.appearance().backgroundColor = .white
                UITableView.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
        }
    }
}

struct ListDataContentView: View {
    @Binding var projectURL: String
    @Binding var project_id: Int
    @Binding var projectName: String
    @Binding var isNext: Bool

    @State var data: HomeProjectListModel
    @State var isSell = false
    @State var commaAddress = ""
    @State var commaDistrict = ""

    var body: some View {
        Button(action: {
            self.project_id = self.data.project_id ?? 0
            self.projectURL = self.data.project_avatar_url ?? ""
            self.projectName = self.data.project_name ?? ""
            self.isNext = true
        }) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    ZStack {
                        if (data.project_avatar_url ?? "").isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: data.project_avatar_url ?? ""))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: FULL_W, height: H(234))
                        .clipped()
                    ZStack (alignment: .leading) {
                        ImageCustom(name: data.is_sell ?? false ? "greenHomeFlag" : "orangeHomeFlag", w: 75, h: 27)
                            .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921)), radius: 2, y: 2)
                        TextCustom(text: NSLocalizedString(data.is_sell ?? false ? "search_isSell" : "search_isSellSoon", comment: ""), font: REGULAR, size: 12, color: .white)
                            .padding(.leading, 8.5)
                    }.padding(.top, 18)
                }
                HStack {
                    TextCustom(text: data.project_name ?? "", size: 18, lineLimit: 1)
                        .frame(width: FULL_W - 34, alignment: .leading)
                    Spacer()
                }.padding(.top, H(14))
                    .padding(.bottom, H(6))
                    .padding(.horizontal, 17)
                HStack(spacing: 5) {
                    ImageCustom(name: "locationWhite", w: 16, h: 16)
                    TextCustom(text: "\((data.address ?? ""))\(commaAddress)\((data.district_name ?? ""))\(commaDistrict)\((data.province_name ?? ""))", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2509803922, green: 0.2941176471, blue: 0.4117647059, alpha: 1))
                }.padding(.bottom, H(4))
                    .padding(.horizontal, 17)
            }
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
            .onAppear {
                self.commaAddress = (self.data.address ?? "").isEmpty ? "" : (self.data.district_name ?? "").isEmpty && (self.data.province_name ?? "").isEmpty ? "" : ", "
                self.commaDistrict = (self.data.district_name ?? "").isEmpty ? "" : (self.data.province_name ?? "").isEmpty ? "" : ", "
        }
    }
}
