//
//  SLNotificationaService.swift
//  SLNotificationServiceInterface
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation

public protocol SLNotificationsService {
    func addObserver(_ observer: Any, selector: Selector, name key: Notification.Name, object: Any?)
    func removeObserver(_ observer: Any, name key: Notification.Name, object: Any?)
    func post(name key: Notification.Name, object: Any?, userInfo: [AnyHashable : Any]?)
}