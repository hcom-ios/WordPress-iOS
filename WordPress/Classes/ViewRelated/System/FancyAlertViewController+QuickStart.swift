extension FancyAlertViewController {
    private struct Strings {
        static let titleText = NSLocalizedString("Want a little help getting started?", comment: "Title of alert asking if users want to try out the quick start checklist.")
        static let bodyText = NSLocalizedString("Our Quick Start checklist walks you through the basics of setting up a new website.", comment: "Body text of alert asking if users want to try out the quick start checklist.")
        static let allowButtonText = NSLocalizedString("Yes", comment: "Allow button title shown in alert asking if users want to try out the quick start checklist.")
        static let notNowText = NSLocalizedString("Not This Time", comment: "Not this time button title shown in alert asking if users want to try out the quick start checklist.")
        static let neverText = NSLocalizedString("Never", comment: "Never button title shown in alert asking if users want to try out the quick start checklist.")
    }

    private struct Analytics {
        static let locationKey = "location"
        static let alertKey = "alert"
    }

    /// Create the fancy alert controller for the notification primer
    ///
    /// - Parameter approveAction: block to call when approve is tapped
    /// - Returns: FancyAlertViewController of the primer
    @objc static func makeQuickStartAlertController() -> FancyAlertViewController {

        let allowButton = ButtonConfig(Strings.allowButtonText) { controller, _ in
            controller.dismiss(animated: true)
        }

        let notNowButton = ButtonConfig(Strings.notNowText) { controller, _ in
            controller.dismiss(animated: true)
        }

        let neverButton = ButtonConfig(Strings.neverText) { controller, _ in
            UserDefaults.standard.quickStartWasDismissedPermanently = true
            controller.dismiss(animated: true)
        }

        let image = UIImage(named: "wp-illustration-checklist")

        let config = FancyAlertViewController.Config(titleText: Strings.titleText,
                                                     bodyText: Strings.bodyText,
                                                     headerImage: image,
                                                     dividerPosition: .bottom,
                                                     defaultButton: allowButton,
                                                     cancelButton: notNowButton,
                                                     neverButton: neverButton,
                                                     appearAction: {},
                                                     dismissAction: {})

        let controller = FancyAlertViewController.controllerWithConfiguration(configuration: config)
        return controller
    }
}
