//
//  BaseViewController.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol BaseViewControllerDelegate: AnyObject {
    func loadController(with contentController: BaseViewController)
    func updateUI(controller: BaseViewController)
}

class BaseViewController: UIViewController, ViewProtocol {
    
    // MARK: - Properties
    var navigationBarItem: NavigationBarItemType { return .backButton }
    var isHeaderHidden: Bool { return false }
    var titleLabel: String? { return .empty }
    var rightNavigationButtonTitle: String { return .empty }
    var rightNavBarButtonImage: UIImage? { return nil }
    var leftNavBarButtonTitle: String? { return .empty }
    var leftNavBarButtonImage: String? { return .empty }
    var isRightButtonHidden: Bool { return true }
    var rightButtonHandler: (() -> Void)? { return nil }
    
    // MARK: - Delegate
    weak var delegate: BaseViewControllerDelegate?
    
    // MARK: - Override
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate?.updateUI(controller: self)
    }
}
