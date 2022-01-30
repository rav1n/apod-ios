//
//  APODViewControllerTests.swift
//  APODTests
//
//  Created by Chouhan Ravindra on 30/01/22.
//

import XCTest
@testable import APOD

class APODViewControllerTests: XCTestCase {
    var sut: APODViewController!
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        sut = (storyboard.instantiateInitialViewController() as? APODViewController)

        sut.loadViewIfNeeded()

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testViewControllerCanDisplayAPODwithInformation() {
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.explanationLabel)
    }

    func testViewControllerHasImageViewConfigured() {
        XCTAssertEqual(sut.imageView.contentMode, .scaleAspectFit)
    }

    func testViewControllerHasExplanationTextConfigure() {
        XCTAssertFalse(sut.explanationLabel.isEditable)
    }
}
