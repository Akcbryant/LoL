# LoL
A Swift wrapper for Riot's League of Legends API

1. Initialize with your apikey and a region from the Region enum provided.
2. Use the appropriate method with the appropriate parameters to set up the *URL: String* variable.
3. Use the *URL: String* variable in your favorite networking library.


        var lol = LoL(apiKey: "Your api key here", region: LoL.Region.na)
        lol.getVersions()
            
        Alamofire.request(.GET, lol.URL)
            .responseString { (_, _, JSON, _) in
                println(JSON)
        }

