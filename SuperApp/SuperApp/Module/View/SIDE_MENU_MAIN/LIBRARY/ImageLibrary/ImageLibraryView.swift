// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import RxSwift
import SDWebImageSwiftUI

struct imageListArr: Identifiable, Hashable {
    var id = UUID()
    var content: String
    var imageName: String
    var label: String
    var index: CGFloat
}

struct ImageLibraryView: View {
    @Binding var project_id: Int
    @Binding var isSideMenuAppear: Bool
    @Binding var isNext: Bool
    let closeSideMenu: () -> Void

    @State var viewStatePicture = CGSize.zero
    @State var saveWidth: CGFloat = 0
    @State var spaceImage: CGFloat = FULL_W - 65
    @State var pictureIndex: CGFloat = 0

    @State var isHasData = false
    @State var disposes = Set<AnyCancellable>()
    @ObservedObject var libraryViewModel = ProjectSaleLibraryViewModel()
    @State var listImage = [List_image]()

    var body: some View {
        ZStack {
            if isHasData {
                if listImage.count != 0 {
                    ForEach(listImage, id: \.self) { data in
                        ImageScrollLibrary(
                            isSideMenuAppear: self.$isSideMenuAppear,
                            pictureIndex: self.$pictureIndex,
                            isNext: self.$isNext,
                            closeSideMenu: { self.closeSideMenu() },
                            imageURL: data,
                            index: data.index
                        )
                    }
                } else {
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
                }
            } else { Color.white }
        }.onAppear {
            self.libraryViewModel.fetchDataLibrary(project_id: self.project_id)
            self.libraryViewModel.isHasData.sink { rs in
                self.listImage = self.libraryViewModel.LibraryData?.list_image ?? []
                for i in 0 ..< self.self.listImage.count {
                    self.listImage[i].index = i
                }
                self.isHasData = true
            }.store(in: &self.disposes)
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
                            if self.pictureIndex < CGFloat(integerLiteral: self.listImage.count - 1) {
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
    }
}

struct ImageScrollLibrary: View {
    @Binding var isSideMenuAppear: Bool
    @State var data = imageListArr(content: "", imageName: "", label: "", index: 0)
    @Binding var pictureIndex: CGFloat
    @Binding var isNext: Bool
    let closeSideMenu: () -> Void
    var imageURL: List_image = List_image()
    var index = -1

    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                if (imageURL.url ?? "").isEmpty {
                    Image("default_large")
                        .resizable()
                } else {
                    ZStack {
                        Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                        WebImage(url: URL(string: "\(imageURL.url ?? "")"))
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
                .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 0.8034220951)), radius: 5)
                .scaleEffect(self.pictureIndex == CGFloat(self.index) ? 1 : 0.92)
                .onTapGesture {
                    self.isNext = true
                    self.isSideMenuAppear = false
                    self.closeSideMenu()
            }
            TextCustom(
                text: imageURL.info?.description ?? "",
                font: MEDIUM,
                size: 22,
                lineLimit: 2,
                color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: H(50))
                .multilineTextAlignment(.center)
                .padding(.vertical, H(24))
                .padding(.horizontal, 62)
        }.offset(x: (FULL_W - 65) * CGFloat(self.index))
    }
}
