//
//  IdGenerator.swift
//  SuperAwesome
//
//  Created by Gunhan Sancar on 20/04/2020.
//

protocol IdGeneratorType {
    var uniqueDauId: Int { get }
}

class IdGenerator: IdGeneratorType {
    struct Keys {
        static let dauLength = 32
    }

    private var preferencesRepository: PreferencesRepositoryType
    private let sdkInfo: SdkInfoType
    private let numberGenerator: NumberGeneratorType
    private let dateProvider: DateProviderType

    lazy var uniqueDauId: Int = { findDauId() }()

    init(preferencesRepository: PreferencesRepositoryType,
         sdkInfo: SdkInfoType,
         numberGenerator: NumberGeneratorType,
         dateProvider: DateProviderType) {
        self.preferencesRepository = preferencesRepository
        self.sdkInfo = sdkInfo
        self.numberGenerator = numberGenerator
        self.dateProvider = dateProvider
    }

    private func findDauId() -> Int {
        let firstPart = dateProvider.nowAsMonthYear()
        let secondPart = preferencesRepository.dauUniquePart ?? generateAndSavePartOfDau()
        let thirdPart = sdkInfo.bundle

        return firstPart.hash ^ secondPart.hash ^ thirdPart.hash
    }

    private func generateAndSavePartOfDau() -> String {
        let generatedNumber = numberGenerator.nextAlphanumericString(length: Keys.dauLength)
        preferencesRepository.dauUniquePart = generatedNumber
        return generatedNumber
    }
}
