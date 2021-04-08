// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import RxSwift
import SDWebImageSwiftUI

struct saleArrType: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var label: String
    var index: CGFloat
}

struct SalesView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var viewStatePicture = CGSize.zero
    @State var saveWidth: CGFloat = 0
    @State var spaceImage: CGFloat = FULL_W - 65
    @State var pictureIndex: CGFloat = 0
    @State var isNextChat = false
    @State var isHasData = false
    @State var disposes = Set<AnyCancellable>()
    @ObservedObject var projectSalesViewModel = ProjectSalesViewModel()
    @State var projectSales = [SalesModel]()

    @State var saleArr = [
        saleArrType(imageName: "whiteHouseNearBodyOfWater1438834", label: "Khu đô thị Valencia", index: 0),
        saleArrType(imageName: "whiteHouseNearBodyOfWater1438834", label: "Khu đô thị Valencia", index: 1),
        saleArrType(imageName: "whiteHouseNearBodyOfWater1438834", label: "Khu đô thị Valencia", index: 2)
    ]

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
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6337489298)), .init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))]), startPoint: .bottom, endPoint: .top))
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: H(100))
                VStack (spacing: 0) {
                    TextCustom(text: NSLocalizedString("sale_intro", comment: ""), font: MEDIUM, size: 14, color: .white)
                        .padding(.horizontal, 69)
                        .multilineTextAlignment(.center)
                        .padding(.top, H(86))
                        .padding(.bottom, H(60))
                    if isHasData {
                        if self.projectSales.count != 0 {
                            ZStack {
                                ForEach(self.projectSales.enumeratedArray(), id: \.element) { index, data in
                                    ImageScrollSales(
                                        data: data,
                                        pictureIndex: self.$pictureIndex,
                                        index: index
                                    )
                                }
                            }.offset(x: self.viewStatePicture.width)
                                .animation(.easeInOut(duration: 0.2))
                                .gesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            self.viewStatePicture.width = value.translation.width + self.saveWidth
                                        })
                                        .onEnded({ value in
                                            // MARK: SWIPE <-
                                            if self.viewStatePicture.width < (-self.spaceImage * self.pictureIndex) {
                                                if self.pictureIndex < CGFloat(integerLiteral: self.projectSales.count - 1) {
                                                    self.viewStatePicture.width = (-self.spaceImage * self.pictureIndex) - self.spaceImage
                                                    self.pictureIndex += 1
                                                } else {
                                                    self.viewStatePicture.width = (-self.spaceImage * self.pictureIndex)
                                                }
                                            }

                                            // MARK: SWIPE ->
                                            if self.viewStatePicture.width > (0 + (-self.spaceImage * self.pictureIndex)) {
                                                if self.pictureIndex > 0 {
                                                    self.viewStatePicture.width = (-self.spaceImage * self.pictureIndex) + self.spaceImage
                                                    self.pictureIndex -= 1
                                                } else {
                                                    self.viewStatePicture.width = (-self.spaceImage * self.pictureIndex)
                                                }
                                            }
                                            self.saveWidth = self.viewStatePicture.width
                                        })
                                )
                        } else {
                            ZStack (alignment: .bottom) {
                                Image("default_large")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: FULL_W - 72, height:
                                            FULL_H == H_SE && FULL_W == W_SE ? FULL_H - 220: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? FULL_H - 240: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? FULL_H - 260: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? FULL_H - 350: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? FULL_H - 350: 0 // iPhone 11 Pro
                                    ).clipped()
                                    .cornerRadius(7)
                                    .shadow(color: .init(#colorLiteral(red: 0.3320114213, green: 0.3320114213, blue: 0.3320114213, alpha: 0.613418794)), radius: 5)
                                TextCustom(text: "", font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                                    .frame(width: FULL_W - 72, height: H(40))
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    ).cornerRadius(7, corners: [.bottomLeft, .bottomRight])
                            }.offset(x: self.viewStatePicture.width)
                                .animation(.easeInOut(duration: 0.2))
                                .gesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            self.viewStatePicture.width = value.translation.width
                                        })
                                        .onEnded({ value in
                                            self.viewStatePicture.width = 0
                                        })
                                )
                        }
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
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
                    title: "sale_title",
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
                self.projectSalesViewModel.fetchDataProjectSales(project_id: self.project_id)
                self.projectSalesViewModel.isHasData.sink { rs in
                    self.projectSales = self.projectSalesViewModel.projectSales ?? []
                    self.isHasData = true
                }.store(in: &self.disposes)
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ImageScrollSales: View {
    @State var data: SalesModel
    @Binding var pictureIndex: CGFloat
    var index = 0

    var body: some View {
        ZStack (alignment: .bottom) {
            ZStack {
                if (data.url ?? "").isEmpty {
                    Image("default_large")
                        .resizable()
                } else {
                    ZStack {
                        Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                        WebImage(url: URL(string: data.url ?? ""))
                            .resizable()
                    }
                }
            }.scaledToFill()
                .frame(width: FULL_W - 72, height:
                        FULL_H == H_SE && FULL_W == W_SE ? FULL_H - 220: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? FULL_H - 240: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? FULL_H - 260: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? FULL_H - 350: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? FULL_H - 350: 0 // iPhone 11 Pro
                ).clipped()
                .cornerRadius(7)
                .shadow(color: .init(#colorLiteral(red: 0.3320114213, green: 0.3320114213, blue: 0.3320114213, alpha: 0.89)), radius: 5)
            TextCustom(
                text: data.info?.description ?? "",
                font: MEDIUM,
                size: 18,
                lineLimit: 1,
                color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1))
                .frame(width: FULL_W - 72, height: H(40))
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                ).cornerRadius(7, corners: [.bottomLeft, .bottomRight])
        }.animation(.easeInOut(duration: 0.2))
            .scaleEffect(self.pictureIndex == CGFloat(index) ? 1 : 0.92)
            .offset(x: (FULL_W - 65) * CGFloat(index))
    }
}
