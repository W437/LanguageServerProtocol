import Foundation

public struct DiagnosticOptions: Codable, Hashable, Sendable {
	public let workDoneProgress: Bool?
	public let identifier: String?
	public let interFileDependencies: Bool
	public let workspaceDiagnostics: Bool

	public init(
		workDoneProgress: Bool? = nil, identifier: String? = nil, interFileDependencies: Bool,
		workspaceDiagnostics: Bool
	) {
		self.workDoneProgress = workDoneProgress
		self.identifier = identifier
		self.interFileDependencies = interFileDependencies
		self.workspaceDiagnostics = workspaceDiagnostics
	}
}

public struct DiagnosticRegistrationOptions: Codable, Hashable, Sendable {
	public let documentSelector: DocumentSelector?
	public let workDoneProgress: Bool?
	public let identifier: String?
	public let interFileDependencies: Bool
	public let workspaceDiagnostics: Bool
	public let id: String?

	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil,
		identifier: String? = nil, interFileDependencies: Bool, workspaceDiagnostics: Bool,
		id: String? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
		self.identifier = identifier
		self.interFileDependencies = interFileDependencies
		self.workspaceDiagnostics = workspaceDiagnostics
		self.id = id
	}
}

public struct PublishDiagnosticsClientCapabilities: Codable, Hashable, Sendable {
	public var relatedInformation: Bool?
	public var tagSupport: ValueSet<DiagnosticTag>?
	public var versionSupport: Bool?
	public var codeDescriptionSupport: Bool?
	public var dataSupport: Bool?

	public init(
		relatedInformation: Bool? = nil, tagSupport: ValueSet<DiagnosticTag>? = nil,
		versionSupport: Bool? = nil, codeDescriptionSupport: Bool? = nil, dataSupport: Bool? = nil
	) {
		self.relatedInformation = relatedInformation
		self.tagSupport = tagSupport
		self.versionSupport = versionSupport
		self.codeDescriptionSupport = codeDescriptionSupport
		self.dataSupport = dataSupport
	}
}

public struct DiagnosticClientCapabilities: Codable, Hashable, Sendable {
	public var dynamicRegistration: Bool?
	public var relatedDocumentSupport: Bool?
	public var relatedInformation: Bool?
	public var tagSupport: ValueSet<DiagnosticTag>?
	public var codeDescriptionSupport: Bool?
	public var dataSupport: Bool?

	public init(
		dynamicRegistration: Bool? = nil, relatedDocumentSupport: Bool?,
		relatedInformation: Bool? = nil, tagSupport: ValueSet<DiagnosticTag>? = nil,
		codeDescriptionSupport: Bool? = nil, dataSupport: Bool? = nil
	) {
		self.dynamicRegistration = dynamicRegistration
		self.relatedDocumentSupport = relatedDocumentSupport
		self.relatedInformation = relatedInformation
		self.tagSupport = tagSupport
		self.codeDescriptionSupport = codeDescriptionSupport
		self.dataSupport = dataSupport
	}
}

public struct DiagnosticWorkspaceClientCapabilities: Codable, Hashable, Sendable {
	public var refreshSupport: Bool?

	public init(refreshSupport: Bool? = nil) {
		self.refreshSupport = refreshSupport
	}
}

public struct DiagnosticRelatedInformation: Codable, Hashable, Sendable {
	public let location: Location
	public let message: String

	public init(location: Location, message: String) {
		self.location = location
		self.message = message
	}
}

public typealias DiagnosticCode = TwoTypeOption<Int, String>

public enum DiagnosticSeverity: Int, CaseIterable, Codable, Hashable, Sendable {
	case error = 1
	case warning = 2
	case information = 3
	case hint = 4
}

public enum DiagnosticTag: Int, CaseIterable, Codable, Hashable, Sendable {
	case unnecessary = 1
	case deprecated = 2
}

public struct CodeDescription: Codable, Hashable, Sendable {
	public let href: URI

	public init(href: URI) {
		self.href = href
	}
}

public struct Diagnostic: Codable, Hashable, Sendable {
	public let range: LSPRange
	public let severity: DiagnosticSeverity?
	public let code: DiagnosticCode?
	public let codeDescription: CodeDescription?
	public let source: String?
	public let message: String
	public let tags: [DiagnosticTag]?
	public let relatedInformation: [DiagnosticRelatedInformation]?
	public let data: LSPAny?

	public init(
		range: LSPRange, severity: DiagnosticSeverity? = nil, code: DiagnosticCode? = nil,
		codeDescription: CodeDescription? = nil, source: String? = nil, message: String,
		tags: [DiagnosticTag]? = nil, relatedInformation: [DiagnosticRelatedInformation]? = nil,
		data: LSPAny? = nil
	) {
		self.range = range
		self.severity = severity
		self.code = code
		self.codeDescription = codeDescription
		self.source = source
		self.message = message
		self.tags = tags
		self.relatedInformation = relatedInformation
		self.data = data
	}
}

public struct PublishDiagnosticsParams: Codable, Hashable, Sendable {
	public let uri: DocumentUri
	public let version: Int?
	public let diagnostics: [Diagnostic]

	public init(uri: DocumentUri, version: Int? = nil, diagnostics: [Diagnostic]) {
		self.uri = uri
		self.version = version
		self.diagnostics = diagnostics
	}
}

public struct DocumentDiagnosticParams: Codable, Hashable, Sendable {
	public let workDoneToken: ProgressToken?
	public let partialResultToken: ProgressToken?
	public let textDocument: TextDocumentIdentifier
	public let identifier: String?
	public let previousResultId: String?

	public init(
		workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier,
		identifier: String? = nil,
		previousResultId: String? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.identifier = identifier
		self.previousResultId = previousResultId
	}
}

public enum DocumentDiagnosticReportKind: String, Codable, Hashable, Sendable, CaseIterable {
	case full
	case unchanged
}

public struct BaseDocumentDiagnosticReport: Codable, Hashable, Sendable {
	public let kind: DocumentDiagnosticReportKind
	public let resultId: String?
	public let items: [Diagnostic]?

	public init(
		kind: DocumentDiagnosticReportKind, resultId: String? = nil, items: [Diagnostic]? = nil
	) {
		self.kind = kind
		self.resultId = resultId
		self.items = items
	}
}

public struct RelatedDocumentDiagnosticReport: Codable, Hashable, Sendable {
	public let kind: DocumentDiagnosticReportKind
	public let resultId: String?
	public let items: [Diagnostic]?
	public let relatedDocuments: [DocumentUri: DocumentDiagnosticReport]?

	public init(
		kind: DocumentDiagnosticReportKind, resultId: String? = nil, items: [Diagnostic]? = nil,
		relatedDocuments: [DocumentUri: DocumentDiagnosticReport]? = nil
	) {
		self.kind = kind
		self.resultId = resultId
		self.items = items
		self.relatedDocuments = relatedDocuments
	}
}

typealias FullDocumentDiagnosticReport = BaseDocumentDiagnosticReport
typealias UnchangedDocumentDiagnosticReport = BaseDocumentDiagnosticReport
typealias RelatedFullDocumentDiagnosticReport = RelatedDocumentDiagnosticReport
typealias RelatedUnchangedDocumentDiagnosticReport = RelatedDocumentDiagnosticReport

public typealias DocumentDiagnosticReport = RelatedDocumentDiagnosticReport

public struct PreviousResultId: Codable, Hashable, Sendable {
	public let uri: DocumentUri
	public let value: String

	public init(uri: DocumentUri, value: String) {
		self.uri = uri
		self.value = value
	}
}

public struct WorkspaceDiagnosticParams: Codable, Hashable, Sendable {
	public let workDoneToken: ProgressToken?
	public let partialResultToken: ProgressToken?
	public let identifier: String?
	public let previousResultIds: [PreviousResultId]

	public init(
		workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil,
		identifier: String? = nil,
		previousResultIds: [PreviousResultId]
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.identifier = identifier
		self.previousResultIds = previousResultIds
	}
}

public struct WorkspaceFullDocumentDiagnosticReport: Codable, Hashable, Sendable {
	public let kind: DocumentDiagnosticReportKind
	public let resultId: String?
	public let items: [Diagnostic]
	public let uri: DocumentUri
	public let version: Int?

	public init(
		kind: DocumentDiagnosticReportKind = .full, resultId: String? = nil,
		items: [Diagnostic], uri: DocumentUri, version: Int?
	) {
		self.kind = kind
		self.resultId = resultId
		self.items = items
		self.uri = uri
		self.version = version
	}

	private enum CodingKeys: String, CodingKey {
		case kind
		case resultId
		case items
		case uri
		case version
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		kind = try container.decode(DocumentDiagnosticReportKind.self, forKey: .kind)
		resultId = try container.decodeIfPresent(String.self, forKey: .resultId)
		items = try container.decode([Diagnostic].self, forKey: .items)
		uri = try container.decode(DocumentUri.self, forKey: .uri)
		version = try container.decodeIfPresent(Int.self, forKey: .version)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(kind, forKey: .kind)
		try container.encodeIfPresent(resultId, forKey: .resultId)
		try container.encode(items, forKey: .items)
		try container.encode(uri, forKey: .uri)
		try container.encode(version, forKey: .version)
	}
}

public struct WorkspaceUnchangedDocumentDiagnosticReport: Codable, Hashable, Sendable {
	public let kind: DocumentDiagnosticReportKind
	public let resultId: String
	public let uri: DocumentUri
	public let version: Int?

	public init(
		kind: DocumentDiagnosticReportKind = .unchanged, resultId: String,
		uri: DocumentUri, version: Int?
	) {
		self.kind = kind
		self.resultId = resultId
		self.uri = uri
		self.version = version
	}

	private enum CodingKeys: String, CodingKey {
		case kind
		case resultId
		case uri
		case version
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		kind = try container.decode(DocumentDiagnosticReportKind.self, forKey: .kind)
		resultId = try container.decode(String.self, forKey: .resultId)
		uri = try container.decode(DocumentUri.self, forKey: .uri)
		version = try container.decodeIfPresent(Int.self, forKey: .version)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(kind, forKey: .kind)
		try container.encode(resultId, forKey: .resultId)
		try container.encode(uri, forKey: .uri)
		try container.encode(version, forKey: .version)
	}
}

public typealias WorkspaceDocumentDiagnosticReport = TwoTypeOption<
	WorkspaceFullDocumentDiagnosticReport, WorkspaceUnchangedDocumentDiagnosticReport
>

public struct WorkspaceDiagnosticReport: Codable, Hashable, Sendable {
	public let items: [WorkspaceDocumentDiagnosticReport]

	public init(items: [WorkspaceDocumentDiagnosticReport]) {
		self.items = items
	}
}

public struct WorkspaceDiagnosticReportPartialResult: Codable, Hashable, Sendable {
	public let items: [WorkspaceDocumentDiagnosticReport]

	public init(items: [WorkspaceDocumentDiagnosticReport]) {
		self.items = items
	}
}
