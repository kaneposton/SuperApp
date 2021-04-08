// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import SwiftUI
import UIKit

public struct PullToRefresh: UIViewRepresentable {
    let action: () -> Void
    @Binding var isShowing: Bool

    public init (action: @escaping () -> Void, isShowing: Binding<Bool>) {
        self.action = action
        self._isShowing = isShowing
    }

    public class Coordinator: NSObject, UIScrollViewDelegate {
        let action: () -> Void
        @Binding var isShowing: Bool
        var endScrolling: CGFloat = 0

        init (action: @escaping () -> Void, isShowing: Binding<Bool>) {
            self.action = action
            self._isShowing = isShowing
        }
        @objc func onValueChanged() {
            self.$isShowing.wrappedValue = true
            action()
        }
    }

    public func makeUIView(context: UIViewRepresentableContext<PullToRefresh>) -> UIView {
        return UIView(frame: .zero)
    }

    private func tableview(root: UIView) -> UITableView? {
        for subview in root.subviews {
            if let tableView = subview as? UITableView {
                return tableView
            } else if let tableView = tableview(root: subview) {
                return tableView
            }
        }
        return nil
    }

    private func scrollView(root: UIView, context: Context) -> UIScrollView? {
        for subview in root.subviews {
            if let scroll = subview as? UIScrollView {
                scroll.delegate = context.coordinator
                return scroll
            } else if let scroll = scrollView(root: subview, context: context) {
                scroll.delegate = context.coordinator
                return scroll
            }
        }
        return nil
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PullToRefresh>) {
        guard let viewHost = uiView.superview?.superview else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let tableView = self.tableview(root: viewHost) else { return }

            if let refreshControl = tableView.refreshControl {
                if self.isShowing {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
                return
            }

            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }

    public func makeCoordinator() -> PullToRefresh.Coordinator {
        return Coordinator(action: action, isShowing: $isShowing)
    }
}
