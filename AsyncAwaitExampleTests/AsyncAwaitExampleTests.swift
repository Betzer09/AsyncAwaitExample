//
//  AsyncAwaitExampleTests.swift
//  AsyncAwaitExampleTests
//
//  Created by Austin Betzer on 7/18/22.
//

import XCTest
@testable import AsyncAwaitExample

class AsyncAwaitExampleTests: XCTestCase {
    
    func test_didSuccesfullyFetchDiscoveryMovies() async {
        let sut = makeSUT()
        do {
            let movies = try await sut.fetchDiscoveryMovies(1)
            XCTAssert(!movies.isEmpty, "expected to get a least 1 movie, instead we got \(movies.count) movies.")
        } catch {
            XCTFail("Failed to fetch movies from API with error: \(error)")
        }
        
    }
    
    func test_failedToFetchMovieWithInvalidPage() async {
        let sut = makeSUT()
        do {
            let movies = try await sut.fetchDiscoveryMovies(-1)
            XCTFail("Expected to get an invalid response back since you cannot have a page number below 0, instead got: \(movies.count)")
        } catch {
            XCTAssert(true)
        }
    }
    
    func makeSUT() -> DiscoverMoviesAPILogic {
        let sut = MovieAPISpy()
        return sut
    }
    
    class MovieAPISpy: DiscoverMoviesAPI {
        
        override func fetchDiscoveryMovies(_ page: Int = 1) async throws -> [DiscoveryMovie] {
            return try await super.fetchDiscoveryMovies(page)
        }
    }
}
