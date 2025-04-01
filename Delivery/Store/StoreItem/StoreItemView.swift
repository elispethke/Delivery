//
//  StoreItemView.swift
//  Delivery
//
//  Created by Elis Pethke on 01/04/25.
//

import SwiftUI

struct StoreItemView: View {
    let store: StoreType
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                StoreCard(store: store, colorScheme: colorScheme)
            }
            .padding(.horizontal, 10)
        }
    }
}

struct StoreCard: View {
    let store: StoreType
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            StoreImage(imageName: store.logoImage)
            
            StoreDetails(store: store, colorScheme: colorScheme)
        }
        .frame(width: 370, height: 280)
        .background(colorScheme == .dark ? Color.black.opacity(0.1) : Color.white.opacity(0.2))
        .cornerRadius(20)
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.4) : Color.black.opacity(0.4), radius: 2, x: 1, y: 2)
    }
}

struct StoreImage: View {
    let imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .frame(height: 150)
    }
}

struct StoreDetails: View {
    let store: StoreType
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(store.name)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            
            StoreRating(stars: store.stars)
            
            HStack {
                Image(systemName: "hand.thumbsup")
                Text("\(String(format: "%.1f", store.rating)) (\(store.reviewCount > 200 ? "200+" : "\(store.reviewCount)"))")
            }
            .font(.system(size: 15))
            .padding(.leading, 2)
            
            StoreDeliveryInfo(store: store)
            
            StoreTimeInfo(time: store.deliveryTime)
        }
        .padding(.horizontal)
    }
}

struct StoreRating: View {
    let stars: Int
    
    var body: some View {
        HStack {
            ForEach(1...stars, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.accentColor)
                    .font(.system(size: 10))
            }
        }
    }
}

struct StoreDeliveryInfo: View {
    let store: StoreType
    
    var body: some View {
        HStack {
            Image(systemName: "bicycle")
                .foregroundStyle(Color.white)
            
            Text(store.deliveryPrice == 0 ? "Free delivery" : "Delivery: €\(String(format: "%.2f", store.deliveryPrice))")
                .foregroundStyle(Color.white)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 12)
        .background(Color.accentColor)
        .cornerRadius(12)
        .padding(.horizontal, 40)
    }
}

struct StoreTimeInfo: View {
    let time: String
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundStyle(Color.gray)
                .font(.system(size: 15))
                .padding(.top, 10)
            
            Text(time)
                .font(.system(size: 15))
                .foregroundStyle(Color.gray)
                .padding(.top, 10)
        }
        .padding(.bottom, 5)
    }
}

#Preview {
    StoreItemView(store: StoreViewModel().storeMock[0])
}
