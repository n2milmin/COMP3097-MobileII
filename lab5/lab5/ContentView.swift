//
//  ContentView.swift
//  lab5
//
//  Created by Nicole Milmine on 2025-02-19.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let books: [Book] = [
        .init(
            title: "Title 1",
            author: "Author 1",
            description: "Book 1"
        ),
        .init(
            title: "Title 2",
            author: "Author 3",
            description: "Book 2"
        ),
        .init(
            title: "Title 3",
            author: "Author 3",
            description: "Book 3"
        ),
        .init(
            title: "Title 4",
            author: "Author 4",
            description: "Book 4"
        ),
        .init(
            title: "Title 5",
            author: "Author 5",
            description: "Book 5"
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                List(books) { book in
                    NavigationLink(destination: DetailView(book: book)){
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

struct Book : Identifiable, Hashable {
    let id = UUID()
    let title: String
    let author: String
    let description: String
}

struct DetailView: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 20) {
            Text(book.title)
                .font(.headline)
            Text(book.author)
                .font(.subheadline)
            Text(book.description)
                .font(.body)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
