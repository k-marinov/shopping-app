import UIKit
import RxSwift

class ProductDetailViewController: UIViewController, ModelableViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var additionalServicesLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private let disposeBag: DisposeBag = DisposeBag()
    private lazy var productDetailViewModel: ProductDetailViewModel = {
        return self.viewModel as! ProductDetailViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
        productDetailViewModel.loadProductDetail()
            .subscribe()
            .disposed(by: disposeBag)
        NotificationCenter.default.addObserver(
            self, selector: #selector(orientationChanged),
            name:  Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }

    deinit {
       NotificationCenter.default.removeObserver(self)
    }

    @objc func orientationChanged() {
        setUpCollectionViewLayout()
        view.layoutIfNeeded()
    }

    private func setUp() {
        setUpCollectionView()
        setUpTableView()
    }

    private func setUpCollectionView() {
        setUpCollectionViewDataSourceAndDelegate()
        setUpCollectionViewLayout()
    }

    private func setUpCollectionViewDataSourceAndDelegate() {
        collectionView.dataSource = productDetailViewModel.imageUrlsDataSource
        collectionView.delegate = productDetailViewModel.imageUrlsDelegate
    }

    private func setUpCollectionViewLayout() {
        collectionView.collectionViewLayout = collectionViewFlowLayout()
    }

    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let length = UIScreen.main.bounds.size.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: length, height: length)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }

    private func setUpTableView() {
        tableView.dataSource = productDetailViewModel.featuresDataSource
    }

    private func subscribe() {
        productDetailViewModel.reloadImageUrls
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.collectionView.reloadData()
                self?.pageControl.numberOfPages = count
            }).disposed(by: disposeBag)

        productDetailViewModel.reloadFeatures
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        productDetailViewModel.publishProductDetail
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] product in
                self?.setUp(product: product)
            }).disposed(by: disposeBag)

        productDetailViewModel.isLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isLoading)
            .disposed(by: disposeBag)

        productDetailViewModel.selectedPage()
            .bind { [weak self] pageNumber in
                self?.pageControl.currentPage = pageNumber
            }.disposed(by: disposeBag)
    }

    private func setUp(product: ProductResource) {
        setUpNavigationBarTitle(product.title)
        setUpPrice(product: product)
        setUpSpecialOffer(product: product)
        setUpAdditionalServicesLabel(product: product)
        setUpInformation(product: product)
        setCodeLabel(product: product)
    }

    private func setUpPrice(product: ProductResource) {
        priceLabel.text = product.priceNowFormatted()
    }

    private func setUpSpecialOffer(product: ProductResource) {
        specialOfferLabel.text = product.displaySpecialOffer
    }

    private func setUpAdditionalServicesLabel(product: ProductResource) {
        additionalServicesLabel.text = product.includedServicesFormatted()
    }

    private func setUpInformation(product: ProductResource) {
        informationLabel.attributedText = NSAttributedString(html: product.information())
    }

    private func setCodeLabel(product: ProductResource) {
        codeLabel.text = "Product code: \(product.code)"
    }

    private func setUpNavigationBarTitle(_ title: String) {
        navigationItem.title = title
    }
}
