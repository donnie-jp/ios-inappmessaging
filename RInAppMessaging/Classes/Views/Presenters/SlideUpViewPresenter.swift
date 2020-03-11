internal class SlideUpViewPresenter: BaseViewPresenter {

    weak var view: SlideUpViewType?

    override func viewDidInitialize() {
        guard let direction = campaign.data.messagePayload.messageSettings.displaySettings.slideFrom else {
            CommonUtility.debugPrint("InAppMessaging: Error constructing a SlideUpView.")
            return
        }

        let messagePayload = campaign.data.messagePayload
        let viewModel = SlideUpViewModel(slideDirection: direction,
                                         backgroundColor: UIColor(fromHexString: messagePayload.backgroundColor) ?? .white,
                                         messageBody: messagePayload.messageBody,
                                         messageBodyColor: UIColor(fromHexString: messagePayload.messageBodyColor) ?? .black)
        view?.initializeView(viewModel: viewModel)
    }

    func didClickContent() {
        let campaignContent = campaign.data.messagePayload.messageSettings.controlSettings?.content

        if campaignContent?.onClickBehavior.action != .close {
            guard let uri = campaignContent?.onClickBehavior.uri,
                let uriToOpen = URL(string: uri),
                UIApplication.shared.canOpenURL(uriToOpen) else {

                view?.showAlert(title: "dialog_alert_invalidURI_title".localized,
                                message: "dialog_alert_invalidURI_message".localized,
                                style: .alert,
                                actions: [
                                    UIAlertAction(title: "dialog_alert_invalidURI_close".localized,
                                                  style: .default,
                                                  handler: nil)
                ])
                return
            }

            UIApplication.shared.open(uriToOpen, options: [:], completionHandler: nil)
        }

        view?.dismiss()

        logImpression(type: .clickContent)
        sendImpressions()

        // If the button came with a campaign trigger, log it.
        handleButtonTrigger(campaignContent?.campaignTrigger)
    }

    func didClickExitButton() {
        view?.dismiss()

        logImpression(type: .exit)
        sendImpressions()
    }
}
