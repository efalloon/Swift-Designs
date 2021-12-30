//
//  data.swift
//  Event Tickets
//
//  Created by Euan Traynor on 17/11/21.
//

import Foundation

struct UpcomingEvent {
    let title: String
    let image: String
    let transparent: BooleanLiteralType
}
let upcomingEvents: Array<UpcomingEvent> = [
    UpcomingEvent(title: "Apple", image: "apple", transparent: true), UpcomingEvent(title: "Weekend", image: "blinding", transparent: false), UpcomingEvent(title: "Comic Con", image: "comic-con", transparent: false), UpcomingEvent(title: "MasterCard", image: "mastercard", transparent: true), UpcomingEvent(title: "Google", image: "google", transparent: true)
]

struct NewEvent {
    let title: String
    let date: String
    let time: String
    let decription: String
    let image: String
    let price: Float
    let priceDescription: String
    let speakers: [NewEventSpeakers]
    let location: String
}
struct NewEventSpeakers {
    let name, image: String
}

let currentEvents: Array<NewEvent> = [
    NewEvent(title: "No Anunciar", date: "25 - 27 Nov, 2021", time: "5PM - 7PM", decription: "hello and welcome :)", image: "3", price: 28, priceDescription: "30% off for two tickets", speakers: [
        NewEventSpeakers(name: "Euan Traynor", image: "0")
    ], location: "San Fransisco CU Centre"),
    NewEvent(title: "Modern Art (MoMA)", date: "12 - 26 Dec, 2021", time: "1PM - 2:30PM", decription: "hello and welcome :)", image: "2", price: 34, priceDescription: "30% off for two tickets", speakers: [
        NewEventSpeakers(name: "Euan Traynor", image: "0")
    ], location: "San Fransisco CU Centre"),
    NewEvent(title: "Minimalistic Architecture", date: "4 Jan - 12 Feb, 2022", time: "8AM - 7PM", decription: "hello and welcome :)", image: "1", price: 34, priceDescription: "30% off for two tickets", speakers: [
        NewEventSpeakers(name: "Euan Traynor", image: "0")
    ], location: "San Fransisco CU Centre"),
    NewEvent(title: "The 1950s", date: "16 - 17 July, 2022", time: "11AM - 12:30PM", decription: "hello and welcome :)", image: "4", price: 34, priceDescription: "30% off for two tickets", speakers: [
        NewEventSpeakers(name: "Euan Traynor", image: "0")
    ], location: "San Fransisco CU Centre")
]
