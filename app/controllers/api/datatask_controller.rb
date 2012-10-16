class Api::DatataskController < Api::SbController
  def getAllWords
    #abort()
    # 1534724626
    # 100001251207812
    # 1400936598
    #a = Sbdbindexing.find("wordpackage_indexing")
    b = Wordpacks.find("wordpack_45dd9da02fd3ac39752070b43a6d9b79")
    @packID = b.id
    @packName = b.packName
    @packImage = b.imageName
    
    @commands = []
    wordIDs = b.wordIds
    wordIDs.each do |wordID|
      begin
      	a = Words.find(wordID)
        wordName = a.wordName 
        wordCoin = a.wordCoin
        @commands << 'createWord("'+wordID+'", pack'+@packName+'ID, "'+wordName+'", '+wordCoin+')'
      rescue Exception => e
      end
    end
  end
  
  def mytest
    #createAllWords
    # a = Sbdbindexing.find("ongame_100_theirscene_1534724626")
    #a = Sbdbindexing.find("ongame_100_theirscene_1400936598")
    #invitedGameIDs = a.arrayvalue
    render json: {}
  end
  
  def createAllWords
    begin # get wordpack indexing
    	a = Sbdbindexing.find("wordpackage_indexing")
      a.arrayvalue = []
      a.save
    rescue Exception => e
      Sbdbindexing.newIndex("wordpackage_indexing")
    end
    a = Sbdbindexing.find("wordpackage_indexing")
    a.arrayvalue << "wordpack_23e876f0d97552e97e8d6a35459ca38d"
    a.arrayvalue << "wordpack_3e6ce293bd96fb9c171a11a8e8ce8df1" 
    a.arrayvalue << "wordpack_0e676ccc53728aa0ce7d163501c3c80b"
    a.arrayvalue << "wordpack_facb79010c8bfb9361bdf67dae69496e"
    a.arrayvalue << "wordpack_3c0e367f960f2386752a20430aa6c3e4"
    a.arrayvalue << "wordpack_525561786d29a88d23aaa40bb203d305"
    a.arrayvalue << "wordpack_303088967bb0f76af9038e5f79227283"
    a.arrayvalue << "wordpack_0b184b9c2e169c97e41f3a4b81e1f9ab"
    a.arrayvalue << "wordpack_45dd9da02fd3ac39752070b43a6d9b79"
    a.save
    
    
    # create pack "Actor" 
    packActorID = "wordpack_23e876f0d97552e97e8d6a35459ca38d" 
    
    createPack(packActorID, "Actor", "actor") 
    
    createWord("word_3b99fd8b9d3685cbb699663402ed913d", packActorID, "Ashton Kutcher", 2) 
    createWord("word_1421ced2dfdfee62a1bacdf12f4ff5d4", packActorID, "Bruce Lee", 2) 
    createWord("word_172c7da3f62e5323c102ac99b6356f65", packActorID, "Robert De Niro", 3) 
    createWord("word_284558caf4af64a5ad1767046fb859a0", packActorID, "Al Pacino", 3) 
    createWord("word_288dd721d0094236794143c652882fac", packActorID, "Sylvester Stallone", 3) 
    createWord("word_a7ee3175b09e5979180c0d7724441b4e", packActorID, "Tom Cruise", 3) 
    createWord("word_40d12b8a875343ea46852bf33952263a", packActorID, "Johnny Depp", 3) 
    createWord("word_8fd757fd9e096c09c412e45a5ac90ab0", packActorID, "John Travolta", 3) 
    createWord("word_6197e566d69d4eb2a3455c9a2993ee20", packActorID, "Bruce Willis", 3) 
    createWord("word_0ef8c9a2f6211f20a391db0c799f7b9f", packActorID, "Arnold Schwarzenegger", 3) 
    createWord("word_770f6004d64ab4d126c75e4bf9eb4c0e", packActorID, "Jackie Chan", 3) 
    createWord("word_c746805859e9eb57ede4e1581487efd1", packActorID, "Adam Sandler", 10) 
    createWord("word_689a0268709126308392dc559358d40b", packActorID, "Tom Hanks", 3) 
    createWord("word_b055c81fa31cb21d3f113756c008d7b7", packActorID, "Robin Williams", 3) 
    createWord("word_a234b631a76e748c394089133e23e998", packActorID, "Dustin Hoffman", 3) 
    createWord("word_898eba4c7966b5ce6561e4c701f241d5", packActorID, "Jim Carrey", 3) 
    createWord("word_9b86a266160e35b9014c29d4190a0103", packActorID, "Eddie Murphy", 3) 
    
    
    # create pack "Animal" 
    packAnimalID = "wordpack_3e6ce293bd96fb9c171a11a8e8ce8df1" 
    
    createPack(packAnimalID, "Animal", "animal") 
    
    createWord("word_3b6607745ee314c38a4696091f896769", packAnimalID, "Monkey", 1) 
    createWord("word_51fff893941fc3d55c0a4a04b234f6dd", packAnimalID, "Elephant", 2) 
    createWord("word_0f7d80a84fe954ccf6afb692639fe0d7", packAnimalID, "Snake", 1) 
    createWord("word_125cbc234bf32522167534dd7dd55c5a", packAnimalID, "Chicken", 1) 
    createWord("word_e245ead9b02b3cd84cce0c0cf84de5a1", packAnimalID, "Tiger", 1) 
    createWord("word_2a1ea88af060923da415afa4e9bb530a", packAnimalID, "Lion", 1) 
    createWord("word_a219145311055663b78d24c460968012", packAnimalID, "Eagle", 1) 
    createWord("word_b64bc7204d730fbd4f1ef3b13d3cd439", packAnimalID, "Mouse", 1) 
    createWord("word_71ce1d3ed3f7fa5bdf1589cbbc35aed6", packAnimalID, "Cat", 1) 
    createWord("word_a4eb121f0cc4cedb0233f6f7742d52f5", packAnimalID, "Dog", 1) 
    createWord("word_2930095d01692de4a1a4d9c97f0f1644", packAnimalID, "Sheep", 1) 
    createWord("word_0c87828f235241563c0a42d639f18190", packAnimalID, "Butter Fly", 1) 
    createWord("word_62512b3ab7120713b61be26526fb2cee", packAnimalID, "Parrot", 1) 
    createWord("word_59f3cabd3b0071a798493bee71fae1f6", packAnimalID, "Duck", 1) 
    createWord("word_e284f411bab6f81e81b3ec147ad6befb", packAnimalID, "Pig", 1) 
    createWord("word_e0a84ac85ee48e4f91a2fa77ecab4dee", packAnimalID, "Cow", 1) 
    createWord("word_ab58705525ecc9a5c827b7fc59fa3d1b", packAnimalID, "Lobster", 2) 
    createWord("word_45557d0927dd880e0e33db941b645fd7", packAnimalID, "Owl", 1) 
    createWord("word_3c9f63342ee5fe478ed79d3094e20837", packAnimalID, "Crab", 1) 
    createWord("word_db2c5431afacbc9b641666955ce2eee1", packAnimalID, "Shark", 1) 
    createWord("word_176cc16d83272472d4eb74aabfe9d7d0", packAnimalID, "Grasshopper", 1) 
    createWord("word_3ffdf4522381873be7550c2bf60778b6", packAnimalID, "Chihuahua", 1) 
    createWord("word_c8be3018b30561b563fb07240ea9f4ac", packAnimalID, "Panda", 1) 
    createWord("word_b94c95b47ab48c74ef5c571b19f10914", packAnimalID, "Rattlesnake", 1) 
    createWord("word_fed975efddd61316d7cc696153d279d3", packAnimalID, "Wolf", 1) 
    createWord("word_b421216a3cd9e8dce8d01975348b4793", packAnimalID, "Whale", 1) 
    createWord("word_145a33ff71e8d95da5fef020e2d8cef7", packAnimalID, "Dolphin", 1) 
    createWord("word_837b5b7c969409cdb9c2d0b6a8573cb7", packAnimalID, "Squirrel", 1) 
    createWord("word_9d000abae105bff6752dec817257ac8e", packAnimalID, "Bear", 1) 
    createWord("word_92c018ed443692856415464758abb987", packAnimalID, "Poodle", 1) 
    createWord("word_276a8ad87ee425d8967e7530139f3dd7", packAnimalID, "Horse", 1) 
    createWord("word_ec320d5c24485e69c27b23c282109729", packAnimalID, "Chimpanzee", 1) 
    createWord("word_bb0319e8a2fe4c1388833f1de9af0165", packAnimalID, "Frog", 1) 
    createWord("word_cf35c3b2fd788499c583fbda60a02ffe", packAnimalID, "Turkey", 1) 
    createWord("word_546d830917920cbc74ab4cbbc21e3953", packAnimalID, "Penguin", 1) 
    createWord("word_95d788f9e365ab5034db1a1f614c3aaf", packAnimalID, "Crocodile", 1) 
    createWord("word_851eeb26df382aaafbd4321ffa463108", packAnimalID, "Kangaroo", 1) 
    createWord("word_969066298e783cbdb3d72770b24ba977", packAnimalID, "Beaver", 1) 
    createWord("word_8fd175f6f4fe4b967cf41e275df8b559", packAnimalID, "Rhino", 1) 
    createWord("word_c62ae771feb7b3917654405b8a0998c9", packAnimalID, "Gorilla", 1) 
    
    
    # create pack "Entrepre- neur" 
    packEntrepreneurID = "wordpack_0e676ccc53728aa0ce7d163501c3c80b" 
    
    createPack(packEntrepreneurID, "Entrepre- neur", "entrepeneur") 
    
    createWord("word_1d6bb8978c0532b2385daafeae350d73", packEntrepreneurID, "Bill Gates", 3) 
    createWord("word_efb42e99c8db400dafb4571821e90a4c", packEntrepreneurID, "Steve Jobs", 3) 
    createWord("word_2342732661bd9c0b6b204d106874058e", packEntrepreneurID, "Thomas Edison", 2) 
    createWord("word_edd1aee8545ac106ceddbb7e31f5f2b7", packEntrepreneurID, "Henry Ford", 2) 
    createWord("word_ef4e82177287055f8f85381ee9a77240", packEntrepreneurID, "Mark Zuckerberg", 10) 
    createWord("word_60058f875985328f4add5e60745c12ff", packEntrepreneurID, "Oprah Winfrey", 5) 
    createWord("word_4d33c85eb98846c6ff5a13eaecc4f7f2", packEntrepreneurID, "Donald Trump", 5) 
    createWord("word_745fdebac126159cc37f2a6b653310ec", packEntrepreneurID, "Walt Disney", 2) 
    createWord("word_889d44e0442d42f3427593b0629eb83d", packEntrepreneurID, "Hugh Hefner", 2) 
    createWord("word_8af80cd8669630beba69eb8ddec5e1ee", packEntrepreneurID, "Martha Stewart", 2) 
    createWord("word_3d99c50c2366521547b1821c9b93e162", packEntrepreneurID, "Ross Perot", 2) 
    createWord("word_fca55f372eaba7cf446f08d166f95e9a", packEntrepreneurID, "Jeff Bezos", 2) 
    
    
    # create pack "Movie character" 
    packMoviecharacterID = "wordpack_facb79010c8bfb9361bdf67dae69496e" 
    
    createPack(packMoviecharacterID, "Movie character", "character_male") 
    
    createWord("word_84e929f5829a0221fb929d7c3246493b", packMoviecharacterID, "Darth Vader", 3) 
    createWord("word_5d279cc9d7914b3b373e11fcd236e856", packMoviecharacterID, "James Bond", 3) 
    createWord("word_f13ff4091933865f7dfb368a228a97cc", packMoviecharacterID, "Rocky Balboa", 3) 
    createWord("word_ad7ad7d33d52af1d1144e9a494f0d102", packMoviecharacterID, "Indiana Jones", 3) 
    createWord("word_d1b0a3aae1bc05a759d6e59a473d5330", packMoviecharacterID, "Obi-Wan Kenobi", 3) 
    createWord("word_a6b2e7ec261641ee53447db0dc6e3bd7", packMoviecharacterID, "Tarzan", 3) 
    createWord("word_9eec8abb857afe76e2e0d2cd2e86ce42", packMoviecharacterID, "The Terminator", 3) 
    createWord("word_51e22be1c4e28403a7eca7f4900a3988", packMoviecharacterID, "Hannibal Lecter", 3) 
    createWord("word_648e8575b13563565ed6697b0b081398", packMoviecharacterID, "Gordon Gekko", 3) 
    createWord("word_598bee2ad0b65f3f475a3d81a5220343", packMoviecharacterID, "Hermione Granger", 3) 
    createWord("word_b505e71dfbcc94e9eaef0bf75db19801", packMoviecharacterID, "Lord Voldemort", 3) 
    createWord("word_9a8786578e6a6d40412e43b6d924e71c", packMoviecharacterID, "Albus Dumbledore", 3) 
    createWord("word_119c9fc8e4b9dfa0da1f0649a12cf07e", packMoviecharacterID, "Gollum", 3) 
    createWord("word_ea9981e24a623bb182bbe886f89c706f", packMoviecharacterID, "Frodo", 3) 
    createWord("word_8a43e4cb078ac053a4c0985162cd51d5", packMoviecharacterID, "Buzz Lightyear", 3) 
    createWord("word_9905289dc3ad392fc5a410b18bda99fb", packMoviecharacterID, "Yoda", 3) 
    createWord("word_482e4adde921c5d08bbd3f9badb1caa0", packMoviecharacterID, "Conan O'Brien", 3) 
    createWord("word_8e39acb3fa37c76a999282067efcb85e", packMoviecharacterID, "Chewbacca", 3) 
    createWord("word_9187d059ad0961703fb05a14e2537708", packMoviecharacterID, "Rain Man", 3) 
    createWord("word_5d67aeceb9e629f0342c0bdd73fea0e6", packMoviecharacterID, "Luke Skywalker", 3) 
    
    
    # create pack "Movie title" 
    packMovieTitleID = "wordpack_3c0e367f960f2386752a20430aa6c3e4" 
    
    createPack(packMovieTitleID, "Movie title", "movies") 
    
    createWord("word_5bf5c3e8d2be7aa653ce1a85b2ed6dc6", packMovieTitleID, "Harry Potter", 2) 
    createWord("word_1486a602c05cbf6836f1304867d61724", packMovieTitleID, "Star Wars", 2) 
    createWord("word_2dd65e50d03e4276939949e7e7a41b26", packMovieTitleID, "Lord of the Rings", 2) 
    createWord("word_2a5aeafdffd9e56f6106c1ae3ff22ca1", packMovieTitleID, "Dirty Harry", 2) 
    createWord("word_687ac7d68bd0dd38f6e13a514f2aab4c", packMovieTitleID, "Rain Man", 2) 
    createWord("word_20b62e1b8b84fb5968e40bbbb62a7a36", packMovieTitleID, "The Hunger Games", 3) 
    createWord("word_c84a39a6723896ce35db65c3c7d06477", packMovieTitleID, "The Godfather", 3) 
    createWord("word_8b5b3e27423f6ed9bccefd37cde89a7c", packMovieTitleID, "Pirates of the Caribbean", 3) 
    createWord("word_bfa91a64abcf93fbea37dd2b80a0ebf8", packMovieTitleID, "Toy Story", 2) 
    createWord("word_796b9949d2efe3b6ca2d5a68bb239014", packMovieTitleID, "Batman", 2) 
    createWord("word_784282af331272165409b49c79876d84", packMovieTitleID, "Spiderman", 2) 
    createWord("word_608d006967fde8bf7b8a705cb33214f9", packMovieTitleID, "The Matrix", 3) 
    createWord("word_9d016ccb4386c876d9cacebbbdceb211", packMovieTitleID, "Star Trek", 2) 
    createWord("word_b49d86b9a4355b0ac553c7e3f33d2254", packMovieTitleID, "Alice in Wonderland", 2) 
    createWord("word_9b80aaca523f3e257d99b2a62a23e100", packMovieTitleID, "The Lion King", 2) 
    createWord("word_cb620b30f88947eae38dd45399bd62f8", packMovieTitleID, "Shrek", 2) 
    createWord("word_619ace28cec44d6e20d46e54b7cb9117", packMovieTitleID, "Indiana Jones", 2) 
    createWord("word_0f8aa9f898f8843a2324d236cddfafd0", packMovieTitleID, "Mission Impossible", 3) 
    createWord("word_f6a1ffca58dbd6d528c36915f0a42f3b", packMovieTitleID, "Forrest Gump", 2) 
    createWord("word_e96e3fd38272f8b6a7aa09ee6ecd7ea5", packMovieTitleID, "Kung Fu Panda", 2) 
    createWord("word_fc9b9dd7e1e87f6fb8dcf3caf76a9cfd", packMovieTitleID, "The Sixth Sense", 2) 
    createWord("word_172d054113843087e43fff97b98e2c92", packMovieTitleID, "X-Men", 3) 
    createWord("word_d72bc629f488af6e55aefc2ba9f32062", packMovieTitleID, "Superman", 2) 
    createWord("word_7fd2a5fe37abd53eb635bcbf70430974", packMovieTitleID, "Finding Nemo", 3) 
    
    
    # create pack "TV character" 
    packTVcharacterID = "wordpack_525561786d29a88d23aaa40bb203d305" 
    
    createPack(packTVcharacterID, "TV character", "tv") 
    
    createWord("word_28948f64f12b0ad871f5dbbb5ad4ba13", packTVcharacterID, "Homer Simpson", 3) 
    createWord("word_116fd43f75fb910b8569a86cd288b624", packTVcharacterID, "Seinfeld", 2) 
    createWord("word_d0c67177f87f9ba30cdc8637b701e77a", packTVcharacterID, "Captain Kirk", 3) 
    createWord("word_b665d117cd06a6b54730ac3d0bc2660c", packTVcharacterID, "Tony Soprano", 3) 
    createWord("word_54e784dd4629629a8ff87f0859439574", packTVcharacterID, "Spock", 3) 
    createWord("word_2033cfa6576462dc1c384d04b5fec329", packTVcharacterID, "Jerry Seinfeld", 2) 
    createWord("word_daf35beb29475a8ef60cdc4302e1f20b", packTVcharacterID, "Cosmo Kramer", 2) 
    createWord("word_7faf24a7a356f8c0ccb432e9c63edafb", packTVcharacterID, "Elaine Benes", 2) 
    createWord("word_01a3b17dcb4b5fbec7010d11928766f0", packTVcharacterID, "George Costanza", 2) 
    createWord("word_c3b43412ebe768e0e8df94bb88d8c675", packTVcharacterID, "Bart Simpson", 2) 
    createWord("word_7867f5832ccd010360f99aca4bf7f6c3", packTVcharacterID, "Homer Simpson", 2) 
    createWord("word_98b82a692bc84adbe5e3b69a64a4ffa5", packTVcharacterID, "Lisa Simpson", 2) 
    createWord("word_16ff5ae9fc45b7cebfb8292b551167c6", packTVcharacterID, "Marge Simpson", 2) 
    
    
    # create pack "TV show" 
    packTVshowID = "wordpack_303088967bb0f76af9038e5f79227283" 
    
    createPack(packTVshowID, "TV show", "tv") 
    
    createWord("word_8776902735d94e18bfbeae17f6448382", packTVshowID, "American Idol", 3) 
    createWord("word_059e213ac0b13903e3cb5e38f675fed4", packTVshowID, "The Simpsons", 3) 
    createWord("word_cfe4678e28352fcbc906f216af3fac25", packTVshowID, "Seinfeld", 3) 
    createWord("word_253ffbcfa8c264ba4ebb673fa6858886", packTVshowID, "Star Trek", 3) 
    createWord("word_20bd31bf912eeace60b4b2eb066d09be", packTVshowID, "South Park", 3) 
    createWord("word_29e7ffe6f42fb19bc25c0d2f798ec19a", packTVshowID, "I Love Lucy", 2) 
    createWord("word_b5189804c86aab8e3b3d9f298a05a08e", packTVshowID, "The Sopranos", 2) 
    createWord("word_a8a7ab0234739b5a34a211c79c19b175", packTVshowID, "Friends", 2) 
    createWord("word_25b4fb6d0870a27e4496eb9e02e5fc41", packTVshowID, "Sesame Street", 2) 
    createWord("word_ff1dddd5f41ae39f8ac5cc5b18f3eb4a", packTVshowID, "Frasier", 2) 
    createWord("word_bed763d8da2cf547c8c1e019c1778592", packTVshowID, "The X-Files", 2) 
    createWord("word_a7f6b03fbe36e172dd5e7ac4b01313c6", packTVshowID, "Star Trek", 2) 
    createWord("word_f97f5e60a4b757d19f27b268be320a3d", packTVshowID, "Taxi", 2) 
    createWord("word_fe81b0d5cd097ea9c36b1cbfa8eeec07", packTVshowID, "Lost", 2) 
    createWord("word_d1a01e0435c2e59aa257d2628f16f0d4", packTVshowID, "Mad Men", 2) 
    
    
    # create pack "Musician" 
    packMusicianID = "wordpack_0b184b9c2e169c97e41f3a4b81e1f9ab" 
    
    createPack(packMusicianID, "Musician", "musician") 
    
    createWord("word_c2524650bff605e4a3c1e7f5c24233a4", packMusicianID, "Lady Gaga", 2) 
    createWord("word_82965c7c116c4ee9ee5f8549887b28b8", packMusicianID, "Justin Bieber", 2) 
    createWord("word_b7082cee6bf757cbbd2b9c60431110a2", packMusicianID, "Katy Perry", 2) 
    createWord("word_77818c3d52ff5b1e949b8e1b35b5e9cb", packMusicianID, "Rihanna", 2) 
    createWord("word_2c859bbe7c5c8cee827c578730f9c72f", packMusicianID, "Britney Spears", 2) 
    createWord("word_24a6faafdbd6e39ccbc984575300024f", packMusicianID, "Shakira", 2) 
    createWord("word_1a5266c5347872d6dc0bc17bb9acaa07", packMusicianID, "Taylor Swift", 2) 
    createWord("word_0c947b45ce9597317eb62442f020024c", packMusicianID, "Nicki Minaj", 2) 
    createWord("word_575fdeda654af25531714217d528f380", packMusicianID, "Selena Gomez", 2) 
    createWord("word_4c4d55a17c5371995dcd13e0e053a86b", packMusicianID, "Justin Timberlake", 2) 
    createWord("word_2e3108ef6e0ab99d505b1b9dfcab1037", packMusicianID, "Bruno Mars", 2) 
    createWord("word_f33ca3f2ede9598fea9d0a6433a31c6b", packMusicianID, "Snoop Dogg", 2) 
    createWord("word_f6cee63520776a169e07487eb26ae79c", packMusicianID, "Alicia Keys", 2) 
    createWord("word_5023c73ddd79801df4d88aa33c61c28e", packMusicianID, "Kanye West", 2) 
    createWord("word_f3272e3788917885296f12943c37491e", packMusicianID, "Lil Wayne", 2) 
    createWord("word_3874f9dd9ae03662df1f37248e1af1f5", packMusicianID, "50 Cent", 2) 
    createWord("word_45d41fe87c2a1a16ad5c4e21dcbc3b93", packMusicianID, "Mariah Carey", 2) 
    createWord("word_83eb54181ea9ae30e94403a688ce1c15", packMusicianID, "Adele", 2) 
    createWord("word_e4b98418ba6050e200c016d979b73b3a", packMusicianID, "Ricky Martin", 2) 
    createWord("word_7f2d85eaf280b63675175868e3374bb0", packMusicianID, "Miley Cyrus", 2) 
    createWord("word_28d9268c2196f80af5c7516431c2b170", packMusicianID, "MC Hammer", 2) 
    createWord("word_e537b7d31ed857f9c35e550955f879fa", packMusicianID, "Beyonce", 2) 
    createWord("word_8d1be285571d5731e1fc3d1948ba6fb0", packMusicianID, "Eminem", 2) 
    createWord("word_e92dd436dbbbcd32f397c0558b1a3ef2", packMusicianID, "Michael Jackson", 2) 
    createWord("word_a39bf2e4d79c03c834e5d1c204abd6a6", packMusicianID, "Elvis", 2) 
    createWord("word_fad212e132c06d97adf4cbb2ac9946d8", packMusicianID, "Madonna", 2) 
    
    
    
    # create pack "Actress" 
    packActressID = "wordpack_45dd9da02fd3ac39752070b43a6d9b79" 
    
    createPack(packActressID, "Actress", "actress") 
    
    createWord("word_90b8fe05f2e4660c74b24c40fb66d15c", packActressID, "Marilyn Monroe", 2) 
    createWord("word_9f7c77d3079a465e7a6a509e8cb932a8", packActressID, "Kim Kardashian", 2) 
    createWord("word_e91ad3bb766dc9118e791e3ec25b9d47", packActressID, "Jennifer Lopez", 2) 
    createWord("word_497f7403abf390a49223d51a7b39e50b", packActressID, "Audrey Hepburn", 3) 
    createWord("word_352787497f110a11dd99626e3507bf4f", packActressID, "Meryl Streep", 3) 
    createWord("word_af40db5c07dc3d07fdec497f7b73c83b", packActressID, "Jodie Foster", 3) 
    createWord("word_3845bb892fd2b2aa8ca67633a3cee4be", packActressID, "Angelina Jolie", 5) 
    createWord("word_390c61c29100d23c559d7bc6f4fdbaea", packActressID, "Kate Winslet", 3) 
    createWord("word_2338409bf055cc69576aa73f13f3bf21", packActressID, "Halle Berry", 3) 
    createWord("word_cb7e3358de2e6f9285e6902fa91e95b4", packActressID, "Julia Roberts", 3) 
    createWord("word_4006368519ee149f866b92e01ca8ab20", packActressID, "Gwyneth Paltrow", 3) 
    createWord("word_d131f7922647bd5bee0283f8cddee9f2", packActressID, "Diane Keaton", 3) 
  end
  
  def createPack(packID, packName, packImage)
    begin
      b = Wordpacks.find(packID)
      b.delete
    rescue Exception => e
    end
    b = Wordpacks.new
    b.id = packID
    b.packName = packName
    b.packCoin = 0
    b.imageName = packImage
    b.wordIds = []
    b.save
  end
  
  def createWord(wordID, packID, wordName, wordCoin)
    begin
      b = Words.find(wordID)
      b.delete
    rescue Exception => e
    end
    b = Words.new
    b.id = wordID
    b.packId = packID
    b.wordName = wordName
    b.wordCoin = wordCoin
    b.wordDesc = "Coming soon..."
    b.wordDiffLevel = wordCoin
    b.wordThumbURL = nil
    b.wordIsSponsored = 0
    b.playedCount = 0
    b.save
    
    a = Wordpacks.find(packID)
    a.wordIds << wordID
    a.save
  end
  
  
  def mytest1
    abort()
    #a = Sbdbindexing.find("wordpackage_indexing_cache")
    #a.delete
    
    #a = Sbdbindexing.find("wordpackage_indexing")
    #c = []
    #a.arrayvalue.each do |b|
    #  e = Wordpacks.find(b)
    #  c = c << ["name"=>e.packName, "id"=>e.id]
    #end
    
    #a = Wordpacks.find("wordpack_45dd9da02fd3ac39752070b43a6d9b79")
    #c = a.wordIds
    
    #a = Sbdbindexing.find("ongame_100_theirscene_1400936598")
    #b = a.arrayvalue.delete_if{|x| x[0]["sceneNo"] == 7 && x[0]["sceneID"] == "bba2fd10283afa8b6d722c0cadb878ea1"}
    
    # find index by range
    a = Sbdbindexing.find("user_100_indexing")
    b = a.arrayvalue # ["user_100_indexing_153","user_100_indexing_325","user_100_indexing_100","user_100_indexing_140"]
    
    userIDarray = []
    b.each do |rangeIndex|
      begin
      	c = Sbdbindexing.find(rangeIndex)
        c.arrayvalue.each do |userIDz|
          userIDarray << userIDz
        end
        c.delete
      rescue Exception => e
      end
    end
    
    
    userIDarray.each do |userID|
      playerInfor = Player.find(userID)
      socialType = playerInfor.socialType 
      socialID = playerInfor.socialID
      
      # delete player's games
      deletePlayerGames(socialType, socialID, "createdgame")
      deletePlayerGames(socialType, socialID, "invitedgame")
      
      # delete player's "My Scene" Indexing key
      begin
      	iz = Sbdbindexing.find("ongame_" + socialType + "_myscene_" + socialID)
        iz.delete
      rescue Exception => e
      end
    
      # delete player's "Their Scene" Indexing key
      begin
        iy = Sbdbindexing.find("ongame_" + socialType + "_theirscene_" + socialID)
        iy.delete
      rescue Exception => e
      end
      
      # delete "On Game" indexing
      begin
        ix = Sbdbindexing.find("ongame_" + socialType + "_" + socialID + "_indexing")
        ix.delete
      rescue Exception => e
      end
    
      # delete Player
      playerInfor.delete
    end
    
    a.arrayvalue = []
    a.save
    render json: {}
  end
  
  def deletePlayerGames(socialType, socialID, type)
    a = Sbdbindexing.find("user_" + socialType + "_" + type + "_" + socialID)
    b = a.arrayvalue
    b.each do |f|
      begin
      	g = Game.find(f)
        g.delete
      rescue Exception => e
      end
    end
    a.delete
  end
  
  def mytestz
    #a = Wordpacks.find("wordpack_facb79010c8bfb9361bdf67dae69496e")
    #values = a.wordIds
    #a.wordIds abort()= values << "word_5d67aeceb9e629f0342c0bdd73fea0e6"
    #a.save
    
    
    render json: b
  end
  # List of all key
  
  # top_100_players_" + cSocialType.to_s
  # "user_" + socialType.to_s + "_" user_100_indexing+ socialID.to_s
  # "user_" + socialType.to_s + "_" + winnerID.to_s
  
  # strSocialType = "user_" + socialType.to_s
  # strSocialType + "_createdgame_" + socialID.to_s
  # strSocialType + "_invitedgame_" + socialID.to_s
  # strSocialType + "_indexing_" + socialRange.to_s
  # strSocialType + "_indexing"
  def clearData
    abort()
    begin
      a = Sbdbindexing.find("user_100_indexing")
      b = a.arrayvalue
      
      b.each do |topIndexKey|
        begin
          c = Sbdbindexing.find(topIndexKey)
          d = c.arrayvalue
          
          d.each do |playerID|
            begin
              f = Player.find(playerID)
              
              begin
                g = Sbdbindexing.find("user_100_createdgame_" + f.socialID)
                g.delete
              rescue Exception => e
              end
              
              begin
                h = Sbdbindexing.find("user_100_invitedgame_" + f.socialID)
                h.delete
              rescue Exception => e
              end
            
              begin
              	i = Sbdbindexing.find("ongame_100_" + f.socialID + "_indexing")
                iz = i.arrayvalue
                iz.each do |iy|
                  begin
                  	k = Sbdbindexing.find(iy)
                    k.delete
                  rescue Exception => e
                  end
                end
                i.delete
              rescue Exception => e
              end
              
              f.delete
            rescue Exception => e
            end
          end
          
          c.delete
          
        rescue Exception => e
        end
      end
      a.delete      
    rescue Exception => e
    end
    
    self.jsonRender([], 'Game Created Successfully', '', '100')
  end
end
