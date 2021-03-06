//
//  AKCBLolTests.swift
//  AKCBLolTests
//
//  Created by Kirby Bryant on 5/19/15.
//  Copyright (c) 2015 AKCB. All rights reserved.
//

import UIKit
import XCTest

class AKCBLolTests: XCTestCase {
    
    var lol = LoL(region: Region.na, apiKey: "")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }


    
    
    func testChampionURL() {
        
        lol.getChampions(true)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.2/champion?freeToPlay=true&api_key=\(lol.api_key)"))
        lol.getChampions(false)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.2/champion?freeToPlay=false&api_key=\(lol.api_key)"))
        lol.getChampion(266)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.2/champion/266?api_key=\(lol.api_key)"))
        
    }
    
    func testCurrentGameURL() {
        lol.setRegion(Region.ru)
        lol.getcurrentGame(PlatformID.RU, summonerID: 22264075)
        XCTAssertEqual(lol.URL!, NSString(string: "https://ru.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/RU/22264075?api_key=\(lol.api_key)"))
    }
    
    func testFeaturedGamesURL() {
        lol.setRegion(Region.na)
        lol.getFeaturedGames()
        
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/observer-mode/rest/featured?api_key=\(lol.api_key)"))
    }
    
    func testRecentGameURL() {
        lol.getRecentGames(22264075)
        
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/22264075/recent?api_key=\(lol.api_key)"))

    }
    
    func testLeagueURL() {
        
        let randomSummoners = [22264075, 24760395, 29264097, 22127530, 534470, 39101259, 575217, 55323233, 21359877, 19363161]
        let randomTeams = ["TEAM-5931daf0-557d-11e4-9e4f-782bcb4d1e24", "TEAM-42a8de80-ebfe-11e2-bc40-782bcb4d0bb2", "TEAM-646831b0-4a86-11e3-8042-782bcb4d1861", "TEAM-d765c970-82e5-11e2-9868-782bcb4d1861", "TEAM-681f96c0-ae21-11e1-9844-782bcb4d0bb2", "TEAM-c2976df1-ff40-11e2-b193-782bcb4d0bb2", "TEAM-ea2142d0-ac35-11e4-b967-c81f66dcfb5a", "TEAM-efd2aad0-13a5-11e4-8584-782bcb4d1861", "TEAM-dd370e90-3ce0-11e2-8faf-782bcb4d1861", "TEAM-428647d0-2263-11e3-8c31-782bcb4d1861"]
        
        lol.getLeagueInfo(randomSummoners)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/22264075,24760395,29264097,22127530,534470,39101259,575217,55323233,21359877,19363161?api_key=\(lol.api_key)"))
        
        lol.getLeagueInfoEntries(randomSummoners)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.5/league/by-summoner/22264075,24760395,29264097,22127530,534470,39101259,575217,55323233,21359877,19363161/entry?api_key=\(lol.api_key)"))
        
        lol.getTeamLeagueInfo(randomTeams)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.5/league/by-team/TEAM-5931daf0-557d-11e4-9e4f-782bcb4d1e24,TEAM-42a8de80-ebfe-11e2-bc40-782bcb4d0bb2,TEAM-646831b0-4a86-11e3-8042-782bcb4d1861,TEAM-d765c970-82e5-11e2-9868-782bcb4d1861,TEAM-681f96c0-ae21-11e1-9844-782bcb4d0bb2,TEAM-c2976df1-ff40-11e2-b193-782bcb4d0bb2,TEAM-ea2142d0-ac35-11e4-b967-c81f66dcfb5a,TEAM-efd2aad0-13a5-11e4-8584-782bcb4d1861,TEAM-dd370e90-3ce0-11e2-8faf-782bcb4d1861,TEAM-428647d0-2263-11e3-8c31-782bcb4d1861?api_key=\(lol.api_key)"))
        
        lol.getTeamLeagueInfoEntries(randomTeams)
            
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.5/league/by-team/TEAM-5931daf0-557d-11e4-9e4f-782bcb4d1e24,TEAM-42a8de80-ebfe-11e2-bc40-782bcb4d0bb2,TEAM-646831b0-4a86-11e3-8042-782bcb4d1861,TEAM-d765c970-82e5-11e2-9868-782bcb4d1861,TEAM-681f96c0-ae21-11e1-9844-782bcb4d0bb2,TEAM-c2976df1-ff40-11e2-b193-782bcb4d0bb2,TEAM-ea2142d0-ac35-11e4-b967-c81f66dcfb5a,TEAM-efd2aad0-13a5-11e4-8584-782bcb4d1861,TEAM-dd370e90-3ce0-11e2-8faf-782bcb4d1861,TEAM-428647d0-2263-11e3-8c31-782bcb4d1861/entry?api_key=\(lol.api_key)"))
        
    }
    
    func testStaticDataURL() {
        let champData = [ChampData.allytips, ChampData.altimages, ChampData.blurb]
        let itemData = [ItemData.consumeOnFull, ItemData.consumed, ItemData.depth]
        let itemListData = [ItemListData.consumeOnFull, ItemListData.consumed, ItemListData.depth]
        let masteryListData = [MasteryListData.image, MasteryListData.masteryTree, MasteryListData.prereq, MasteryListData.ranks]
        let masteryData = [MasteryData.prereq, MasteryData.ranks]
        let runeListData = [RuneListData.all, RuneListData.basic, RuneListData.colloq, RuneListData.consumeOnFull, RuneListData.consumed, RuneListData.depth, RuneListData.from, RuneListData.gold, RuneListData.hideFromAll, RuneListData.image, RuneListData.inStore, RuneListData.into, RuneListData.maps, RuneListData.requiredChampion, RuneListData.sanitizedDescription, RuneListData.specialRecipe, RuneListData.stacks, RuneListData.stats, RuneListData.tags]
        let runeData = [RuneData.all, RuneData.colloq, RuneData.consumeOnFull, RuneData.consumed, RuneData.depth, RuneData.from, RuneData.gold, RuneData.hideFromAll, RuneData.image, RuneData.inStore, RuneData.into, RuneData.maps, RuneData.requiredChampion, RuneData.sanitizedDescription, RuneData.specialRecipe, RuneData.stacks, RuneData.stats, RuneData.tags]
        let spellData = [SpellData.all, SpellData.cooldown, SpellData.cooldownBurn, SpellData.cost, SpellData.costBurn, SpellData.costType, SpellData.effect, SpellData.effectBurn, SpellData.image, SpellData.key, SpellData.leveltip, SpellData.maxrank, SpellData.modes, SpellData.range, SpellData.rangeBurn, SpellData.resource, SpellData.sanitizedDescription, SpellData.sanitizedTooltip, SpellData.tooltip, SpellData.vars]
        
        lol.getChampionList(nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?api_key=\(lol.api_key)"))
        
        lol.getChampionList(champData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=allytips,altimages,blurb&api_key=\(lol.api_key)"))
        
        lol.getChampionData(23, champDataOptions: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/23?api_key=\(lol.api_key)"))

        lol.getChampionData(23, champDataOptions: champData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/23?champData=allytips,altimages,blurb&api_key=\(lol.api_key)"))

        lol.getItemList(nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?api_key=\(lol.api_key)"))
        
        lol.getItemList(itemListData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?itemListData=consumeOnFull,consumed,depth&api_key=\(lol.api_key)"))
        
        lol.getItem(3725, itemDataOptions: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/item/3725?api_key=\(lol.api_key)"))
        
        lol.getItem(3725, itemDataOptions: itemData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/item/3725?itemData=consumeOnFull,consumed,depth&api_key=\(lol.api_key)"))
        
        lol.getLanguageStrings()
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/language-strings?api_key=\(lol.api_key)"))
        
        lol.getSupportedLanguages()
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/languages?api_key=\(lol.api_key)"))
        
        lol.getMapData()
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/map?api_key=\(lol.api_key)"))
        
        lol.getMasteryList(nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/mastery?api_key=\(lol.api_key)"))
        
        lol.getMasteryList(masteryListData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/mastery?masteryListData=image,masteryTree,prereq,ranks&api_key=\(lol.api_key)"))
        
        lol.getMastery(4353, masteryDataOptions: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/mastery/4353?api_key=\(lol.api_key)"))
        
        lol.getMastery(4353, masteryDataOptions: masteryData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/mastery/4353?masteryData=prereq,ranks&api_key=\(lol.api_key)"))
        
        lol.getRealmData()
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/realm?api_key=\(lol.api_key)"))
        
        lol.getRuneList(nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/rune?api_key=\(lol.api_key)"))
        
        lol.getRuneList(runeListData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/rune?runeListData=all,basic,colloq,consumeOnFull,consumed,depth,from,gold,hideFromAll,image,inStore,into,maps,requiredChampion,sanitizedDescription,specialRecipe,stacks,stats,tags&api_key=\(lol.api_key)"))
        
        lol.getRune(5235, runeDataOptions: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/rune/5235?api_key=\(lol.api_key)"))
        
        lol.getRune(5235, runeDataOptions: runeData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/rune/5235?runeData=all,colloq,consumeOnFull,consumed,depth,from,gold,hideFromAll,image,inStore,into,maps,requiredChampion,sanitizedDescription,specialRecipe,stacks,stats,tags&api_key=\(lol.api_key)"))
        
        lol.getSummonerSpellList(nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell?api_key=\(lol.api_key)"))
        
        lol.getSummonerSpellList(spellData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell?spellData=all,cooldown,cooldownBurn,cost,costBurn,costType,effect,effectBurn,image,key,leveltip,maxrank,modes,range,rangeBurn,resource,sanitizedDescription,sanitizedTooltip,tooltip,vars&api_key=\(lol.api_key)"))
        
        lol.getSummonerSpell(1, spellDataOptions: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell/1?api_key=\(lol.api_key)"))
        
        lol.getSummonerSpell(1, spellDataOptions: spellData)
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell/1?spellData=all,cooldown,cooldownBurn,cost,costBurn,costType,effect,effectBurn,image,key,leveltip,maxrank,modes,range,rangeBurn,resource,sanitizedDescription,sanitizedTooltip,tooltip,vars&api_key=\(lol.api_key)"))
        
        lol.getVersions()
        XCTAssertEqual(lol.URL!, NSString(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/versions?api_key=\(lol.api_key)"))
    }
    
    func testStatusURL() {
        lol.getShards()
        XCTAssertEqual(lol.URL!, NSString(string:"http://status.leagueoflegends.com/shards"))
        
        lol.getShardStatus()
        XCTAssertEqual(lol.URL!, NSString(string: "http://status.leagueoflegends.com/shards/na"))
    }
    
    func testMatchURL() {
        lol.getMatch(1857861027, includeTimeline: false)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/match/1857861027?includeTimeline=false&api_key=\(lol.api_key)"))
        
        lol.getMatch(1857861027, includeTimeline: true)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/match/1857861027?includeTimeline=true&api_key=\(lol.api_key)"))
    }
    
    func testMatchHistoryURL() {
        let championIds = [23, 24, 25]
        let rankedQueues = [RankedQueues.Solo_5x5, RankedQueues.Team_3x3, RankedQueues.Team_5x5]
        
        lol.getMatchHistory(22264075, championIds: nil, rankedQueues: nil, beginIndex: nil, endIndex: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?api_key=\(lol.api_key)"))
        
        lol.getMatchHistory(22264075, championIds: championIds, rankedQueues: nil, beginIndex: nil, endIndex: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?championIds=23,24,25&api_key=\(lol.api_key)"))
        
        lol.getMatchHistory(22264075, championIds: championIds, rankedQueues: rankedQueues, beginIndex: nil, endIndex: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?championIds=23,24,25&rankedQueues=RANKED_SOLO_5x5,RANKED_TEAM_3x3,RANKED_TEAM_5x5&api_key=\(lol.api_key)"))
        
        lol.getMatchHistory(22264075, championIds: championIds, rankedQueues: rankedQueues, beginIndex: 0, endIndex: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?championIds=23,24,25&rankedQueues=RANKED_SOLO_5x5,RANKED_TEAM_3x3,RANKED_TEAM_5x5&beginIndex=0&api_key=\(lol.api_key)"))
        
        lol.getMatchHistory(22264075, championIds: championIds, rankedQueues: rankedQueues, beginIndex: 0, endIndex: 200)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?championIds=23,24,25&rankedQueues=RANKED_SOLO_5x5,RANKED_TEAM_3x3,RANKED_TEAM_5x5&beginIndex=0&endIndex=200&api_key=\(lol.api_key)"))
        
        lol.getMatchHistory(22264075, championIds: nil, rankedQueues: rankedQueues, beginIndex: nil, endIndex: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.2/matchhistory/22264075?rankedQueues=RANKED_SOLO_5x5,RANKED_TEAM_3x3,RANKED_TEAM_5x5&api_key=\(lol.api_key)"))
    }
    
    func testStatsURL() {
        lol.getRankedStats(22264075, season: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/22264075/ranked?api_key=\(lol.api_key)"))
        
        lol.getRankedStats(22264075, season: SEASON.three)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/22264075/ranked?season=SEASON3&api_key=\(lol.api_key)"))
        
        lol.getPlayerStatsSummary(22264075, season: nil)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/22264075/summary?api_key=\(lol.api_key)"))
        
        lol.getPlayerStatsSummary(22264075, season: SEASON.five2015)
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/22264075/summary?season=SEASON2015&api_key=\(lol.api_key)"))
    }
    
    func testSummonerURL() {
        lol.getSummonerObject(["Fabecio", "Summer Williams"])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/Fabecio,SummerWilliams?api_key=\(lol.api_key)"))
        
        lol.getSummonerObject([23, 24, 25])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.4/summoner/23,24,25?api_key=\(lol.api_key)"))
        
        lol.getMasteryPages([22264075, 23, 1473625])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.4/summoner/22264075,23,1473625/masteries?api_key=\(lol.api_key)"))
        
        lol.getSummonerNames([23, 24, 25])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.4/summoner/23,24,25/name?api_key=\(lol.api_key)"))
        
        lol.getRunePages([23, 24, 25])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v1.4/summoner/23,24,25/runes?api_key=\(lol.api_key)"))
        
    }
    
    func testTeamURL() {
        lol.getTeams([22264075, 24760395, 29264097, 22127530, 534470, 39101259, 575217, 55323233, 21359877, 19363161])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.4/team/by-summoner/22264075,24760395,29264097,22127530,534470,39101259,575217,55323233,21359877,19363161?api_key=\(lol.api_key)"))
        
        lol.getTeams(["TEAM-42a8de80-ebfe-11e2-bc40-782bcb4d0bb2","TEAM-646831b0-4a86-11e3-8042-782bcb4d186"])
        XCTAssertEqual(lol.URL!, NSString(string: "https://na.api.pvp.net/api/lol/na/v2.4/team/TEAM-42a8de80-ebfe-11e2-bc40-782bcb4d0bb2,TEAM-646831b0-4a86-11e3-8042-782bcb4d186?api_key=\(lol.api_key)"))
    }
}
