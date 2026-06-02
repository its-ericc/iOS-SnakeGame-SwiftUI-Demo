//
//  PortraitHostingController.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/13/25.
//


//import SwiftUI
//import UIKit
//
///// A UIHostingController that *only* allows portrait.
//class PortraitHostingController<Content: View>: UIHostingController<Content> {
//  override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
//  override var shouldAutorotate: Bool { false }
//  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { .portrait }
//}
//
///// A wrapper that embeds the above in a UINavigationController
///// and forces full-screen presentation.
//struct PortraitLockedSnakeGameView: UIViewControllerRepresentable {
//  func makeUIViewController(context: Context) -> UIViewController {
//    // 1) Host your SwiftUI SnakeGameView
//    let hosted = PortraitHostingController(rootView: SnakeGameView())
//    
//    // 2) Embed in a nav controller (so it's a "real" VC to UIKit)
//    let nav = UINavigationController(rootViewController: hosted)
//    nav.setNavigationBarHidden(true, animated: false)
//    
//    // 3) Force full-screen so .supportedInterfaceOrientations is honoured
//    nav.modalPresentationStyle = .fullScreen
//    return nav
//  }
//
//  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//    // no-op
//  }
//}
