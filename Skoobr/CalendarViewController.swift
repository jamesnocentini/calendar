import UIKit


class CalendarViewController: UIViewController, UICollectionViewDelegate {
    let viewModel: CalendarViewModel
    var collectionView: UICollectionView!
    var datesView: UICollectionView!
    var datesDataSource: DateDataSource!
    var propertiesView: UITableView!
    var contentView: UIView!
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override init() {
        self.viewModel = CalendarViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let ganttLayout = GanttLayout(bookings: viewModel.bookings)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(100, 100)
        let aCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView = aCollectionView
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CalendarBookingCell.self, forCellWithReuseIdentifier: String(NSStringFromClass(CalendarBookingCell)))
        collectionView.dataSource = viewModel.dataSource
        collectionView.delegate = self
        
        var context = 0
        viewModel.addObserver(self, forKeyPath: "dataSource", options: NSKeyValueObservingOptions.New, context: &context)
        
        let datesFlowLayout = UICollectionViewFlowLayout()
        datesFlowLayout.itemSize = CGSizeMake(CGFloat(ColumnWidth), 60)
        datesFlowLayout.minimumInteritemSpacing = 0.0
        datesFlowLayout.minimumLineSpacing = 0.0
        datesFlowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let aDatesView = UICollectionView(frame: self.view.frame, collectionViewLayout: datesFlowLayout)
        datesView = aDatesView
        datesView.backgroundColor = UIColor.whiteColor()
        datesView.registerClass(CalendarDateCell.self, forCellWithReuseIdentifier: "d")
        // FIXME: Todo with retain count. Have to keep the data as a property otherwise runtime error.
        datesDataSource = DateDataSource()
        datesView.dataSource = datesDataSource
        
        let aPropertiesView = UITableView(frame: CGRectZero)
        propertiesView = aPropertiesView
        propertiesView.backgroundColor = UIColor.whiteColor()
        propertiesView.rowHeight = CGFloat(RowHeight)
        
        view.addSubview(datesView)
        view.addSubview(collectionView)
        view.addSubview(propertiesView)
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        datesView.setTranslatesAutoresizingMaskIntoConstraints(false)
        propertiesView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let viewsDictionary = [
            "datesView": datesView,
            "collectionView": collectionView,
            "propertiesView": propertiesView,
            "topLayoutGuide": topLayoutGuide
        ]
        let datesView_constraint_V: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide][datesView(60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let datesView_constraint_H: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[datesView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let propertiesView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[propertiesView(150)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let propertiesView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[datesView]-0-[propertiesView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let view_constraint_V: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:[datesView]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let view_constraint_H: NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[propertiesView]-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        view.addConstraints(datesView_constraint_V)
        view.addConstraints(datesView_constraint_H)
        view.addConstraints(propertiesView_constraint_H)
        view.addConstraints(propertiesView_constraint_V)
        view.addConstraints(view_constraint_V)
        view.addConstraints(view_constraint_H)
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafeMutablePointer<Void>) {
        
        collectionView.dataSource = viewModel.dataSource
        collectionView.collectionViewLayout = GanttLayout(bookings: viewModel.bookings)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        
        propertiesView.dataSource = viewModel.propertyDataSource
        propertiesView.reloadData()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        datesView.contentOffset.x = collectionView.contentOffset.x
        propertiesView.contentOffset.y = collectionView.contentOffset.y
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

}


class CalendarNavigationController: UINavigationController {
    override init() {
        let cvc = CalendarViewController()
        cvc.title = "Calendar"
        cvc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: cvc, action: "logUserOut:")
        cvc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: cvc, action: "addBooking:")
        super.init(rootViewController: cvc)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}