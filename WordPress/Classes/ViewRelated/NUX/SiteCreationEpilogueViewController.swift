import UIKit
import WordPressAuthenticator


class SiteCreationEpilogueViewController: NUXViewController {

    // MARK: - Properties

    var siteToShow: Blog?

    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - ButtonViewController

    @IBOutlet private var buttonViewContainer: UIView! {
        didSet {
            buttonViewController.move(to: self, into: buttonViewContainer)
        }
    }

    private lazy var buttonViewController: NUXButtonViewController = {
        let buttonViewController = NUXButtonViewController.instance()
        buttonViewController.delegate = self
        buttonViewController.setButtonTitles(primary: ButtonTitles.primary, secondary: ButtonTitles.secondary)
        return buttonViewController
    }()


    // MARK: - View

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let vc = segue.destination as? SiteCreationSitePreviewViewController {
            vc.siteUrl = siteToShow?.url
        }
    }
}

// MARK: - NUXButtonViewControllerDelegate

extension SiteCreationEpilogueViewController: NUXButtonViewControllerDelegate {

    // 'Write first post' button
    func primaryButtonPressed() {
        WPTabBarController.sharedInstance().showPostTab { [weak self] in
            self?.showQuickStartAlert()
        }
        navigationController?.dismiss(animated: true, completion: nil)
    }

    // 'Configure' button
    func secondaryButtonPressed() {
        if let siteToShow = siteToShow {
            WPTabBarController.sharedInstance().switchMySitesTabToBlogDetails(for: siteToShow)
        }
        navigationController?.dismiss(animated: true) { [weak self] in
            self?.showQuickStartAlert()
        }
    }

    private func showQuickStartAlert() {
        guard !UserDefaults.standard.quickStartWasDismissedPermanently else {
            return
        }

        guard let siteToShow = siteToShow, let tabBar = WPTabBarController.sharedInstance() else {
            return
        }

        tabBar.switchMySitesTabToBlogDetails(for: siteToShow)
        let fancyAlert = FancyAlertViewController.makeQuickStartAlertController()
        fancyAlert.modalPresentationStyle = .custom
        fancyAlert.transitioningDelegate = tabBar
        tabBar.present(fancyAlert, animated: true, completion: nil)
    }
}


private extension SiteCreationEpilogueViewController {
    enum ButtonTitles {
        static let primary = NSLocalizedString("Write first post", comment: "On the final site creation page, button to allow the user to write a post for the newly created site.")
        static let secondary = NSLocalizedString("Configure", comment: "Button to allow the user to dismiss the final site creation page.")
    }
}
