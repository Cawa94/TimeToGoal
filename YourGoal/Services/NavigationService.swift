//
//  NavigationService.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

struct NavigationService: UIViewControllerRepresentable {

    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationService>) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationService>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
