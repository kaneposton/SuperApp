// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import SwiftUI
import Mapbox

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

struct mapBox: View {
    var isFilter = false
    var data: [DataForMap] = []
    // var coorDinate: MyCustomAnnotation = MyCustomAnnotation(title: "Here", coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    @Binding var coorDinate: DataForMap
    @Binding var arrCoorDinate: [CLLocationCoordinate2D]
    var viewWillAppear: ((Int) -> Void)?
    @Binding var userTracking: Bool
    @Binding var zoomLevel: Double

    init(
        isFilter: Bool,
        data: [DataForMap],
        coorDinate: Binding<DataForMap>,
        arrCoorDinate: Binding<[CLLocationCoordinate2D]>,
        viewWillAppear: @escaping (Int) -> Void,
        userTracking: Binding<Bool>,
        zoomLevel: Binding<Double>
    ) {
        self.isFilter = isFilter
        self.data = data
        self._coorDinate = coorDinate
        self._arrCoorDinate = arrCoorDinate
        self.viewWillAppear = viewWillAppear
        self._userTracking = userTracking
        self._zoomLevel = zoomLevel
    }
    var body: some View {
        NavigationView {
            ZStack {
                MapBoxCombineView(
                    isFilter: isFilter,
                    data: data,
                    annotation: $coorDinate,
                    arrCoorDinate: $arrCoorDinate,
                    viewWillAppear: { rs in
                        self.viewWillAppear!(rs)
                    },
                    userTracking: $userTracking,
                    zoomLevel: self.$zoomLevel
                )
            }.edgesIgnoringSafeArea(.top)
        }.edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

class MyCustomAnnotation: MGLPointAnnotation {
    var willUseImage = false
    var projectId = 0
    var isSelect = false
    var icon = ""
}

extension MGLPointAnnotation {
    convenience init(title: String, coordinate: CLLocationCoordinate2D) {
        self.init()
        self.title = title
        self.coordinate = coordinate
    }

}

struct MapBoxCombineView: UIViewRepresentable {
    private var mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: URL(string: "https://images.vietbando.com/Style/vt_vbddefault/bbb9c9ad-00b9-4066-bc88-06b401b8eddd"))
    var isFilter = false
    var data: [DataForMap] = []
    @Binding var annotation: DataForMap
    @Binding var arrCoorDinate: [CLLocationCoordinate2D]
    var viewWillAppear: ((Int) -> Void)?
    @Binding var userTracking: Bool
    @Binding var zoomLevel: Double

    init(
        isFilter: Bool,
        data: [DataForMap],
        annotation: Binding<DataForMap>,
        arrCoorDinate: Binding<[CLLocationCoordinate2D]>,
        viewWillAppear: @escaping (Int) -> Void,
        userTracking: Binding<Bool>,
        zoomLevel: Binding<Double>
    ) {
        self.isFilter = isFilter
        self.data = data
        self._annotation = annotation
        self._arrCoorDinate = arrCoorDinate
        self.viewWillAppear = viewWillAppear
        self._userTracking = userTracking
        self._zoomLevel = zoomLevel
    }

    func makeUIView(context: UIViewRepresentableContext<MapBoxCombineView>) -> MGLMapView {
        mapView.showsUserLocation = true // lỗi cấu hình info
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.logoView.isHidden = true
        mapView.attributionButton.isHidden = true // lỗi cấu hình info
        mapView.compassView.isHidden = true
        mapView.delegate = context.coordinator
        mapView.locationManager.requestWhenInUseAuthorization()
        initAnnotation(view: mapView)
        return mapView
    }

    func updateUIView(_ view: MGLMapView, context: UIViewRepresentableContext<MapBoxCombineView>) {
        if isFilter {
            self.removeLayer(mapView: view, layerIdentifier: "location_purple")
        } else {
            let url = writeFile(coordinate: arrCoorDinate) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "ListCoordinates", ofType: "geojson")!)
            self.removeLayer(mapView: view, layerIdentifier: "location_purple")
            let source = MGLShapeSource(identifier: "location_purple", url: url, options: nil)
            view.style?.addSource(source)
            view.style?.addPolygons(from: source)
        }

        mapView.zoomLevel = self.zoomLevel

        if userTracking {
            DispatchQueue.main.async {
                self.annotation.location = view.userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: .zero, longitude: .zero)
                self.userTracking = false
            }
        }
        view.setCenter(CLLocationCoordinate2D(latitude: annotation.location.latitude, longitude: annotation.location.longitude), zoomLevel: self.zoomLevel, animated: false)

        let myplaces = returnMultipleAnnotationView(data: [annotation], annotation: annotation)
        let myplacesSelect = returnMultipleAnnotationView(data: [annotation], annotation: annotation)

        updateCoordinate(annotations: myplaces, annotation: myplacesSelect, view: view)
    }

    func initAnnotation (view: MGLMapView) {
        let myplaces = returnMultipleAnnotationView(data: data, annotation: annotation)
        let myplacesSelect = returnMultipleAnnotationView(data: [annotation], annotation: annotation)
        updateCoordinate(annotations: myplaces, annotation: myplacesSelect, view: view)
        if data.count == 0 {
            view.userTrackingMode = .follow
            view.showsUserLocation = true
        }
    }

    func removeLayer(mapView: MGLMapView, layerIdentifier: String) {
        guard let currentLayers = mapView.style?.layers else { return }

        if currentLayers.filter({ $0.identifier == layerIdentifier }).first != nil {

            print("Layer \(layerIdentifier) found.")

            guard let mapStyle = mapView.style else { return }

            // remove layer first
            if let styleLayer = mapStyle.layer(withIdentifier: layerIdentifier) {
                mapStyle.removeLayer(styleLayer)
            }

            // then remove the source
            if let source = mapStyle.source(withIdentifier: layerIdentifier) {
                mapStyle.removeSource(source)
            }
        }
        else {
            print("No layer with the identifier \(layerIdentifier) found.")
        }
    }

    func returnMultipleAnnotationView(data: [DataForMap], annotation: DataForMap) -> [MyCustomAnnotation] {
        var listMyCustomAnnotation: [MyCustomAnnotation] = []
        data.enumerated().forEach({ (index, value) in
            let point = MyCustomAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: value.location.latitude,

                longitude: value.location.longitude)
            point.title = value.title
            point.willUseImage = false
            point.projectId = value.projectId
            point.icon = value.icon
            if value.location.latitude == annotation.location.latitude && value.location.longitude == annotation.location.longitude
                {
                point.isSelect = true
            }
            listMyCustomAnnotation.append(point)
        })
        return listMyCustomAnnotation
    }

    func userTrackingMode(_ userTrackingMode: MGLUserTrackingMode) -> MapBoxCombineView {
        mapView.userTrackingMode = userTrackingMode
        return self
    }

    func updateCoordinate(annotations: [MyCustomAnnotation], annotation: [MyCustomAnnotation], view: MGLMapView) {
        if let currenCoordinate = view.annotations {
            view.removeAnnotations(currenCoordinate)
        }
        for i in 0 ..< annotations.count {
            if annotation.count != 0 {
                if annotations[i].projectId != annotation[0].projectId {
                    annotations[i].isSelect = false
                    view.addAnnotation(annotations[i])
                }
            }
        }
    }

    func styleURL(_ styleURL: URL) -> MapBoxCombineView {
        mapView.styleURL = styleURL
        return self
    }

    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapBoxCombineView {
        mapView.centerCoordinate = centerCoordinate
        return self
    }

    func zoomLevel(_ zoomLevel: Double) -> MapBoxCombineView {
        mapView.zoomLevel = zoomLevel
        return self
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewWillAppear: viewWillAppear!, data: data, zoomLevel: $zoomLevel, annotation: $annotation, arrCoorDinate: $arrCoorDinate)
    }

    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapBoxCombineView
        var viewWillAppear: ((Int) -> (Void))?
        var data: [DataForMap]
        @Binding var zoomLevel: Double
        @Binding var annotation: DataForMap
        @Binding var arrCoorDinate: [CLLocationCoordinate2D]

        init(_ control: MapBoxCombineView, viewWillAppear: @escaping (Int) -> Void, data: [DataForMap], zoomLevel: Binding<Double>, annotation: Binding<DataForMap>, arrCoorDinate: Binding<[CLLocationCoordinate2D]>) {
            self.control = control
            self.viewWillAppear = viewWillAppear
            self.data = data
            self._zoomLevel = zoomLevel
            self._annotation = annotation
            self._arrCoorDinate = arrCoorDinate
        }

        func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
            let camera = MGLMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude), acrossDistance: 150000, pitch: 15, heading: 360)
            mapView.fly(to: camera, completionHandler: nil)
            guard let myCustomAnnotation = annotation as? MyCustomAnnotation else { return }

            print(myCustomAnnotation.projectId)
            //mapView.setCenter(myCustomAnnotation.coordinate, zoomLevel: 15, animated: true)
        }

        func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
            print("did load mappppppppppppppppppp")
            viewWillAppear!(1)
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locValue: CLLocationCoordinate2D = manager.location!.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }

        func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
            var icon = ""
            if let castAnnotation = annotation as? MyCustomAnnotation {
                if (castAnnotation.willUseImage) {
                    return nil
                }
                icon = castAnnotation.icon
                if icon.isEmpty {
                    return nil
                }

            }
            var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "\(icon)")
            // if(annotationImage == nil) {
            annotationImage = MGLAnnotationImage(image: UIImage(named: icon)!, reuseIdentifier: "\(icon)")
            // }
            return annotationImage
        }

        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            // This example is only concerned with point annotations.
            guard annotation is MGLPointAnnotation else {
                return nil
            }
            // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
            let reuseIdentifier = "\(annotation.coordinate.longitude)"
            // For better performance, always try to reuse existing annotations.
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            // If there’s no reusable annotation view available, initialize a new one.
            if annotationView == nil {
                if let index = self.data.firstIndex(where: { $0.location.longitude == annotation.coordinate.longitude && $0.title == annotation.title }) {
                    if (annotation as! MyCustomAnnotation).isSelect {
                        print(mapView.zoomLevel)
                        print("self.zoomLevel")
                        annotationView = CustomAnnotationView(
                            reuseIdentifier: reuseIdentifier,
                            title: self.data[index].title,
                            adress: self.data[index].stringAddress,
                            projectId: self.data[index].projectId,
                            levelZoom: (CGFloat(mapView.zoomLevel)))
                    } else {
                        annotationView = CustomAnnotationView(
                            reuseIdentifier: reuseIdentifier,
                            title: self.data[index].title,
                            projectId: self.data[index].projectId,
                            levelZoom: (CGFloat(mapView.zoomLevel)))
                    }
                } else {
                    annotationView = CustomAnnotationView(
                        reuseIdentifier: reuseIdentifier,
                        title: "",
                        projectId: 0,
                        levelZoom: (CGFloat(mapView.zoomLevel)))
                    if annotation.title != nil {
                        annotationView!.bounds = CGRect(x: W(-150), y: H(-67), width: W(333), height: H(67))
                    } else {
                        annotationView!.bounds = CGRect(x: W(-74), y: H(-57), width: W(148), height: H(57))
                    }
                }
                annotationView!.isUserInteractionEnabled = true
                // Set the annotation view’s background color to a value determined by its longitude.
                annotationView!.backgroundColor = UIColor.clear
            }
            return annotationView
        }

        func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
            return true
        }

        func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
            print("This is the mode")
            print(mapView.zoomLevel)
            self.zoomLevel = mapView.zoomLevel
            self.annotation = DataForMap(
                title: self.annotation.title,
                location: CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude),
                projectId: self.annotation.projectId,
                stringName: self.annotation.stringName,
                stringAddress: self.annotation.stringAddress)
        }
    }
}

struct DataForMap: Identifiable {
    var id = UUID()
    var title: String
    var location: CLLocationCoordinate2D
    var projectId: Int
    var stringName: String
    var stringAddress: String
    var isProjectNear = false
    var icon = ""
}

extension MGLStyle {
    //    func addLines(from source: MGLShapeSource) {
    //        /**
    //         Configure a line style layer to represent a rail line, filtering out all data from the
    //         source that is not of Rail line type. The TYPE is an attribute of the source data
    //         that can be seen by inspecting the GeoJSON source file, for example:
    //
    //         {
    //         "type": "Feature",
    //         "properties": {
    //         "NAME": "Dupont Circle",
    //         "TYPE": "metro-station"
    //         },
    //         "geometry": {
    //         "type": "Point",
    //         "coordinates": [
    //         -77.043416,
    //         38.909605
    //         ]
    //         },
    //         "id": "994446c244acadeb15d3f9fc18278c73"
    //         }
    //         */
    //        let lineLayer = MGLLineStyleLayer(identifier: "rail-line", source: source)
    //        lineLayer.predicate = NSPredicate(format: "TYPE = 'Rail line'")
    //        lineLayer.lineColor = NSExpression(forConstantValue: UIColor.red)
    //        lineLayer.lineWidth = NSExpression(forConstantValue: 2)
    //
    //        self.addLayer(lineLayer)
    //    }

    //    func addPoints(from source: MGLShapeSource) {
    //        // Configure a circle style layer to represent rail stations, filtering out all data from
    //        // the source that is not of metro-station type.
    //        let circleLayer = MGLCircleStyleLayer(identifier: "stations", source: source)
    //        circleLayer.predicate = NSPredicate(format: "TYPE = 'metro-station'")
    //        circleLayer.circleColor = NSExpression(forConstantValue: UIColor.red)
    //        circleLayer.circleRadius = NSExpression(forConstantValue: 6)
    //        circleLayer.circleStrokeWidth = NSExpression(forConstantValue: 2)
    //        circleLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.black)
    //
    //        self.addLayer(circleLayer)
    //    }

    func addPolygons(from source: MGLShapeSource) {
        // Configure a fill style layer to represent polygon regions in Washington, D.C.
        // Source data that is not of neighborhood-region type will be excluded.
        let polygonLayer = MGLFillStyleLayer(identifier: "location_purple", source: source)
        polygonLayer.predicate = NSPredicate(format: "TYPE = 'neighborhood-region'")
        polygonLayer.fillColor = NSExpression(forConstantValue: UIColor(red: 109 / 255, green: 48 / 255, blue: 171 / 255, alpha: 0.14))
        polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor(red: 109 / 255, green: 48 / 255, blue: 171 / 255, alpha: 1))

        self.addLayer(polygonLayer)
    }
}

class CustomAnnotationView: MGLAnnotationView {
    var imgCallout = UIImageView()
    var label = UILabel()
    var labelAddress = UILabel()
    var view = UIView()
    var hightTemp: CGFloat = 20

    required init(reuseIdentifier: String?, title: String?, adress: String?, projectId: Int?, levelZoom: CGFloat) {
        super.init(reuseIdentifier: reuseIdentifier)
        print("levelZoom")
        print(levelZoom)
        hightTemp = levelZoom >= 0 && levelZoom <= 10 ? 0:
            levelZoom >= 11 && levelZoom < ZOOM_DEFAULT ? 8 : 20

        view.frame = CGRect(
            x: levelZoom >= ZOOM_DEFAULT ? W(-333 / 2) : (levelZoom < 1 ? 0:
        W((CGFloat(-333 / 2) * levelZoom) / ZOOM_DEFAULT)),
            y: levelZoom >= ZOOM_DEFAULT ? H(-67 - hightTemp) : (levelZoom < 1 ? 0:
        H((CGFloat(-67) * levelZoom) / ZOOM_DEFAULT) - hightTemp),
            width: levelZoom >= ZOOM_DEFAULT ? W(333) : (levelZoom < 1 ? 0:
        W((CGFloat(333) * levelZoom) / ZOOM_DEFAULT)),
            height: levelZoom >= ZOOM_DEFAULT ? H(67) : (levelZoom < 1 ? 0:
        H((CGFloat(67) * levelZoom) / ZOOM_DEFAULT))
        )
        view.backgroundColor = UIColor.clear
        imgCallout.image = UIImage(named: "bubleMap")
        imgCallout.frame = view.bounds
        label.frame = CGRect(
            x: 0,
            y: levelZoom >= ZOOM_DEFAULT ? H(10) : (levelZoom < 1 ? 0:
        H((CGFloat(10) * levelZoom) / ZOOM_DEFAULT)),
            width: view.bounds.width,
            height: levelZoom >= ZOOM_DEFAULT ? H(19) : (levelZoom < 1 ? 0:
        H((CGFloat(19) * levelZoom) / ZOOM_DEFAULT)))
        label.textColor = #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)
        label.font = UIFont(name: BOLD, size: levelZoom >= ZOOM_DEFAULT ? 16 : (levelZoom < 1 ? 0:
        (CGFloat(16) * levelZoom) / ZOOM_DEFAULT))
        label.text = title
        label.textAlignment = .center

        labelAddress.frame = CGRect(
            x: levelZoom >= ZOOM_DEFAULT ? W(6) : (levelZoom < 1 ? 0:
        W((CGFloat(6) * levelZoom) / ZOOM_DEFAULT)),
            y: levelZoom >= ZOOM_DEFAULT ? H(30) : (levelZoom < 1 ? 0:
        H((CGFloat(30) * levelZoom) / ZOOM_DEFAULT)),
            width: view.bounds.width - (levelZoom >= ZOOM_DEFAULT ? W(6) : (levelZoom < 1 ? 0:
        W((CGFloat(6) * levelZoom) / ZOOM_DEFAULT))),
            height: levelZoom >= ZOOM_DEFAULT ? H(19) : (levelZoom < 1 ? 0:
        H((CGFloat(19) * levelZoom) / ZOOM_DEFAULT)))
        labelAddress.textColor = #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1)
        labelAddress.font = UIFont(
            name: ITALIC,
            size: levelZoom >= ZOOM_DEFAULT ? 14 : (levelZoom < 1 ? 0:
        (CGFloat(14) * levelZoom) / ZOOM_DEFAULT))
        labelAddress.text = adress
        labelAddress.textAlignment = .center

        view.isUserInteractionEnabled = true
//        view.layer.shadowColor = .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921))
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(
//            width: levelZoom >= ZOOM_DEFAULT ? W(2) : (levelZoom < 1 ? 0 :
//                W((CGFloat(2) * levelZoom) / ZOOM_DEFAULT)),
//            height: levelZoom >= ZOOM_DEFAULT ? H(2) : (levelZoom < 1 ? 0 :
//                H((CGFloat(2) * levelZoom) / ZOOM_DEFAULT)))
//        view.layer.shadowRadius = levelZoom >= ZOOM_DEFAULT ? W(2) : (levelZoom < 1 ? 0 :
//            W((CGFloat(2) * levelZoom) / ZOOM_DEFAULT))
        view.layer.zPosition = 0

        self.isUserInteractionEnabled = true
        if title != nil && title != "" {
            view.addSubview(imgCallout)
            view.addSubview(label)
            view.addSubview(labelAddress)
        }
        self.addSubview(self.view)
    }
    required init(reuseIdentifier: String?, title: String?, projectId: Int?, levelZoom: CGFloat) {
        super.init(reuseIdentifier: reuseIdentifier)

        hightTemp = levelZoom >= 0 && levelZoom <= 10 ? 0:
            levelZoom >= 11 && levelZoom < ZOOM_DEFAULT ? 8 : 20

        view.frame = CGRect(
            x: levelZoom >= ZOOM_DEFAULT ? W(-148 / 2) : (levelZoom < 1 ? 0:
        W((CGFloat(-148 / 2) * levelZoom) / ZOOM_DEFAULT)),
            y: levelZoom >= ZOOM_DEFAULT ? H(-57 - hightTemp) : (levelZoom < 1 ? 0:
        H((CGFloat(-57) * levelZoom) / ZOOM_DEFAULT) - hightTemp),
            width: levelZoom >= ZOOM_DEFAULT ? W(148) : (levelZoom < 1 ? 0:
        W((CGFloat(148) * levelZoom) / ZOOM_DEFAULT)),
            height: levelZoom >= ZOOM_DEFAULT ? H(57) : (levelZoom < 1 ? 0:
        H((CGFloat(57) * levelZoom) / ZOOM_DEFAULT)))

        view.backgroundColor = UIColor.clear
        imgCallout.image = UIImage(named: "bubleMap")
        imgCallout.frame = view.bounds
        label.frame = CGRect(
            x: 0,
            y: levelZoom >= ZOOM_DEFAULT ? H(26) : (levelZoom < 1 ? 0:
        H((CGFloat(16) * levelZoom) / ZOOM_DEFAULT)),

            width: view.bounds.width,
            height: levelZoom >= ZOOM_DEFAULT ? H(19) : (levelZoom < 1 ? 0:
        H((CGFloat(19) * levelZoom) / ZOOM_DEFAULT)))
        label.textColor = #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)
        label.font = UIFont(
            name: BOLD,
            size: levelZoom >= ZOOM_DEFAULT ? 16 : (levelZoom < 1 ? 0:
        (CGFloat(16) * levelZoom) / ZOOM_DEFAULT))
        label.text = title
        label.textAlignment = .center

        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
//        view.layer.shadowColor = .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921))
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(
//            width: levelZoom >= ZOOM_DEFAULT ? W(2) : (levelZoom < 1 ? 0 :
//                W((CGFloat(2) * levelZoom) / ZOOM_DEFAULT)),
//            height: levelZoom >= ZOOM_DEFAULT ? H(2) : (levelZoom < 1 ? 0 :
//                H((CGFloat(2) * levelZoom) / ZOOM_DEFAULT)))
//        view.layer.shadowRadius = levelZoom >= ZOOM_DEFAULT ? W(2) : (levelZoom < 1 ? 0 :
//            W((CGFloat(2) * levelZoom) / ZOOM_DEFAULT))
        view.layer.zPosition = 1

        self.isUserInteractionEnabled = true
        if title != nil && title != "" {
            view.addSubview(imgCallout)
            view.addSubview(label)
        }
        self.addSubview(self.view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
