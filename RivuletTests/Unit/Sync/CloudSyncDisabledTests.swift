// SPDX-License-Identifier: PolyForm-Noncommercial-1.0.0

import XCTest
@testable import Rivulet

/// Kai's build has no iCloud entitlement, and making the CloudKit container without it traps.
@MainActor
final class CloudSyncDisabledTests: XCTestCase {
    func test_isEnabled_staysOffWithTheSwitchSaved() {
        let defaults = UserDefaults.standard
        let saved = defaults.object(forKey: SyncCatalog.enabledKey)
        defer { defaults.set(saved, forKey: SyncCatalog.enabledKey) }

        defaults.set(true, forKey: SyncCatalog.enabledKey)
        XCTAssertFalse(CloudSync.shared.isEnabled)
        CloudSync.shared.setEnabled(true)
        XCTAssertFalse(CloudSync.shared.isEnabled)
    }

    func test_settingsHaveNoICloudSyncRow() {
        XCTAssertFalse(SettingsContent.rows(for: .root).contains { $0.id == "iCloudSync" })
    }
}
