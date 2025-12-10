//
//  ViewController.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 25/11/25.
//

import UIKit
import SnapKit
import SLCommonExtensions
import SLNotificationName
import SLNotificationService
import SLNotificationServiceInterface
import SLLocationManager
import SLCommonError
import SLStorage
import SLStorageInterface
import DSKit
import SLCommonImages
import SLNetworkManager

struct Retorno: Codable {
    let name: String?
}

class ViewController: UIViewController {

    var notification: SLNotificationsService = SLNotifications.shared
    var locationManager: LocationManagerLogic = LocationManager.shared
    var storage: StorageService = Storage.shared
    var localized = ErrorsKeys.Localized.self
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: SLImage.fromImage(.image))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        view.addSubview(image)
        view.addSubview(button)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(64)
            make.height.width.equalTo(48)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        storage.saveTemporary(key: .dataTemp, value: "Teste")
        let title = storage.fetchTemporary(model: String.self, key: .dataTemp)
        button.setTitle(title, for: .normal)
        
        storage.deleteKeychain(key: .dataKey)
        if storage.fetchKeychain(model: String.self, key: .dataKey) == nil {
            storage.saveKeychain(key: .dataKey, value: localized.errorDefault.string())
        }

        notification.addObserver(self, selector: #selector(notificationTeste(_:)), name: .loadingWindow, object: nil)
    }

    @objc func notificationTeste(_ notification: Notification) {
        guard let notificationResponse = notification.userInfo?["response"] as? String else { return }
        
        //networkManagerWithRequest() { result in }
        
        networkManagerWithRequestProtocol() { result in }
        
        requestAuthorizationLocation(notificationResponse)
    }
    
    @objc func didTap() {
        notification.post(name: .loadingWindow, object: self, userInfo: ["response": "Novo título botão"])
    }
    
    private func networkManagerWithRequestProtocol(completion: @escaping (Result<NetworkResponse<Retorno>, NetworkError>) -> Void) {
        let request = DefaultRequest()
        NetworkManager.shared?.request(request, responseType: Retorno.self, completion: completion)
    }
    
    private func networkManagerWithRequest(completion: @escaping (Result<Retorno, NetworkError>) -> Void) {
        let request = NetworkRequest(
            endpoint: "/typicode/demo/profile",
            method: .get
        )
        
        NetworkManager.shared?.request(request, responseType: Retorno.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func requestAuthorizationLocation(_ title: String) {
        locationManager.requestAuthorization(true) { [weak self] granted in
            guard granted else {
                self?.openSettings()
                return
            }
            self?.button.setTitle(title, for: .normal)
        }
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            subscribeToNotificationCenter()
        }
    }

    private func subscribeToNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForegroundNotification),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    private func unsubscribeFromNotificationCenter() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func applicationWillEnterForegroundNotification() {
        unsubscribeFromNotificationCenter()
        requestAuthorizationLocation("Clique aqui")
    }
}

