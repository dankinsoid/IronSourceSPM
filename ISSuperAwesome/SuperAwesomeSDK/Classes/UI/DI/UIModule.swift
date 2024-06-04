//
//  UIModule.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 06/11/2020.
//

class UIModule: DependencyModule {
    func register(_ container: DependencyContainer) {
        container.factory(ViewableDetectorType.self) { _, _ in
            ViewableDetector() }
        container.single(AdControllerType.self) { _, _ in AdController() }
        container.factory(ParentalGate.self) { innerContainer, _ in
            ParentalGate(numberGenerator: innerContainer.resolve(), stringProvider: innerContainer.resolve()) }
    }
}
