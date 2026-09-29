# ServiceBooking iOS

A compact UIKit reference application demonstrating production-oriented iOS structure without SwiftUI.

## Stack
Swift, UIKit, MVVM, Coordinator, URLSession, async/await, Core Data-ready repository boundary, XCTest.

## Features
- Programmatic UIKit UI
- Service catalogue with debounced search
- Pull to refresh and pagination-ready repository API
- Detail and favorites flows
- Dependency injection and coordinator navigation
- Typed networking errors
- Unit-testable view models

## Setup
Create an iOS App target named `ServiceBooking` in Xcode (iOS 16+), add the files under `ServiceBooking/`, and include the test files in `ServiceBookingTests`. No secrets are required; the sample uses DummyJSON products as service catalogue data.

## Architecture
`Feature -> ViewModel -> Repository -> APIClient`

The domain layer owns models and repository contracts. UI code does not know how remote data is fetched. This keeps networking replaceable and view models deterministic in tests.
