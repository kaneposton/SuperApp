// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct ProjectContactView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var isNextChat = false

    @State var isHasDataDeveloper = false
    @State var isHasDataTrading = false
    @State var disposables = Set<AnyCancellable>()
    @ObservedObject var contacViewModel = ContactViewModel()
    @State var dataLocalContactTrading = [ContactTradingModel]()
    @State var dataLocalContactDeveloper = ContactDeveloperModel(logo_url: "", project_address: "", hotline: "", fax: "")
    @State var isShowData = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if isHasDataDeveloper && isHasDataTrading {
                    Text("").onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.isShowData = true
                        }
                    }
                }
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
                        .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.3882352941, green: 0.01568627451, blue: 0.2392156863, alpha: 0.8489672517)), .init(#colorLiteral(red: 0.03529411765, green: 0.01568627451, blue: 0.5607843137, alpha: 0.8453285531))]), startPoint: .bottom, endPoint: .top))
                        .edgesIgnoringSafeArea(.all)
                }
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 0) {
                        if isShowData {
                            TextCustom(text: NSLocalizedString("project_contact_developer", comment: ""), size: 20, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                                .padding(.bottom, H(17))
                                .padding(.top, H(21))
                            ZStack {
                                Rectangle().foregroundColor(.clear)
                                WebImage(url: URL(string: "\(dataLocalContactDeveloper.logo_url ?? "")"))
                                    .resizable()
                            }.frame(width: W(178), height: W(76))
                                .background(Color.clear)
                                .padding(.bottom, H(35))
                            TextCustom(text: NSLocalizedString("project_contact_address", comment: ""), size: 20, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                                .padding(.bottom, H(10))
                            TextCustom(text: dataLocalContactDeveloper.project_address ?? "", font: ITALIC, size: 16, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                                .padding(.bottom, H(18))
                            ProjectContactCustomContact(title: "project_contact_hotline", number: dataLocalContactDeveloper.hotline ?? "")
                                .padding(.bottom, H(16))
                            ProjectContactCustomContact(title: "project_contact_fax", number: dataLocalContactDeveloper.fax ?? "")
                                .padding(.bottom, H(30))
                            TextCustom(text: NSLocalizedString("project_contact_trading_floor", comment: ""), size: 20, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                                .padding(.bottom, H(24))
                            VStack (spacing: H(25)) {
                                ForEach(dataLocalContactTrading, id: \.self) { model in
                                    ProjectContactCustom(title: model.name!, detail: model.address!)
                                }
                            }
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                        }
                    }.animation(.easeInOut(duration: 0.2))
                }.padding(.top, H(64))
                Rectangle()
                    .opacity(isOpenSideMenu ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.closeSideMenu()
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "contact_title",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                        self.closeSideMenu()
                        self.isSideMenuAppear = false
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
                self.contacViewModel.fetchDataContact()
                self.contacViewModel.vldContactTradingModel.sink { rs in
                    self.dataLocalContactTrading = self.contacViewModel.contactTradingModel ?? []
                    self.isHasDataTrading = true
                }.store(in: &self.disposables)

                self.contacViewModel.vldContactDeveloperModel.sink { rs in
                    self.dataLocalContactDeveloper = self.contacViewModel.contactDeveloperModel ?? ContactDeveloperModel(
                        logo_url: "",
                        project_address: "",
                        hotline: "",
                        fax: "")
                    self.isHasDataDeveloper = true
                }.store(in: &self.disposables)
            }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ProjectContactCustomContact: View {
    @State var title = ""
    @State var number = ""

    var body: some View {
        VStack (spacing: 0) {
            TextCustom(text: NSLocalizedString(title, comment: ""), font: MEDIUM, size: 14, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                .fixedSize(horizontal: true, vertical: false)
            TextCustom(text: number, size: 20, color: #colorLiteral(red: 0.3176470588, green: 0.768627451, blue: 0.4431372549, alpha: 1))
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}

struct ProjectContactCustom: View {
    @State var title = ""
    @State var detail = ""

    var body: some View {
        VStack (spacing: H(2)) {
            TextCustom(text: title, font: MEDIUM, size: 16, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
            TextCustom(text: detail, font: ITALIC, size: 14, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1))
        }
    }
}
