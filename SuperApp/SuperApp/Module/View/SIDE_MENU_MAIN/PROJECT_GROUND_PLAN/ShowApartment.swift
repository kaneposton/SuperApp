// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ShowApartment: View {
    @Binding var isChangeColor: Bool
    @Binding var isShow: Bool
    @Binding var selectedType: String
    @Binding var selectedApartment: String
    @Binding var selectedTypeID: Int
    @Binding var selectedApartmentID: Int
    @Binding var dataType: [typeModel]
    @Binding var dataApartment: [apartmentModel]
    @Binding var selectedStatus: String

    @State var temp_selectedType = ""
    @State var temp_selectedApartment = ""
    @State var temp_selectedTypeID = 0
    @State var temp_selectedApartmentID = 0
    @State var temp_selectedStatus = ""

    var body: some View {
        ZStack {
            if isShow {
                Text("").onAppear {
                    self.temp_selectedType = self.selectedType
                    self.temp_selectedApartment = self.selectedApartment
                    self.temp_selectedTypeID = self.selectedTypeID
                    self.temp_selectedApartmentID = self.selectedApartmentID
                    self.temp_selectedStatus = self.selectedStatus
                }
            }
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(width: W(74), height: W(4))
                        .foregroundColor(.init(#colorLiteral(red: 0.5111798048, green: 0.3070217371, blue: 0.7141162753, alpha: 1)))
                        .padding(.top, H(8))
                    ZStack {
                        HStack {
                            Button(action: {
                                self.isShow = false
                                self.isChangeColor = false
                            }) {
                                TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4038758278, green: 0.4039486051, blue: 0.403865695, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                            Spacer()
                        }
                        TextCustom(text: NSLocalizedString("project_ground_plan_popup_preview", comment: ""), font: MEDIUM, size: 22, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                        HStack {
                            Spacer()
                            Button(action: {
                                self.selectedApartment = self.temp_selectedApartment
                                self.selectedType = self.temp_selectedType
                                self.selectedApartmentID = self.temp_selectedApartmentID
                                self.selectedTypeID = self.temp_selectedTypeID
                                self.selectedStatus = self.temp_selectedStatus
                                self.isShow = false
                                self.isChangeColor = false
                            }) {
                                TextCustom(text: NSLocalizedString("project_ground_plan_popup_done", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4205850065, green: 0.1838403046, blue: 0.6598007083, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }
                    }.padding(.top, H(12))
                        .padding(.horizontal, 30)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.8077571988, green: 0.8078939915, blue: 0.8077381253, alpha: 1)))
                        .padding(.top, H(14))
                    HStack(spacing: 24) {
                        ForEach(dataType, id: \.id) { data in
                            ApartmentPopUpTappedView(
                                selectedTypeID: self.$temp_selectedTypeID,
                                selectedType: self.$temp_selectedType,
                                data: data
                            )
                        }
                    }.padding(.top, H(21))
                    ScrollView {
                        VStack (spacing: 0) {
                            ForEach(dataApartment, id: \.id) { data in
                                ApartmentPopUpCustomView(
                                    selectedApartmentID: self.$temp_selectedApartmentID,
                                    selectedApartment: self.$temp_selectedApartment,
                                    selectedStatus: self.$temp_selectedStatus,
                                    data: data
                                )
                            }
                        }
                    }.padding(.top, H(16))
                        .offset(y: isShow ? 0 : H(500))
                }.frame(width: FULL_W, height: H(344))
                    .background(Color.white)
                    .cornerRadius(5)
            }.edgesIgnoringSafeArea(.bottom)
                .offset(y: isShow ? 0 : H(500))
                .animation(.easeInOut(duration: 0.2))
        }
    }
}

struct ApartmentPopUpTappedView: View {
    @Binding var selectedTypeID: Int
    @Binding var selectedType: String
    @State var data: typeModel

    var body: some View {
        Button(action: {
            self.selectedTypeID = self.data.id
            self.selectedType = self.data.name
        }) {
            ZStack {
                Rectangle()
                    .cornerRadius(7)
                    .foregroundColor(.init(selectedTypeID == data.id ? #colorLiteral(red: 0.9226210713, green: 0.8795441985, blue: 0.9641619325, alpha: 1): #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.init(selectedTypeID == data.id ? #colorLiteral(red: 0.9226210713, green: 0.8795441985, blue: 0.9641619325, alpha: 1): #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1)), lineWidth: 1))
                    .frame(width: W(38), height: W(38))
                    .shadow(color: .init(selectedTypeID == data.id ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5): #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), radius: 2, y: 2)
                TextCustom(text: data.name, font: MEDIUM, size: 18, color: selectedTypeID == data.id ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
            }
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
    }
}

struct ApartmentPopUpCustomView: View {
    @Binding var selectedApartmentID: Int
    @Binding var selectedApartment: String
    @Binding var selectedStatus: String
    @State var data: apartmentModel

    var body: some View {
        VStack (spacing: 0) {
            Button(action: {
                self.selectedApartmentID = self.data.id
                self.selectedApartment = self.data.title
                self.selectedStatus = self.data.status
            }) {
                HStack {
                    TextCustom(text: data.title, font: REGULAR, size: 18, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        .padding(.leading, 30)
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(width: W(24), height: W(24))
                            .foregroundColor(.init(#colorLiteral(red: 0.5590858459, green: 0.3960000873, blue: 0.9303051829, alpha: 1)))
                            .clipShape(Circle())
                        ImageCustom(name: "check", w: 11.7, h: 8.7)
                    }.padding(.trailing, 28)
                        .opacity(selectedApartmentID == data.id ? 1 : 0)
                }.background(Color.white)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .background(Color.white)
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                .padding(.vertical, H(17))
        }.background(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
    }
}
