//
//  Rotation.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

struct Rotation {
    override open var shouldAutorotate: Bool {
        return false
    }

    extension UINavigationController {
        
        override open var shouldAutorotate: Bool {
            get {
                if let visibleVC = visibleViewController {
                    return visibleVC.shouldAutorotate
                }
                return super.shouldAutorotate
            }
        }
        
        override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
            get {
                if let visibleVC = visibleViewController {
                    return visibleVC.preferredInterfaceOrientationForPresentation
                }
                return super.preferredInterfaceOrientationForPresentation
            }
        }
        
        override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            get {
                if let visibleVC = visibleViewController {
                    return visibleVC.supportedInterfaceOrientations
                }
                return super.supportedInterfaceOrientations
            }
        }
    }


}
