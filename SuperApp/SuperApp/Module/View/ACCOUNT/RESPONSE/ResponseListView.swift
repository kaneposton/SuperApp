// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TopicFile: Identifiable, Hashable {
    var id = UUID()
    var type: String
    var name: String
}
struct TypeResponse: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var detail: String
    var time: String
    var idTopic: String
    var isFlag: Bool
    var file: [TopicFile]
    var comment: [CommentTopic]
}

struct CommentTopic: Identifiable, Hashable {
    var id = UUID()
    var userName: String
    var urlImage: String
    var date: String
    var content: String
    var isQTV: Bool
    var isLiked: Int
    var reply: [ReplyComment]
}

struct ReplyComment: Identifiable, Hashable {
    var id = UUID()
    var userName: String
    var urlImage: String
    var date: String
    var content: String
    var isQTV: Bool
}

struct ResponseListView: View {
    @Binding var isNextOld: Bool

    @State var tempPullScreen = false
    @State var isShowing = false
    @State var isPull = false
    @State var isNextCreate = false
    @State var strSearch = ""
    @State var isTapSearch = false
    @State var isNextDetail = false
    @State var idTopicSelected = ""
    @State var isShowCalendar = false
    @State var valueIndexMonth = 0
    @State var valueIndexYear = 0
    @State var valueNameDate = ""
    @State var isChooseValueDate = false

    @State var selectedTopic = TypeResponse(
        title: "",
        detail: "",
        time: "",
        idTopic: "",
        isFlag: false,
        file: [],
        comment: []
    )

    @State var dataResponse = [
        TypeResponse(
            title: "Hỏi về đợt mở bán căn hộ ở dự án VTP",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "9:00 - 27/01/2020",
            idTopic: "#0123",
            isFlag: false,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        ),
        TypeResponse(
            title: "Hỏi về giấy tờ liên quan đến việc hoàn tất hồ sơ mua biệt thự của dự án khu Thảo Điền",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "9:00 - 24/01/2020",
            idTopic: "#0124",
            isFlag: true,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        ),
        TypeResponse(
            title: "Các quy trình vay trả góp thả nổi SCB của căn hộ",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "8:00 - 24/02/2020",
            idTopic: "#0125",
            isFlag: false,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        ),
        TypeResponse(
            title: "Hỏi về giấy tờ liên quan đến việc hoàn tất hồ sơ mua biệt thự của dự án khu Thảo Điền dành cho khách hàng có thẻ hội viên vàng trong đợi 1 ",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "9:00 - 20/02/2020",
            idTopic: "#0126",
            isFlag: true,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        ),
        TypeResponse(
            title: "Hỏi về đợt mở bán căn hộ ở dự án VTP",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "9:00 - 19/03/2020",
            idTopic: "#0127",
            isFlag: false,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        ),
        TypeResponse(
            title: "Hỏi về giấy tờ liên quan đến việc hoàn tất hồ sơ mua biệt thự của dự án khu Thảo Điền",
            detail: "Chào bạn cho mình hỏi về việc mở bán căn hộ ở dự án VTP, chừng nào mở bán vậy bạn. Bạn có thể cho xin một số thông chi tiết về dự án của bên dự án được không vậy. Và bạn cho hỏi việc mở bán này sẽ diễn ra ở đâu, xin cho chúng tôi biết thông tin cụ thể. Cảm ơn bạn rất nhiều. Dưới đây là thông tin địa chỉ của tôi.",
            time: "9:00 - 18/03/2020",
            idTopic: "#0128",
            isFlag: true,
            file: [
                TopicFile(type: "xls", name: "file-giay-to-01.xls"),
                TopicFile(type: "pdf", name: "file-giay-to-01.pdf")
            ],
            comment: [
                CommentTopic(
                    userName: "Phòng sale",
                    urlImage: "commentImage1",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn rất nhiều,đã quan tâm đến dự án căn hộ của VTP chúng tôi, hiện tại dự án đang được bán tại các chi nhánh chính và đại lý liên doanh với chúng tôi. Cụ thể đại lý 203 đường 2/3,phường 10, quận 10, Tp.HCM",
                    isQTV: false,
                    isLiked: -1,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng marketing",
                    urlImage: "commentImage2",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: false,
                    isLiked: 0,
                    reply: []
                ),
                CommentTopic(
                    userName: "Phòng tư vấn",
                    urlImage: "",
                    date: "9:00 - 27/02/2020",
                    content: "Cảm ơn bạn, chúng tôi sẽ liên hệ và đến nơi địa chỉ của bạn để tư vấn trực tiếp cho bạn, rất mong bạn dành thời gian cho chúng tôi. Thành thật cảm ơn bạn.\nNgười liên hệ Trần Tấn Đạt (0905 125 450)",
                    isQTV: true,
                    isLiked: 1,
                    reply: []
                )
            ]
        )
    ]

    var body: some View {
        NavigationView {
            ZStack (alignment: . top) {
                if tempPullScreen { Text("") }
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 0) {
                    // MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: $isTapSearch,
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: $strSearch,
                        isShowCalendar: $isShowCalendar,
                        isChooseValueDate: $isChooseValueDate,
                        title: "account_response",
                        backFunc: { self.isNextOld = false },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true,
                        isResponse: true
                    )
                    List {
                        ZStack (alignment: .top) {
                            if !isPull {
                                VStack (spacing: H(16)) {
                                    if dataResponse.count > 0 {
                                        if isChooseValueDate {
                                            if strSearch.isEmpty {
                                                if dataResponse.firstIndex(where: ({ $0.time.localizedStandardContains(valueNameDate) })) == nil {
                                                    HStack {
                                                        Spacer()
                                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                                        Spacer()
                                                    }.padding(.top, H(100))
                                                        .frame(width: FULL_W - 40)
                                                } else {
                                                    ForEach(dataResponse.filter({ $0.time.localizedStandardContains(valueNameDate) }), id: \.self) { data in
                                                        CellResponse(dataResponse: self.$dataResponse, idTopicSelected: self.$idTopicSelected, isNextDetail: self.$isNextDetail, data: data)
                                                    }
                                                }
                                            } else if dataResponse.firstIndex(where: ({ $0.time.localizedStandardContains(valueNameDate) && $0.title.localizedStandardContains(strSearch) })) == nil {
                                                HStack {
                                                    Spacer()
                                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                                    Spacer()
                                                }.padding(.top, H(100))
                                                    .frame(width: FULL_W - 40)
                                            } else {
                                                ForEach(dataResponse.filter({ $0.time.localizedStandardContains(valueNameDate) && $0.title.localizedStandardContains(strSearch) }), id: \.self) { data in
                                                    CellResponse(dataResponse: self.$dataResponse, idTopicSelected: self.$idTopicSelected, isNextDetail: self.$isNextDetail, data: data)
                                                }
                                            }
                                        } else {
                                            if strSearch.isEmpty {
                                                ForEach(dataResponse, id: \.self) { data in
                                                    CellResponse(dataResponse: self.$dataResponse, idTopicSelected: self.$idTopicSelected, isNextDetail: self.$isNextDetail, data: data)
                                                }
                                            } else if dataResponse.firstIndex(where: ({ $0.title.localizedStandardContains(strSearch) })) == nil {
                                                HStack {
                                                    Spacer()
                                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                                    Spacer()
                                                }.padding(.top, H(100))
                                                    .frame(width: FULL_W - 40)
                                            } else {
                                                ForEach(dataResponse.filter({ $0.title.localizedStandardContains(strSearch) }), id: \.self) { data in
                                                    CellResponse(dataResponse: self.$dataResponse, idTopicSelected: self.$idTopicSelected, isNextDetail: self.$isNextDetail, data: data)
                                                }
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
                                }.padding(.leading, 20)
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                            .padding(.bottom, H(100) + 20)
                            .padding(.top, H(6))
                    }.resignKeyboardOnDragGesture()
                        .background(PullToRefresh(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isPull = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowing = false
                                        self.isPull = false
                                    }
                                }
                        }, isShowing: self.$isShowing))
                    Spacer()
                }.animation(isTapSearch ? .easeInOut(duration: 0.4) : .none)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Button(action: {
                            self.isNextCreate = true
                        }) {
                            ImageCustom(name: "addTaskPurple", w: 65, h: 65)
                                .shadow(color: .init(#colorLiteral(red: 0.3171002538, green: 0.3171002538, blue: 0.3171002538, alpha: 0.4252193921)), radius: 2, x: 2, y: 2)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.trailing, 30)
                            .padding(.bottom, H(35))
                    }
                }
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isShowCalendar ? 0.6 : 0)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowCalendar = false
                }
                DatePickerMonthYear(
                    valueIndexMonth: $valueIndexMonth,
                    valueIndexYear: $valueIndexYear,
                    valueName: $valueNameDate,
                    isShowDatePicker: $isShowCalendar,
                    isChooseValueDate: $isChooseValueDate
                )

                // MARK: LINK MÀN HÌNH
                ZStack (alignment: .top) {
                    // MARK: CHI TIẾT CÂU HỎI
                    NavigationLink(destination:
                            ResponseDetailView(
                                isNextOld: $isNextDetail,
                                dataResponse: $dataResponse,
                                idTopicSelected: $idTopicSelected
                            ), isActive: $isNextDetail) {
                        EmptyView()
                    }

                    // MARK: TẠO CÂU HỎI MỚI
                    NavigationLink(destination:
                            AddQuestionView(
                                isNextOld: $isNextCreate
                            ), isActive: $isNextCreate) {
                        EmptyView()
                    }
                }
            }.onTapGesture {
                    UIApplication.shared.endEditing()
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

struct CellResponse: View {
    @Binding var dataResponse: [TypeResponse]
    @Binding var idTopicSelected: String
    @Binding var isNextDetail: Bool

    @State var data = TypeResponse(title: "", detail: "", time: "", idTopic: "", isFlag: false, file: [], comment: [])

    var body: some View {
        ZStack (alignment: .topTrailing) {
            Button(action: {
                self.idTopicSelected = self.data.idTopic
                self.isNextDetail = true
                UIApplication.shared.endEditing()
            }) {
                HStack {
                    VStack (alignment: .leading, spacing: H(10)) {
                        TextCustom(text: data.title, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                            .fixedSize(horizontal: false, vertical: true)
                        HStack (spacing: 14) {
                            HStack (spacing: 7) {
                                ZStack {
                                    ImageCustom(name: "timePurple", w: 13, h: 13)
                                }.frame(width: W(16), height: W(16))
                                TextCustom(text: data.time, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                            }
                            Rectangle()
                                .frame(width: 1, height: H(11))
                                .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                            HStack (spacing: 7) {
                                ImageCustom(name: "ticketPurple", w: 16, h: 16)
                                HStack (spacing: 0) {
                                    TextCustom(text: "\(NSLocalizedString("response_maCau", comment: "")): ", font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                    TextCustom(text: data.idTopic, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1))
                                }
                            }
                        }
                    }.frame(width: FULL_W - 135, alignment: .leading)
                        .padding(.leading, 14)
                    Spacer()
                }.frame(width: FULL_W - 40, alignment: .leading)
                    .padding(.vertical, 14)
                    .background(
                        ZStack (alignment: .bottomTrailing) {
                            Color.white
                            ImageCustom(name: "questionMark", w: 42, h: 38)
                        }
                    ).frame(width: FULL_W - 40)
                    .cornerRadius(4)
                    .shadow(color: .init(#colorLiteral(red: 0.3171002538, green: 0.3171002538, blue: 0.3171002538, alpha: 0.4252193921)), radius: 3)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
            HStack (spacing: 0) {
                Button(action: {

                }) {
                    ZStack {
                        ImageCustom(name: "EmptyPicture", w: 33, h: 32)
                        ImageCustom(name: "sharePurple", w: 18, h: 18)
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
                Button(action: {
                    self.data.isFlag.toggle()
                    for i in 0 ..< self.dataResponse.count {
                        if self.dataResponse[i].idTopic == self.data.idTopic {
                            self.dataResponse[i].isFlag = self.data.isFlag
                        }
                    }
                }) {
                    ZStack {
                        ImageCustom(name: "EmptyPicture", w: 33, h: 32)
                        ImageCustom(name: "flagGray", w: 18, h: 18).opacity(data.isFlag ? 0 : 1)
                        ImageCustom(name: "flagGreen", w: 18, h: 18).opacity(data.isFlag ? 1 : 0)
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
            }
        }
    }
}
