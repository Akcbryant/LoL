//
//  LoL.swift
//  AKCBLol
//
//  Created by Kirby Bryant on 5/19/15.
//  Copyright (c) 2015 AKCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoL {

    // MARK: Private Constants
    private let ChampionVersion = "1.2"
    private let CurrentGameVersion = "1.0"
    private let FeaturedGamesVersion = "1.0"
    private let GameVersion = "1.3"
    private let LeagueVersion = "2.5"
    private let LoLStaticDataVersion = "1.2"
    private let LoLStatusVersion = "1.0"
    private let MatchVersion = "2.2"
    private let MatchHistoryVersion = "2.2"
    private let StatsVersion = "1.3"
    private let SummonerVersion = "1.4"
    private let TeamVersion = "2.4"

    var URL: NSString?
    var json: AnyObject?

    var api_key = ""
    let https = "https"

    var regionRawValue = ""
    var regionBaseURLRawValue = ""

    // MARK: Initializers

    init(region: Region, apiKey: String) {
        api_key = apiKey
        regionRawValue = region.rawValue
        regionBaseURLRawValue = getRegionBaseURL(region).rawValue
    }

    func setRegion(region: Region) {
        regionRawValue = region.rawValue
        regionBaseURLRawValue = getRegionBaseURL(region).rawValue
    }

    // MARK: Convenience Functions

    private func getRegionBaseURL(region: Region) -> RegionBaseURL {
        return RegionBaseURL(rawValue: "\(region.rawValue).api.pvp.net")!
    }


    // MARK: Request

    private func getRequest(URLString: NSString) {
        Alamofire.request(.GET, URLString as! String)
            .responseJSON { (_, _, JSON, _) in
                self.json = JSON
                println(self.json)
        }
    }


    // MARK: Champion Info

    func getChampions(freeToPlay: Bool?) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(ChampionVersion)/champion")

        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        var ftpQueryItem = NSURLQueryItem(name: "freeToPlay", value: "false")
        if let FTP = freeToPlay {
            if FTP == true {
                ftpQueryItem = NSURLQueryItem(name: "freeToPlay", value: "true")
            }
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [ftpQueryItem, idQueryItem]
        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)

    }

    func getChampion(championID: Int) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(ChampionVersion)/champion/\(championID)")

        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)

    }

    // MARK: Current Game

    func getcurrentGame(platformID: PlatformID, summonerID: Int) {
        let hostString = String("\(regionBaseURLRawValue)/observer-mode/rest/consumer/getSpectatorGameInfo/\(platformID.rawValue)/\(summonerID)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Featured Games

    func getFeaturedGames() {
        let hostString = String("\(regionBaseURLRawValue)/observer-mode/rest/featured")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Recent Games

    func getRecentGames(summonerID: Int) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(GameVersion)/game/by-summoner/\(summonerID)/recent")
        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Leagues

    func getLeagueInfo(summonerIDs: [Int]) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/by-summoner/")
        for id in summonerIDs {
            hostString = hostString + "\(id),"
        }
        hostString.removeAtIndex(hostString.endIndex.predecessor())

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getLeagueInfoEntries(summonerIDs: [Int]) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/by-summoner/")
        for id in summonerIDs {
            hostString = hostString + "\(id),"
        }
        hostString.removeAtIndex(hostString.endIndex.predecessor())
        hostString += "/entry"

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getTeamLeagueInfo(teamIDs: [String]) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/by-team/")
        for id in teamIDs {
            hostString = hostString + "\(id),"
        }
        hostString.removeAtIndex(hostString.endIndex.predecessor())

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getTeamLeagueInfoEntries(teamIDs: [String]) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/by-team/")
        for id in teamIDs {
            hostString = hostString + "\(id),"
        }
        hostString.removeAtIndex(hostString.endIndex.predecessor())
        hostString += "/entry"

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getChallengerLeague(gameType: RankedQueues) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/challenger")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let typeQueryItem = NSURLQueryItem(name: "type", value: gameType.rawValue)
        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [typeQueryItem, idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getMasterLeague(gameType: RankedQueues) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(LeagueVersion)/league/master")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let typeQueryItem = NSURLQueryItem(name: "type", value: gameType.rawValue)
        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [typeQueryItem, idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Static Data

    func getChampionList(champDataOptions: [ChampData]?) {

        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/champion")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var queryItems = [NSURLQueryItem]()

        if let champData = champDataOptions {
            var champOptions = ""
            for option in champData {
                champOptions += "\(option.rawValue),"
            }
            champOptions.removeAtIndex(champOptions.endIndex.predecessor())
            var champQueryItem = NSURLQueryItem(name: "champData", value: champOptions)
            queryItems.append(champQueryItem)
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getChampionData(id: Int, champDataOptions: [ChampData]?) {
        // WHY IS CHAMPDATAOPTIONS NIL!?!?!?!?!?!?!?!?
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/champion/\(id)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var queryItems = [NSURLQueryItem]()

        if let champData = champDataOptions {
            var champOptions = ""
            for option in champData {
                champOptions += "\(option.rawValue),"
            }
            champOptions.removeAtIndex(champOptions.endIndex.predecessor())
            var champQueryItem = NSURLQueryItem(name: "champData", value: champOptions)
            queryItems.append(champQueryItem)
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getItemList(itemDataOptions: [ItemListData]?) {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/item")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var itemOptions = ""
        if let itemData = itemDataOptions {
            for option in itemDataOptions! {
                itemOptions += "\(option.rawValue),"
            }
            itemOptions.removeAtIndex(itemOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !itemOptions.isEmpty {
            var itemQueryItem = NSURLQueryItem(name: "itemListData", value: itemOptions)
            queryItems.append(itemQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getItem(id: Int, itemDataOptions: [ItemData]?) {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/item/\(id)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var itemOptions = ""
        if let itemData = itemDataOptions {
            for option in itemDataOptions! {
                itemOptions += "\(option.rawValue),"
            }
            itemOptions.removeAtIndex(itemOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !itemOptions.isEmpty {
            var itemQueryItem = NSURLQueryItem(name: "itemData", value: itemOptions)
            queryItems.append(itemQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getLanguageStrings() {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/language-strings")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        var queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getSupportedLanguages() {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/languages")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        var queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getMapData() {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/map")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        var queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getMasteryList(masteryDataOptions: [MasteryListData]?) {

        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/mastery")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var queryItems = [NSURLQueryItem]()

        if let masteryData = masteryDataOptions {
            var masteryOptions = ""
            for option in masteryDataOptions! {
                masteryOptions += "\(option.rawValue),"
            }
            masteryOptions.removeAtIndex(masteryOptions.endIndex.predecessor())
            var masteryQueryItem = NSURLQueryItem(name: "masteryListData", value: masteryOptions)
            queryItems.append(masteryQueryItem)
        }



        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getMastery(id: Int, masteryDataOptions: [MasteryData]?) {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/mastery/\(id)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var queryItems = [NSURLQueryItem]()

        if let masteryData = masteryDataOptions {
            var masteryOptions = ""
            for option in masteryDataOptions! {
                masteryOptions += "\(option.rawValue),"
            }
            masteryOptions.removeAtIndex(masteryOptions.endIndex.predecessor())
            var masteryQueryItem = NSURLQueryItem(name: "masteryData", value: masteryOptions)
            queryItems.append(masteryQueryItem)
        }


        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getRealmData() {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/realm")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        var queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getRuneList(runeDataOptions: [RuneListData]?) {

        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/rune")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var runeOptions = ""
        if let runeData = runeDataOptions {
            for option in runeDataOptions! {
                runeOptions += "\(option.rawValue),"
            }
            runeOptions.removeAtIndex(runeOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !runeOptions.isEmpty {
            var runeQueryItem = NSURLQueryItem(name: "runeListData", value: runeOptions)
            queryItems.append(runeQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getRune(id: Int, runeDataOptions: [RuneData]?) {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/rune/\(id)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var runeOptions = ""
        if let runeData = runeDataOptions {
            for option in runeDataOptions! {
                runeOptions += "\(option.rawValue),"
            }
            runeOptions.removeAtIndex(runeOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !runeOptions.isEmpty {
            var runeQueryItem = NSURLQueryItem(name: "runeData", value: runeOptions)
            queryItems.append(runeQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getSummonerSpellList(spellDataOptions: [SpellData]?) {

        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/summoner-spell")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var spellOptions = ""
        if let spellData = spellDataOptions {
            for option in spellDataOptions! {
                spellOptions += "\(option.rawValue),"
            }
            spellOptions.removeAtIndex(spellOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !spellOptions.isEmpty {
            var spellQueryItem = NSURLQueryItem(name: "spellData", value: spellOptions)
            queryItems.append(spellQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getSummonerSpell(id: Int, spellDataOptions: [SpellData]?) {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/summoner-spell/\(id)")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        var spellOptions = ""
        if let spellData = spellDataOptions {
            for option in spellDataOptions! {
                spellOptions += "\(option.rawValue),"
            }
            spellOptions.removeAtIndex(spellOptions.endIndex.predecessor())
        }

        var queryItems = [NSURLQueryItem]()

        if !spellOptions.isEmpty {
            var spellQueryItem = NSURLQueryItem(name: "spellData", value: spellOptions)
            queryItems.append(spellQueryItem)

        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getVersions() {
        var hostString = String("\(RegionBaseURL.global.rawValue)/api/lol/static-data/\(regionRawValue)/v\(LoLStaticDataVersion)/versions")

        var components = NSURLComponents()
        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        var queryItems = [idQueryItem]
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Shard Status
    func getShards() {
        var hostString = String("status.leagueoflegends.com/shards")

        var components = NSURLComponents()
        components.scheme = "http"
        components.host = hostString

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getShardStatus() {
        var hostString = String("status.leagueoflegends.com/shards/\(regionRawValue)")

        var components = NSURLComponents()
        components.scheme = "http"
        components.host = hostString

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Match Info

    func getMatch(id: Int, includeTimeline: Bool) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(MatchVersion)/match/\(id)")

        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        var timelineQueryItem = NSURLQueryItem(name: "includeTimeline", value: "false")
        if includeTimeline == true {
            timelineQueryItem = NSURLQueryItem(name: "includeTimeline", value: "true")
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        let queryItems = [timelineQueryItem, idQueryItem]
        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    // MARK: Match History

    func getMatchHistory(summonerId: Int, championIds: [Int]?, rankedQueues: [RankedQueues]?, beginIndex: Int?, endIndex: Int?) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(MatchHistoryVersion)/matchhistory/\(summonerId)")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        if let championIdsList = championIds {
            var champions = ""
            for champion in championIdsList {
                champions += "\(champion),"
            }
            champions.removeAtIndex(champions.endIndex.predecessor())
            var championQueryItem = NSURLQueryItem(name: "championIds", value: champions)
            queryItems.append(championQueryItem)
        }

        if let queuesList = rankedQueues {
            var rankedQueues = ""
            for queues in queuesList {
                rankedQueues += "\(queues.rawValue),"
            }
            rankedQueues.removeAtIndex(rankedQueues.endIndex.predecessor())
            var queuesQueryItem = NSURLQueryItem(name: "rankedQueues", value: rankedQueues)
            queryItems.append(queuesQueryItem)
        }

        if let beginIndex = beginIndex {
            let beginIndexQueryItem = NSURLQueryItem(name: "beginIndex", value: "\(beginIndex)")
            queryItems.append(beginIndexQueryItem)
        }

        if let endIndex = endIndex {
            let endIndexQueryItem = NSURLQueryItem(name: "endIndex", value: "\(endIndex)")
            queryItems.append(endIndexQueryItem)
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)

    }

    // MARK: Stats

    func getRankedStats(summonerId: Int, season: SEASON?) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(StatsVersion)/stats/by-summoner/\(summonerId)/ranked")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        if let seasonParameter = season {
            let seasonQueryItem = NSURLQueryItem(name: "season", value: "\(seasonParameter.rawValue)")
            queryItems.append(seasonQueryItem)
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)

    }

    func getPlayerStatsSummary(summonerId: Int, season: SEASON?) {
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(StatsVersion)/stats/by-summoner/\(summonerId)/summary")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        if let seasonParameter = season {
            let seasonQueryItem = NSURLQueryItem(name: "season", value: "\(seasonParameter.rawValue)")
            queryItems.append(seasonQueryItem)
        }

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)

    }

    // MARK: Summoner Info

    func getSummonerObject(summonerName: [String]) {
        var nameString = ""
        for names in summonerName {
            var prunedString = String(filter(names.generate()) { $0 != " " })
            nameString += "\(prunedString),"
        }
        if !nameString.isEmpty {
            nameString.removeAtIndex(nameString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(SummonerVersion)/summoner/by-name/\(nameString)")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)
        components.queryItems = queryItems

        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getSummonerObject(summonerIds: [Int]) {
        var idString = ""
        for id in summonerIds {
            idString += "\(id),"
        }
        if !idString.isEmpty {
            idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(SummonerVersion)/summoner/\(idString)")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getMasteryPages(summonerIds: [Int]) {
        var idString = ""
        for id in summonerIds {
            idString += "\(id),"
        }
        if !idString.isEmpty {
            idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(SummonerVersion)/summoner/\(idString)/masteries")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getSummonerNames(summonerIds: [Int]) {
        var idString = ""
        for id in summonerIds {
            idString += "\(id),"
        }
        if !idString.isEmpty {
            idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(SummonerVersion)/summoner/\(idString)/name")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getRunePages(summonerIds: [Int]) {
        var idString = ""
        for id in summonerIds {
            idString += "\(id),"
        }
        if !idString.isEmpty {
            idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(SummonerVersion)/summoner/\(idString)/runes")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getTeams(summonerIds: [Int]) {
        var idString = ""
        for id in summonerIds {
        idString += "\(id),"
        }
        if !idString.isEmpty {
        idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(TeamVersion)/team/by-summoner/\(idString)")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }

    func getTeams(teamIds: [String]) {
        var idString = ""
        for id in teamIds {
            idString += "\(id),"
        }
        if !idString.isEmpty {
            idString.removeAtIndex(idString.endIndex.predecessor())
        }
        var hostString = String("\(regionBaseURLRawValue)/api/lol/\(regionRawValue)/v\(TeamVersion)/team/\(idString)")

        var queryItems = [NSURLQueryItem]()
        var components = NSURLComponents()

        components.scheme = https
        components.host = hostString

        let idQueryItem = NSURLQueryItem(name: "api_key", value: api_key)
        queryItems.append(idQueryItem)

        components.queryItems = queryItems
        URL = components.URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        getRequest(URL!)
    }


    // MARK: Teams Info
}

// MARK: Enum Constants

enum ChampData:String {
    case
    all = "all",
    allytips = "allytips",
    altimages = "altimages",
    blurb = "blurb",
    enemytips = "enemytips",
    image = "image",
    info = "info",
    lore = "lore",
    partype = "partype",
    passive = "passive",
    recommended = "recommended",
    skins = "skins",
    spells = "spells",
    stats = "stats",
    tags = "tags"
}

enum ItemData: String {
    case
    all = "all",
    colloq = "colloq",
    consumeOnFull = "consumeOnFull",
    consumed = "consumed",
    depth = "depth",
    from = "from",
    gold = "gold",
    groups = "groups",
    hideFromAll = "hideFromAll",
    image = "image",
    inStore = "inStore",
    into = "into",
    requiredChampion = "requiredChampion",
    sanitizedDescription = "sanitizedDescription",
    specialRecipe = "specialRecipe",
    stacks = "stacks",
    stats = "stats",
    tags = "tags",
    tree = "tree"
}

enum ItemListData: String {
    case
    all = "all",
    colloq = "colloq",
    consumeOnFull = "consumeOnFull",
    consumed = "consumed",
    depth = "depth",
    from = "from",
    gold = "gold",
    groups = "groups",
    hideFromAll = "hideFromAll",
    image = "image",
    inStore = "inStore",
    into = "into",
    mapts = "maps",
    requiredChampion = "requiredChampion",
    sanitizedDescription = "sanitizedDescription",
    specialRecipe = "specialRecipe",
    stacks = "stacks",
    stats = "stats",
    tags = "tags",
    tree = "tree"
}

enum MasteryListData: String {
    case
    all = "all",
    image = "image",
    masteryTree = "masteryTree",
    prereq = "prereq",
    ranks = "ranks",
    sanitizedDescription = "sanitizedDescription",
    tree = "tree"
}

enum MasteryData: String {
    case
    all = "all",
    image = "image",
    masteryTree = "masteryTree",
    prereq = "prereq",
    ranks = "ranks",
    sanitizedDescription = "sanitizedDescription"
}

enum RuneListData: String {
    case
    all = "all",
    basic = "basic",
    colloq = "colloq",
    consumeOnFull = "consumeOnFull",
    consumed = "consumed",
    depth = "depth",
    from = "from",
    gold = "gold",
    hideFromAll = "hideFromAll",
    image = "image",
    inStore = "inStore",
    into = "into",
    maps = "maps",
    requiredChampion = "requiredChampion",
    sanitizedDescription = "sanitizedDescription",
    specialRecipe = "specialRecipe",
    stacks = "stacks",
    stats = "stats",
    tags = "tags"
}

enum RuneData: String {
    case
    all = "all",
    colloq = "colloq",
    consumeOnFull = "consumeOnFull",
    consumed = "consumed",
    depth = "depth",
    from = "from",
    gold = "gold",
    hideFromAll = "hideFromAll",
    image = "image",
    inStore = "inStore",
    into = "into",
    maps = "maps",
    requiredChampion = "requiredChampion",
    sanitizedDescription = "sanitizedDescription",
    specialRecipe = "specialRecipe",
    stacks = "stacks",
    stats = "stats",
    tags = "tags"
}

enum SpellData: String {
    case
    all = "all",
    cooldown = "cooldown",
    cooldownBurn = "cooldownBurn",
    cost = "cost",
    costBurn = "costBurn",
    costType = "costType",
    effect = "effect",
    effectBurn = "effectBurn",
    image = "image",
    key = "key",
    leveltip = "leveltip",
    maxrank = "maxrank",
    modes = "modes",
    range = "range",
    rangeBurn = "rangeBurn",
    resource = "resource",
    sanitizedDescription = "sanitizedDescription",
    sanitizedTooltip = "sanitizedTooltip",
    tooltip = "tooltip",
    vars = "vars"
}

enum Region: String {
    case
    br = "br",
    eune = "eune",
    euw = "euw",
    kr = "kr",
    lan = "lan",
    las = "las",
    na = "na",
    oce = "oce",
    tr = "tr",
    ru = "ru"
}

enum RankedQueues:String {
    case
    Solo_5x5 = "RANKED_SOLO_5x5",
    Team_3x3 = "RANKED_TEAM_3x3",
    Team_5x5 = "RANKED_TEAM_5x5"
}

enum SEASON:String {
    case
    three = "SEASON3",
    four2014 = "SEASON2014",
    five2015 = "SEASON2015"
}

enum RegionBaseURL: String {
    case
    br = "br.api.pvp.net",
    eune = "eune.api.pvp.net",
    euw = "euw.api.pvp.net",
    kr = "kr.api.pvp.net",
    lan = "lan.api.pvp.net",
    las = "las.api.pvp.net",
    na = "na.api.pvp.net",
    oce = "oce.api.pvp.net",
    tr = "tr.api.pvp.net",
    ru = "ru.api.pvp.net",
    global = "global.api.pvp.net"

}

enum PlatformID: String {
    case
    NA1 = "NA1",
    BR1 = "BR1",
    LA1 = "LA1",
    LA2 = "LA2",
    OC1 = "OC1",
    EUN1 = "EUN1",
    TR1 = "TR1",
    RU = "RU",
    EUW1 = "EUW1",
    KR = "KR"
}
