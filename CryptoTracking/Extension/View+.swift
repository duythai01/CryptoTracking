//
//  View+.swift
//  CryptoTracking
//
//  Created by DuyThai on 27/10/2023.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
           clipShape( RoundedCorner(radius: radius, corners: corners) )
       }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func onTouchPosition(perform: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(TouchLocater(perform: perform))
    }
}

struct TouchLocatingView: UIViewRepresentable {
    // The types of touches users want to be notified about
    struct TouchType: OptionSet {
        let rawValue: Int

        static let started = TouchType(rawValue: 1 << 0)
        static let moved = TouchType(rawValue: 1 << 1)
        static let ended = TouchType(rawValue: 1 << 2)
        static let all: TouchType = [.started, .moved, .ended]
    }

    // A closure to call when touch data has arrived
    var onUpdate: (CGPoint) -> Void

    var limitToBounds = true

    func makeUIView(context: Context) -> TouchLocatingUIView {
        let view = TouchLocatingUIView()
        view.onUpdate = self.onUpdate
        return view
    }

    func updateUIView(_ uiView: TouchLocatingUIView, context: Context) {
    }

    class TouchLocatingUIView: UIView {
        var onUpdate: ((CGPoint) -> Void)?
        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

            self.addGestureRecognizer(tapGesture)
        }
        @objc private func handleTap(sender: UITapGestureRecognizer) {
            let tapLocation = sender.location(in: sender.view)
            self.onUpdate?(tapLocation)
        }
        // Just in case you're using storyboards!
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true
        }

    }
}

struct TouchLocater: ViewModifier {
    var type: TouchLocatingView.TouchType = .all
    var limitToBounds = true
    let perform: (CGPoint) -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                TouchLocatingView(onUpdate: perform)
            )
    }
}


