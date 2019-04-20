import XCTest
@testable import GraphQLGen

class GraphQLTests: XCTestCase {
    func testQuery() throws {
        let query = GraphQL.query([.leaf("oid"), .leaf("committedDate")])
        XCTAssertEqual(try query.stringifier.stringify(), "query { oid committedDate }")
    }

    func testRepository() throws {
        let query = GraphQL.query([.repository(owner: "o", name: "n", children: [.leaf("message")])])
        XCTAssertEqual(
            try query.stringifier.stringify(),
            #"query { repository(owner: "o", name: "n") { message } }"#)
    }

    func testEscaping() throws {
        let query = GraphQL.query([.repository(owner: "o\\hello", name: "n\"world", children: [.leaf("message")])])
        XCTAssertEqual(
            try query.stringifier.stringify(),
            #"query { repository(owner: "o\\hello", name: "n\"world") { message } }"#)
    }

    func testRef() throws {
        let query = GraphQL.query([.ref(.qualifiedName("master"), children: [.leaf("message")])])
        XCTAssertEqual(
            try query.stringifier.stringify(),
            #"query { ref(qualifiedName: "master") { message } }"#)
    }

    func testInlineFragment() throws {
        let frag = GraphQL.inlineFragment("Commit", children: [.history(.first(10), children: [.leaf("message")])])
        XCTAssertEqual(
            try frag.stringifier.stringify(),
            #"... on Commit { history(first: 10) { message } }"#)
    }

    func testFragmentSpread() throws {
        let frag = GraphQL.fragmentSpread("frag")
        XCTAssertEqual(
            try frag.stringifier.stringify(),
            #"... frag"#)
    }

    func testParentLeaf() throws {
        let gql = GraphQL.parent("daddy", [.leaf("largeadultson1"), .leaf("largeadultson2")])
        XCTAssertEqual(try gql.stringifier.stringify(), #"daddy { largeadultson1 largeadultson2 }"#)
    }

    func testFieldStringValue() throws {
        let gql = GraphQL.field(.init(name: "fname", arguments: ["foo": "bar"]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"fname(foo: "bar")"#)
    }

    func testFieldIntValue() throws {
        let gql = GraphQL.field(.init(name: "fname", arguments: ["foo": 42]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"fname(foo: 42)"#)
    }

    func testFieldArrayValue() throws {
        let gql = GraphQL.field(.init(name: "hasArray", arguments: ["arr": [1, 2, 3]]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"hasArray(arr: [1 2 3])"#)
    }

    func testFieldDictValue() throws {
        let gql = GraphQL.field(.init(name: "hasDict", arguments: ["d": ["zap": 4]]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"hasDict(d: {zap: 4})"#)
    }

    func testFieldNestedArrayValue() throws {
        let gql = GraphQL.field(.init(name: "nested", arguments: ["d": [1, "foo", [3, "bar"]]]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"nested(d: [1 "foo" [3 "bar"]])"#)
    }

    func testFieldNestedDictValue() throws {
        let gql = GraphQL.field(.init(name: "nested", arguments: ["d": ["a": 1, "b": ["c": 3]]]))
        let options = ["nested(d: {a: 1 b: {c: 3}})", "nested(d: {b: {c: 3} a: 1})"]
        XCTAssertTrue(options.contains(try gql.stringifier.stringify()))
    }

    func testFieldAlias() throws {
        let gql = GraphQL.field(.init(alias: "grace", name: "f", arguments: ["foo": "zap"]))
        XCTAssertEqual(
            try gql.stringifier.stringify(),
            #"grace: f(foo: "zap")"#)
    }
}
