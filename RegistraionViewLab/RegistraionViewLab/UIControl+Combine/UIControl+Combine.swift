//
//  UIControl+.swift
//  RegistraionViewLab
//
//  Created by 김도연 on 2022/06/09.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String,Never> {
        publisher(for: .editingChanged)
            .map { ($0 as! Self).text! }
            .eraseToAnyPublisher()
    }
}

extension UIControl {
    fileprivate class EventControlSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?

        init(control: UIControl, event: UIControl.Event, subscriber: EventSubscriber) {
            self.control = control
            self.event = event
            self.subscriber = subscriber

            control.addTarget(self, action: #selector(eventRaised), for: event)
        }

        func request(_ demand: Subscribers.Demand) {
            // empty
        }

        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventRaised), for: event)
        }

        @objc func eventRaised() {
            _ = subscriber?.receive(control)
        }
    }

    struct EventControlPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never

        let control: UIControl
        let controlEvent: UIControl.Event

        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventControlSubscription(control: control, event: controlEvent, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }

    func publisher(for event: UIControl.Event) -> UIControl.EventControlPublisher {
        return UIControl.EventControlPublisher(control: self, controlEvent: event)
    }
}


