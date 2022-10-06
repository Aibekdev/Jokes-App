//
//  CustomNavigationController.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum NavigationBarItemType {
    case view(UIView)
    case backButton
}

protocol ViewProtocol: AnyObject {
    var navigationBarItem: NavigationBarItemType { get }
    var titleLabel: String? { get }
    var leftNavBarButtonTitle: String? { get }
    var leftNavBarButtonImage: String? { get }
    var isHeaderHidden: Bool { get }
    var isRightButtonHidden: Bool { get }
    var rightNavigationButtonTitle: String { get }
    var rightNavBarButtonImage: UIImage? { get }
    var rightButtonHandler: (() -> Void)? { get }
}

class CustomNavigationController: UIViewController, BaseViewControllerDelegate {
    
    // MARK: - Consts
    private enum Consts {
        static let backButton = UIImage(named: "back_button_image")
    }
    
    // MARK: - Outlets
    private lazy var welcomeScreenNavigation: UIView = {
        let welcomeScreenNavigation = UIView()
        return welcomeScreenNavigation
    }()
    
    private lazy var welcomeScreenNavigationBottomBorder: UIView = {
        let welcomeScreenNavigationBottomBorder = UIView()
        return welcomeScreenNavigationBottomBorder
    }()
    
    private lazy var customTitle: UILabel = {
        let customTitle = UILabel()
        customTitle.text = .empty
        customTitle.font = UIFont.systemFont(ofSize: 17)
        customTitle.textAlignment = .center
        return customTitle
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        let backButtonImage = Consts.backButton
        backButton.setImage(backButtonImage, for: .normal)
        return backButton
    }()
    
    private lazy var leftViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private lazy var rightNavigationButton: UIButton = {
        let rightNavigationButton = UIButton(type: .system)
        rightNavigationButton.layer.cornerRadius = 4
        rightNavigationButton.setTitle(.empty, for: .normal)
        rightNavigationButton.setTitleColor(.customGray, for: .normal)
        rightNavigationButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return rightNavigationButton
    }()
    
    /// Main screen
    private let viewContentContainer = UIView()
    /// For controller changing
    private let contentNavigationContoller = UINavigationController()
    private var rightButtonHandler: (() -> Void)?
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
    }
    
    // MARK: - Methods
    func loadController(with contentController: BaseViewController) {
        contentController.delegate = self
        self.contentNavigationContoller.pushViewController(contentController, animated: true)
    }
    
    func updateUI(controller: BaseViewController) {
        self.customTitle.text = controller.titleLabel
        
        self.rightNavigationButton.setTitle(controller.rightNavigationButtonTitle, for: .normal)
        self.rightNavigationButton.setImage(controller.rightNavBarButtonImage, for: .normal)
        self.rightNavigationButton.isHidden = controller.isRightButtonHidden
        self.rightButtonHandler = controller.rightButtonHandler
        
        self.updateNavigateionBarItem(for: controller)
        self.updateConstraints(for: controller)
    }
    
    private func updateNavigateionBarItem(for controller: BaseViewController) {
        switch controller.navigationBarItem {
        case .view(let view):
            self.backButton.isHidden = true
            self.leftViewContainer.isHidden = false
            self.leftViewContainer.subviews.forEach { $0.removeFromSuperview() }
            self.leftViewContainer.addSubview(view)
            view.stretchLayout()
        case .backButton:
            self.leftViewContainer.isHidden = true
            self.backButton.isHidden = false
        }
    }
    
    private func updateConstraints(for controller: BaseViewController) {
        self.welcomeScreenNavigation.snp.updateConstraints { maker in
            maker.height.equalTo(controller.isHeaderHidden ? 0 : 60)
        }
        self.welcomeScreenNavigationBottomBorder.snp.updateConstraints { maker in
            maker.height.equalTo(controller.isHeaderHidden ? 0 : 0.5)
        }
    }
    
    private func setupSubviews() {
        view.addSubview(welcomeScreenNavigation)
        welcomeScreenNavigation.backgroundColor = .white
        welcomeScreenNavigation.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(60)
        }
        
        view.addSubview(viewContentContainer)
        viewContentContainer.addSubview(contentNavigationContoller.view)
        viewContentContainer.snp.makeConstraints { maker in
            maker.top.equalTo(welcomeScreenNavigation.snp.bottom)
            maker.bottom.leading.trailing.equalToSuperview()
        }
        
        contentNavigationContoller.isNavigationBarHidden = true
        contentNavigationContoller.view.snp.makeConstraints {maker in
            maker.top.equalTo(welcomeScreenNavigation.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        welcomeScreenNavigation.addSubview(welcomeScreenNavigationBottomBorder)
        welcomeScreenNavigationBottomBorder.backgroundColor = .customGray
        welcomeScreenNavigationBottomBorder.snp.makeConstraints{ maker in
            maker.leading.trailing.bottom.equalTo(welcomeScreenNavigation)
            maker.height.equalTo(0.5)
        }
        
        welcomeScreenNavigation.addSubview(backButton)
        backButton.snp.makeConstraints { maker in
            maker.top.equalTo(welcomeScreenNavigation).offset(7.5)
            maker.leading.equalTo(welcomeScreenNavigation.snp.leading).offset(15)
            maker.height.equalTo(45)
            maker.width.equalTo(45)
        }
        
        welcomeScreenNavigation.addSubview(self.leftViewContainer)
        welcomeScreenNavigation.addSubview(self.customTitle)
        welcomeScreenNavigation.addSubview(self.rightNavigationButton)
        
        self.customTitle.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        self.leftViewContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().inset(7.5)
            make.leading.equalTo(15)
            make.trailing.equalTo(self.customTitle.snp.leading).inset(15)
        }
        
        self.rightNavigationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().inset(7.5)
            make.trailing.equalToSuperview().inset(15)
            make.leading.greaterThanOrEqualTo(self.customTitle.snp.trailing).offset(15)
        }
    }
    
    private func setupBindings() {
        self.backButton.rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { weakSelf, _ in
                weakSelf.contentNavigationContoller.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
        
        self.rightNavigationButton.rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { weakSelf, _ in
                weakSelf.rightButtonHandler?()
            })
            .disposed(by: self.disposeBag)
    }
}
