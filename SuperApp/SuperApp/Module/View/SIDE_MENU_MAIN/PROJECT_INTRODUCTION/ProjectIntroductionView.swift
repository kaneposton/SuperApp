// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct InfoProjectType: Identifiable, Hashable {
    var id = UUID()
    var scale: Int
    var river: Int
    var education: Int
    var parkTopic: Int
    var water: Int
    var sum: Int
}

struct ProjectIntroductionView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var isNextChat = false

    @State var arrInfoProject = InfoProjectType(
        scale: 0,
        river: 0,
        education: 0,
        parkTopic: 0,
        water: 0,
        sum: 0
    )

    @State var isHasData = false
    @State var disposables = Set<AnyCancellable>()
    @ObservedObject var introductionViewModel = IntroductionViewModel()

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                ZStack {
                    if projectURL.isEmpty {
                        Image("default_large")
                            .resizable()
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                            WebImage(url: URL(string: projectURL))
                                .resizable()
                        }
                    }
                }.aspectRatio(contentMode: .fill)
                    .frame(width: FULL_W)
                    .edgesIgnoringSafeArea([.top, .bottom])
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: H(100))
                if isHasData {
                    VStack {
                        Spacer()
                        ZStack (alignment: .trailing) {
                            HStack {
                                IntroItemVertical(arrInfoProject: $arrInfoProject, index: 0)
                                    .frame(width: FULL_W / 2)
                                    .offset(x: 10)
                                Spacer()
                            }
                            IntroItemVertical(arrInfoProject: $arrInfoProject, index: 3)
                                .frame(width: FULL_W / 2)
                                .offset(x: -10)
                        }
                    }.padding(.bottom, H(94))
                }
                Rectangle()
                    .opacity(isOpenSideMenu ? 0.75 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.closeSideMenu()
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: $isOpenSideMenu,
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "projectDetailHome_Info",
                    title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                        self.closeSideMenu()
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
                        self.closeSideMenu()
                        self.isNextChat = true
                        self.isSideMenuAppear = false
                    },
                    isCallAndTextWhite: true
                )
                NavigationLink(destination:
                        ChatView(
                            isNextOld: $isNextChat,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNextChat) {
                    EmptyView()
                }
            }.onAppear {
                self.introductionViewModel.fetchDataIntroduction(projectId: self.project_id)
                self.introductionViewModel.vldIntroductionList.sink { rs in
                    self.arrInfoProject = InfoProjectType(
                        scale: self.introductionViewModel.introductionList?.total_area_square ?? 0,
                        river: self.introductionViewModel.introductionList?.area_river ?? 0,
                        education: self.introductionViewModel.introductionList?.education_and_health ?? 0,
                        parkTopic: self.introductionViewModel.introductionList?.theme_parks ?? 0,
                        water: self.introductionViewModel.introductionList?.area_water_surface ?? 0,
                        sum: self.introductionViewModel.introductionList?.common_utility ?? 0)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.isHasData = true
                    }
                }.store(in: &self.disposables)
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct IntroItemVertical: View {
    @Binding var arrInfoProject: InfoProjectType
    @State var index = 0

    var body: some View {
        VStack (spacing: H(45)) {
            IntroItem(arrInfoProject: $arrInfoProject, index: index)
            IntroItem(arrInfoProject: $arrInfoProject, index: index + 1)
            IntroItem(arrInfoProject: $arrInfoProject, index: index + 2)
        }
    }
}

struct IntroItem: View {
    @Binding var arrInfoProject: InfoProjectType
    @State var index = 0

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ImageCustom(name:
                        index == 0 ? "projectScale":
                        index == 1 ? "educationGray":
                        index == 2 ? "water1Gray":
                        index == 3 ? "water":
                        index == 4 ? "parkGray" : "commonGround"
                    , w:
                        index == 0 ? 52:
                        index == 1 ? 51:
                        index == 2 ? 52:
                        index == 3 ? 42:
                        index == 4 ? 41 : 34
                    , h:
                        index == 0 ? 41:
                        index == 1 ? 51:
                        index == 2 ? 44:
                        index == 3 ? 28:
                        index == 4 ? 41 : 42
                )
            }.frame(height: H(51))
            TextCustom(text:
                    index == 0 ? "\(Utils.formatHighNumber(Double(arrInfoProject.scale)))(ha)":
                    index == 1 ? "\(Utils.formatHighNumber(Double(arrInfoProject.education)))(ha)":
                    index == 2 ? "\(Utils.formatHighNumber(Double(arrInfoProject.water)))(ha)":
                    index == 3 ? "\(Utils.formatHighNumber(Double(arrInfoProject.river)))(ha)":
                    index == 4 ? "\(Utils.formatHighNumber(Double(arrInfoProject.parkTopic)))" : "\(Utils.formatHighNumber(Double(arrInfoProject.sum)))%",
                font: MEDIUM, size: 22, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                .padding(.top, H(6.2))
            TextCustom(text: NSLocalizedString(
                index == 0 ? "project_introduction_project_scale":
                    index == 1 ? "project_introduction_education_medical":
                    index == 2 ? "project_introduction_water_surface_area":
                    index == 3 ? "project_introduction_river_way":
                    index == 4 ? "project_introduction_topic_park" : "project_introduction_common_utility",
                comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                .padding(.top, H(6.5))
        }
    }
}

