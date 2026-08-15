import LanguageServerProtocol
import XCTest

final class DiagnosticsTests: XCTestCase {
	func testPreviousResultIdRoundTrip() throws {
		let value = PreviousResultId(uri: "file:///workspace/main.swift", value: "result-1")

		try assertRoundTrip(value)
	}

	func testWorkspaceDiagnosticReportRoundTrip() throws {
		let diagnostic = Diagnostic(
			range: .zero,
			severity: .warning,
			message: "Unused value"
		)
		let report = WorkspaceDiagnosticReport(items: [
			.optionA(
				WorkspaceFullDocumentDiagnosticReport(
					resultId: "result-2",
					items: [diagnostic],
					uri: "file:///workspace/main.swift",
					version: 4
				)),
			.optionB(
				WorkspaceUnchangedDocumentDiagnosticReport(
					resultId: "result-3",
					uri: "file:///workspace/closed.swift",
					version: nil
				)),
		])

		let data = try JSONEncoder().encode(report)
		let object = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
		let items = try XCTUnwrap(object["items"] as? [[String: Any]])

		XCTAssertEqual(items[0]["kind"] as? String, "full")
		XCTAssertEqual(items[1]["kind"] as? String, "unchanged")
		XCTAssertTrue(items[1].keys.contains("version"))
		XCTAssertTrue(items[1]["version"] is NSNull)
		try assertRoundTrip(report)
	}

	func testDiagnosticDataPresenceAndAbsence() throws {
		let data: LSPAny = [
			"fixId": "remove-unused",
			"documentVersion": 7,
		]
		let diagnosticWithData = Diagnostic(
			range: .zero,
			message: "Unused value",
			data: data
		)
		let diagnosticWithoutData = Diagnostic(
			range: .zero,
			message: "Unused value"
		)

		let encodedWithData = try JSONEncoder().encode(diagnosticWithData)
		let objectWithData = try XCTUnwrap(
			JSONSerialization.jsonObject(with: encodedWithData) as? [String: Any]
		)
		XCTAssertNotNil(objectWithData["data"])
		try assertRoundTrip(diagnosticWithData)

		let encodedWithoutData = try JSONEncoder().encode(diagnosticWithoutData)
		let objectWithoutData = try XCTUnwrap(
			JSONSerialization.jsonObject(with: encodedWithoutData) as? [String: Any]
		)
		XCTAssertFalse(objectWithoutData.keys.contains("data"))
		try assertRoundTrip(diagnosticWithoutData)
	}

	private func assertRoundTrip<Value>(_ value: Value) throws
	where Value: Codable & Equatable {
		let encoded = try JSONEncoder().encode(value)
		let decoded = try JSONDecoder().decode(Value.self, from: encoded)

		XCTAssertEqual(decoded, value)
	}
}
