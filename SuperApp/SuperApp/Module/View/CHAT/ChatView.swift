// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI

struct chatData: Identifiable, Hashable {
    var id = UUID()
    var isMe: Bool
    var message: String
    var time: String
}

struct ChatView: View {
    @Binding var isNextOld: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var isHaveSideMenu = true
    @State var strChat = ""
    @State var dynamicHeight: CGFloat = 100
    @State var isScrollBottom = false
    @State var date = Date()
    @State var keyboardHeight: CGFloat = 0

    var body: some View {
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
                .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.top)
                .frame(height: H(100))
            VStack (spacing: 0) {
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "projectDetailHome_ChatTitle",
                    title_2: "",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                        if self.isHaveSideMenu {
                            self.isSideMenuAppear = true
                        }
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: { },
                    textFunc: { },
                    isBack: true
                ).padding(.bottom, H(20))
                CustomScrollView(scrollToEnd: true) {
                    VStack (spacing: H(20)) {
                        Spacer()
                        ForEach (self.arrChatData, id: \.self) { data in
                            ChatBubble(data: data)
                        }
                    }.padding(.top, H(20))
                        .padding(.bottom, self.dynamicHeight + H(68))
                        .offset(y: self.keyboardHeight > 0 ? H(20) - self.keyboardHeight: 0)
                }.edgesIgnoringSafeArea(.bottom)
            }
            VStack (spacing: 0) {
                Spacer()
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.8407533765, green: 0.827776432, blue: 0.8273850083, alpha: 1)))
                    .frame(height: 1)
                HStack (alignment: .bottom, spacing: 14) {
                    Button(action: {

                    }) {
                        ImageCustom(name: "iconFeatherPlus", w: 17, h: 17)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.3))
                        .offset(y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? -16: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? -14: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? -13: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? -12: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? -11 : 0) // iPhone 11 Pro
                        )
                    Button(action: {

                    }) {
                        ImageCustom(name: "iconFeatherSmile", w: 17, h: 17)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.3))
                        .offset(y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? -16: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? -14: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? -13: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? -12: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? -11 : 0) // iPhone 11 Pro
                        )
                    ZStack (alignment: .leading) {
                        TextCustom(text: NSLocalizedString("chat_placeholder", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                            .padding(.leading, 16)
                            .opacity(strChat.isEmpty ? 1 : 0)
                        UITextViewWrapper(
                            text: self.$strChat,
                            calculatedHeight: $dynamicHeight,
                            isFocus: Binding.constant(false),
                            isUseFocus: false,
                            font: REGULAR,
                            size: 14,
                            color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1),
                            paddingLeft: 11
                        ).frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                    }.background(Color.init(#colorLiteral(red: 0.965610683, green: 0.9489760995, blue: 0.9994972348, alpha: 1)))
                        .cornerRadius(4)
                    Button(action: {
                        if !self.strChat.isBlank && !self.strChat.isEmpty {
                            self.arrChatData.append(chatData(isMe: true, message: self.strChat, time: "\(self.date)"))
                            self.strChat = ""
                        }
                        if self.strChat.isBlank || self.strChat.isEmpty {
                            self.strChat = ""
                        }
                    }) {
                        ImageCustom(name: "iconMaterialSend", w: 20, h: 17)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.3))
                        .offset(y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? -16: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? -14: // iPhone 8 && iPhone 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? -13: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? -12: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? -11 : 0) // iPhone 11 Pro
                        )
                }.padding(.horizontal, 17)
                    .padding(.vertical, H(16))
                    .background(Color.white)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: keyboardHeight > 0 ? keyboardHeight : H(20))
            }.animation(.easeInOut(duration: 0.3))
                .edgesIgnoringSafeArea(.bottom)
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .onTapGesture {
                UIApplication.shared.endEditing()
                self.isScrollBottom = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.isScrollBottom = false
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct ChatBubble: View {
    @State var data: chatData

    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.8407533765, green: 0.827776432, blue: 0.8273850083, alpha: 1)))
                    .frame(height: 1)
                TextCustom(text: data.time.formatDate(from:
                        data.time.components(separatedBy: " ").count == 3 ? "yyyy-MM-dd HH:mm:ss Z" : "yyyy-MM-dd hh:mm:ss a Z",
                    to: "EEEE, dd-MM-yyyy"), font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.8407533765, green: 0.827776432, blue: 0.8273850083, alpha: 1))
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.8407533765, green: 0.827776432, blue: 0.8273850083, alpha: 1)))
                    .frame(height: 1)
            }.padding(.bottom, H(9))
            if !data.isMe {
                HStack (alignment: .bottom, spacing: 20) {
                    ZStack (alignment: .bottom) {
                        Rectangle()
                            .frame(width: W(30), height: W(30))
                            .foregroundColor(.init(#colorLiteral(red: 0.7886190414, green: 0.8274392486, blue: 0.865532577, alpha: 1)))
                        ImageCustom(name: "user1", w: 20, h: 23)
                    }.cornerRadius(.infinity)
                    VStack (alignment: .leading, spacing: H(5)) {
                        TextCustom(text: data.message, font: REGULAR, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            .fixedSize(horizontal: false, vertical: true)
                        TextCustom(text: data.time.formatDate(
                            from: data.time.components(separatedBy: " ").count == 3 ?
                            "yyyy-MM-dd HH:mm:ss Z": "yyyy-MM-dd hh:mm:ss a Z",
                            to: "hh:mm a"), font: REGULAR, size: 12, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                    }.padding(.vertical, H(9))
                        .padding(.horizontal, 13)
                        .background(
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 0.9420996308, green: 0.9422125816, blue: 0.9420612454, alpha: 1)))
                        )
                    Spacer()
                }.padding(.horizontal, 16)
            } else {
                HStack (alignment: .bottom, spacing: 20) {
                    Spacer()
                    VStack (alignment: .leading, spacing: H(5)) {
                        TextCustom(text: data.message, font: REGULAR, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            .fixedSize(horizontal: false, vertical: true)
                        TextCustom(text: data.time.formatDate(
                            from: data.time.components(separatedBy: " ").count == 3 ?
                            "yyyy-MM-dd HH:mm:ss Z": "yyyy-MM-dd hh:mm:ss a Z",
                            to: "hh:mm a"), font: REGULAR, size: 12, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                    }.padding(.vertical, H(9))
                        .padding(.horizontal, 13)
                        .background(
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 0.965610683, green: 0.9489760995, blue: 0.9994972348, alpha: 1)))
                        )
                    ZStack (alignment: .bottom) {
                        Rectangle()
                            .frame(width: W(30), height: W(30))
                            .foregroundColor(.init(#colorLiteral(red: 0.7886190414, green: 0.8274392486, blue: 0.865532577, alpha: 1)))
                        ImageCustom(name: "user1", w: 20, h: 23)
                    }.cornerRadius(.infinity)
                }.padding(.horizontal, 16)
            }
        }
    }
}

struct CustomScrollView<Content>: View where Content: View {
    var axes: Axis.Set = .vertical
    var reversed = false
    var scrollToEnd = false
    var content: () -> Content

    @State private var contentHeight: CGFloat = .zero
    @State private var contentOffset: CGFloat = .zero
    @State private var scrollOffset: CGFloat = .zero

    var body: some View {
        GeometryReader { geometry in
            if self.axes == .vertical {
                self.vertical(geometry: geometry)
            } else {
                // implement same for horizontal orientation
            }
        }
            .clipped()
    }

    private func vertical(geometry: GeometryProxy) -> some View {
        ZStack {
            VStack {
                content()
            }
                .modifier(ViewHeightKey())
                .onPreferenceChange(ViewHeightKey.self) {
                    self.updateHeight(with: $0, outerHeight: geometry.size.height)
                }
                .frame(height: geometry.size.height, alignment: (reversed ? .bottom : .top))
                .offset(y: contentOffset + scrollOffset)
                .animation(.easeInOut)
                .background(Color.white)
                .gesture(DragGesture()
                        .onChanged { self.onDragChanged($0) }
                        .onEnded { self.onDragEnded($0, outerHeight: geometry.size.height) }
                )
        }
    }

    private func onDragChanged(_ value: DragGesture.Value) {
        self.scrollOffset = value.location.y - value.startLocation.y
    }

    private func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
        let scrollOffset = value.predictedEndLocation.y - value.startLocation.y

        self.updateOffset(with: scrollOffset, outerHeight: outerHeight)
        self.scrollOffset = 0
    }

    private func updateHeight(with height: CGFloat, outerHeight: CGFloat) {
        let delta = self.contentHeight - height
        self.contentHeight = height
        if scrollToEnd {
            self.contentOffset = self.reversed ? height - outerHeight - delta: outerHeight - height
        }
        if abs(self.contentOffset) > .zero {
            self.updateOffset(with: delta, outerHeight: outerHeight)
        }
    }

    private func updateOffset(with delta: CGFloat, outerHeight: CGFloat) {
        let topLimit = self.contentHeight - outerHeight

        if topLimit < .zero {
            self.contentOffset = .zero
        } else {
            var proposedOffset = self.contentOffset + delta
            if (self.reversed ? proposedOffset : -proposedOffset) < .zero {
                proposedOffset = 0
            } else if (self.reversed ? proposedOffset : -proposedOffset) > topLimit {
                proposedOffset = (self.reversed ? topLimit : -topLimit)
            }
            self.contentOffset = proposedOffset
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}
