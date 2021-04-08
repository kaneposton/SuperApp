// ASCollectionView. Created by Apptek Studios 2019
import UIKit

class AlignedFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            layoutAttributesForItem(at: layoutAttribute.indexPath).map { layoutAttribute.frame = $0.frame }
        }

        return attributes
    }

    private var leftEdge: CGFloat {
        guard let insets = collectionView?.adjustedContentInset else {
            return sectionInset.left
        }
        return insets.left + sectionInset.left
    }

    private var contentWidth: CGFloat? {
        guard let collectionViewWidth = collectionView?.frame.size.width,
            let insets = collectionView?.adjustedContentInset else {
                return nil
        }
        return collectionViewWidth - insets.left - insets.right - sectionInset.left - sectionInset.right
    }

    fileprivate func isFrame(for firstItemAttributes: UICollectionViewLayoutAttributes, inSameLineAsFrameFor secondItemAttributes: UICollectionViewLayoutAttributes) -> Bool {
        guard let lineWidth = contentWidth else {
            return false
        }
        let firstItemFrame = firstItemAttributes.frame
        let lineFrame = CGRect(
            x: leftEdge,
            y: firstItemFrame.origin.y,
            width: lineWidth,
            height: firstItemFrame.size.height)
        return lineFrame.intersects(secondItemAttributes.frame)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        guard attributes.representedElementCategory == .cell else {
            return attributes
        }
        guard
        indexPath.item > 0,
            let previousAttributes = layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))
            else {
                attributes.frame.origin.x = leftEdge // first item of the section should always be left aligned
                return attributes
        }

        if isFrame(for: attributes, inSameLineAsFrameFor: previousAttributes) {
            attributes.frame.origin.x = previousAttributes.frame.maxX + minimumInteritemSpacing
        } else {
            attributes.frame.origin.x = leftEdge
        }

        return attributes
    }
}


@available(iOS 13.0, *)
class ASDiffableDataSourceTableView<SectionID: Hashable>: ASDiffableDataSource<SectionID>, UITableViewDataSource
{
	/// The type of closure providing the cell.
	public typealias Snapshot = ASDiffableDataSourceSnapshot<SectionID>
	public typealias CellProvider = (UITableView, IndexPath, ASCollectionViewItemUniqueID) -> ASTableViewCell?

	private weak var tableView: UITableView?
	private let cellProvider: CellProvider

	public init(tableView: UITableView, cellProvider: @escaping CellProvider)
	{
		self.tableView = tableView
		self.cellProvider = cellProvider
		super.init()

		tableView.dataSource = self
	}

	/// The default animation to updating the views.
	public var defaultRowAnimation: UITableView.RowAnimation = .automatic

	private var firstLoad: Bool = true
	private var canRefreshSizes: Bool = false

	func applySnapshot(_ newSnapshot: Snapshot, animated: Bool = true, completion: (() -> Void)? = nil)
	{
		guard let tableView = tableView else { return }

		firstLoad = false

		let changeset = StagedChangeset(source: currentSnapshot.sections, target: newSnapshot.sections)
		let shouldDisableAnimation = firstLoad || !animated

		CATransaction.begin()
		if shouldDisableAnimation
		{
			CATransaction.setDisableActions(true)
		}
		CATransaction.setCompletionBlock { [weak self] in
			self?.canRefreshSizes = true
			completion?()
		}
		tableView.reload(using: changeset, with: shouldDisableAnimation ? .none : .automatic) { newSections in
			self.currentSnapshot = .init(sections: newSections)
		}
		CATransaction.commit()
	}

	func updateCellSizes(animated: Bool = true)
	{
		guard let tableView = tableView, canRefreshSizes, !tableView.visibleCells.isEmpty else { return }
		CATransaction.begin()
		if !animated
		{
			CATransaction.setDisableActions(true)
		}
		tableView.performBatchUpdates(nil, completion: nil)

		CATransaction.commit()
	}

	func numberOfSections(in tableView: UITableView) -> Int
	{
		currentSnapshot.sections.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		currentSnapshot.sections[section].elements.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let itemIdentifier = identifier(at: indexPath)
		guard let cell = cellProvider(tableView, indexPath, itemIdentifier) else
		{
			fatalError("ASTableView dataSource returned a nil cell for row at index path: \(indexPath), tableView: \(tableView), itemIdentifier: \(itemIdentifier)")
		}
		return cell
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	{
		true
	}
}
