// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct imageListArrDetail: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var index: CGFloat
}

struct typeImageLibraryIndex: Identifiable, Hashable {
    var id = UUID()
    var url: String?
    var info: Info?
    var index: Int
}

struct LibraryDetailView: View {
    @Binding var isNextOld: Bool
    @Binding var dataImage: imageListArr
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var viewStatePicture = CGSize.zero
    @State var pictureIndex: CGFloat = 0
    @State var spaceControl: CGFloat = 3
    @State var isNextChat = false
    @State var saveWidth: CGFloat = 0
    @State var isIncrease = true
    @State var isDecrease = false

    @State var isHasData = false
    @State var disposes = Set<AnyCancellable>()
    @ObservedObject var libraryViewModel = ProjectSaleLibraryViewModel()
    @State var listImage = [typeImageLibraryIndex]()
    @State var temp_url = ""
    @State var temp_info = Info(description: "")
    @State var temp_index = 0

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ZStack {
                    if isHasData {
                        if listImage.count != 0 {
                            ForEach(listImage, id: \.self) { data in
                                ImageScrollLibraryDetail (
                                    pictureIndex: self.$pictureIndex,
                                    data: data,
                                    index: data.index)
                            }
                        } else {
                            VStack {
                                HStack {
                                    Spacer()
                                    ImageCustom(name: "group9122", w: 250, h: 250)
                                    Spacer()
                                }
                                Spacer()
                            }.background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                .padding(.top, H(200))
                        }
                    } else {
                        Rectangle()
                            .foregroundColor(.white)
                    }
                }.edgesIgnoringSafeArea(.all)
                    .offset(x: self.viewStatePicture.width)
                    .animation(.easeInOut(duration: 0.2))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                self.viewStatePicture.width = value.translation.width + self.saveWidth
                            })
                            .onEnded({ value in
                                // MARK: SWIPE <-
                                if self.viewStatePicture.width < (-FULL_W * self.pictureIndex) {
                                    if self.pictureIndex < CGFloat(integerLiteral: self.listImage.count - 1) {
                                        self.viewStatePicture.width = (-FULL_W * self.pictureIndex) - FULL_W
                                        self.pictureIndex += 1
                                    } else {
                                        self.viewStatePicture.width = (-FULL_W * self.pictureIndex)
                                    }
                                    self.isIncrease = true
                                    self.isDecrease = false
                                }

                                // MARK: SWIPE ->
                                if self.viewStatePicture.width > (0 + (-FULL_W * self.pictureIndex)) {
                                    if self.pictureIndex > 0 {
                                        self.viewStatePicture.width = (-FULL_W * self.pictureIndex) + FULL_W
                                        self.pictureIndex -= 1
                                    } else {
                                        self.viewStatePicture.width = (-FULL_W * self.pictureIndex)
                                    }
                                    self.isIncrease = false
                                    self.isDecrease = true
                                }
                                self.saveWidth = self.viewStatePicture.width
                            })
                    ).navigationBarBackButtonHidden(true)
                ZStack (alignment: .bottom) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 170)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 0.8994809503)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.8, alpha: 0))]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                    VStack (alignment: .leading, spacing: 5) {
                        TextCustom(text: dataImage.label, font: MEDIUM, size: 18, color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1))
                        TextCustom(text: dataImage.content, font: REGULAR, size: 14, color: #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)).lineSpacing(5)
                        HStack (spacing: 3) {
                            Spacer()
                            ForEach(listImage.enumeratedArray(), id: \.element) { index, data in
                                LibraryDetailControl(pictureIndex: self.$pictureIndex, index: index)
                            }
                            Spacer()
                        }.padding(.top, 3)
                            .animation(.easeInOut(duration: 0.2))
                    }.padding(.horizontal, 20)
                        .padding(.bottom,
                            FULL_H == H_SE && FULL_W == W_SE ? 25: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 25: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 25: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 30: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 30 : 0 // iPhone 11 Pro
                        )
                }
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: H(100))
                    Spacer()
                }
                VStack {
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: $isOpenSideMenu,
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "library_title",
                        title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)",
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
                        isCallAndTextWhite: true
                    )
                    Spacer()
                }
                NavigationLink(destination:
                        ChatView(
                            isNextOld: $isNextChat,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData,
                            isHaveSideMenu: true
                        ), isActive: $isNextChat) {
                    EmptyView()
                }
            }.onAppear {
                self.libraryViewModel.fetchDataLibrary(project_id: self.project_id)
                self.libraryViewModel.isHasData.sink { rs in
                    for i in 0 ..< (self.libraryViewModel.LibraryData?.list_image ?? []).count {
                        self.temp_url = (self.libraryViewModel.LibraryData?.list_image ?? [])[i].url ?? ""
                        self.temp_info = (self.libraryViewModel.LibraryData?.list_image ?? [])[i].info ?? Info(description: "")
                        self.temp_index = i
                        self.listImage.append(typeImageLibraryIndex(url: self.temp_url, info: self.temp_info, index: self.temp_index))
                    }
                    self.isHasData = true
                }.store(in: &self.disposes)
            }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ImageScrollLibraryDetail: View {
    @Binding var pictureIndex: CGFloat
    @State var data = typeImageLibraryIndex(index: 0)
    @State var index = -1

    var body: some View {
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
            .frame(width: FULL_W)
            .clipped()
            .offset(x: FULL_W * CGFloat(self.index))
    }
}
struct LibraryDetailControl: View {
    @Binding var pictureIndex: CGFloat
    @State var index: Int

    var body: some View {
        Rectangle()
            .frame(width: pictureIndex == CGFloat(index) ? 20 : 6, height: 6, alignment: .leading)
            .foregroundColor(.init(pictureIndex == CGFloat(index) ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.6705882353, green: 0.6705882353, blue: 0.6705882353, alpha: 1)))
            .cornerRadius(.infinity)
    }
}
