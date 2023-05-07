import Foundation

public final class EnkaClient {
    
    // MARK: - Public Properies
    
    /// Language of the EnkaClient
    let language: EnkaLanguage
    
    /// User Agent string. Should include application name and version,
    /// for example "Enka-App/1.2.3". If nil, the default agent for EnkaNetworkKit will be used instead
    let userAgent: String?
    
    // TODO: Fix this propery on Windows and make it public
    /// Current cache size in bytes.
    private var cacheSize: Int {
        cacheService.cacheSize
    }
    
    // MARK: - Private Properties
    
    /// Service for network requests
    private lazy var service: EnkaAPIService = EnkaAPIService(userAgent: userAgent)
    private lazy var cacheService: EnkaCacheService = EnkaCacheService()
    
    // MARK: - Initialization
    
    /// Creates an instance of EnkaClient that uses OS language.
    /// If OS language is not supported by EnkaNetwork, the 'defaultLanguage' parameter will be used instead
    /// - Parameter defaultLanguage: Language to use if the current OS language is not supported by EnkaNetwork
    /// - Parameter userAgent: User Agent, should include application name and version. If nil, the default user agent for EnkaNetworkKit will be used
    public init(defaultLanguage: EnkaLanguage = .en, userAgent: String? = nil) {
        let languageManager = EnkaLanguageManager(defaultLanguage: defaultLanguage)
        self.language = languageManager.closestTo(languages: Locale.preferredLanguages)
        self.userAgent = userAgent
    }
    
    /// Creates an instance of EnkaClient that ignores OS language settings and uses the provided language instead
    /// - Parameter language: Language that EnkaClient will use
    /// - Parameter userAgent: User Agent, should include application name and version. If nil, the default user agent for EnkaNetworkKit will be used
    public init(fixedLanguage language: EnkaLanguage, userAgent: String? = nil) {
        self.language = language
        self.userAgent = userAgent
    }
    
    // MARK: - Async Methods
    
    /// Loads basic player info using player uid
    /// - Parameter uid: Player's UID
    /// - Returns: Basic player info
    public func playerInfo(forUid uid: String) async throws -> EnkaPlayerInfo {
        try await service.loadPlayerInfo(withUid: uid)
    }
}

//
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣾⡿⣿⣿⣿⣿⣿⣶⠳⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣿⣿⣿⣿⣿⠿⠿⠛⣳⣼⡿⣟⢛⡻⠃⠀⢈⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⠀⠀⠉⠻⠿⠛⠉⠉⠀⠀⠀⠀⢨⡭⢦⣶⠛⡏⠁⠀⡴⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠤⠦⣀⠟⠓⢧⡤⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⡿⠋⠀⠀⠀⣀⡤⠶⠚⠫⠭⠒⠋⠀⠀⠀⠀⠙⣶⡞⢦⡿⠛⠲⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠿⣿⣿⠋⠀⢀⣀⡤⠞⠉⠀⠀⠀⠀⡀⠤⠄⠂⢀⣤⡤⠞⠛⢧⣂⡇⣀⡄⠀⠉⠓⠶⣤⣀⣀⠀⠀⢀⣀⣀⡤⠴⠒⣺⠋⠀⠀⢀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏⠀⣀⣀⣀⣀⣀⡀⠠⠀⠀⠐⠈⢉⣀⡤⠴⠖⠋⠉⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠐⢦⡀⠈⠉⠁⠀⠀⠀⢀⡴⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠳⢦⣤⡤⠤⠤⠖⠒⠛⠛⠉⠁⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠳⣀⠀⠀⠀⣠⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⢳⡖⠶⠒⠒⠒⠒⠚⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⢦⡈⠳⣤⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡞⠀⠀⠀⠀⠀⠀⡀⠀⠀⡏⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⢸⣷⣄⠙⢯⡙⠲⠶⠶⢶⡶⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠈⠳⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⢰⠃⠀⢰⠃⠀⠀⠀⠀⠀⠀⣿⣄⠀⠀⠀⠀⣸⢁⣻⣿⣦⡶⣄⡤⠖⠋⠀⠀⠀⠀⠀⠀⠀⠀⢀
//⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠉⢑⡦⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⡏⠀⠀⣼⠀⠀⠀⠀⠀⠀⠀⡏⠘⢦⡀⠀⠛⠻⢿⣿⣿⡟⠀⠙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾
//⠀⠀⠀⠀⠀⠀⠀⣠⣾⠴⠚⠉⠀⠀⠀⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀⢸⠃⠀⢠⣿⠀⠀⠀⠀⠀⠀⠀⡇⠴⠊⠙⢧⡀⠀⠀⠉⢿⡅⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿
//⠠⢤⣤⠶⠖⠚⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⠀⢀⡯⠄⢠⡞⢻⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢀⣤⣉⢷⢤⣀⠀⠉⠀⠀⠀⠈⣧⠀⠀⢀⣠⣶⣿⣿⣿⣿
//⠀⠀⠈⠙⠲⢤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠀⢀⡴⠛⠃⣠⠏⠀⠈⣇⠀⠀⠀⠀⠀⠀⣷⠀⣰⣟⠛⣿⣾⣿⣿⣧⠀⠀⠀⠀⠀⠈⣆⣴⢿⣿⣿⣿⣿⣿⣿
//⠀⠀⠀⠀⣰⠏⠀⠉⣩⠉⠑⠒⠒⠒⠒⠀⠀⠒⡟⠀⠀⠀⠀⠀⠀⠀⠀⢀⡞⠁⣀⣠⣀⣘⢦⠀⠀⠀⠀⠀⢻⣸⣿⣿⡇⢻⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⢸⣷⣴⣿⣽⣿⡟⢿⡏
//⠀⠀⠀⢠⠇⠀⠀⣸⠃⠀⠀⠀⠀⠀⢠⡇⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⢿⣿⣿⣿⣿⠿⣿⢦⣀⠀⠀⠈⣿⣇⢸⡇⣸⣿⣿⣿⣿⣷⠀⠀⠀⠀⡀⠀⢯⢉⣉⡀⠉⠑⢿⣀
//⠀⠀⠀⣾⠀⠀⢠⠇⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠠⣾⣿⠃⣾⣿⣿⡏⢸⣷⠀⠀⠈⠙⠓⠦⠼⡏⠘⠁⣿⡿⢇⣻⡿⢿⡄⠀⠀⠀⣿⠀⢸⡈⠓⠛⠀⠀⠀⢸
//⠀⠀⠀⢿⠀⠀⡟⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⠀⠀⠀⠀⢸⠀⠀⠈⠻⡇⠹⣟⠛⠃⠈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡗⠛⠛⠋⠉⡇⠀⠀⠀⢹⡇⢀⡇⠀⠀⠀⠀⠀⡎
//⠀⠀⠀⠘⡆⢰⠃⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⢸⠀⡀⠀⠀⠀⢸⡄⠀⠀⠀⣇⠀⠉⠉⡀⠀⠀⠀⣀⡤⠴⠲⣦⡖⠀⢀⣼⣿⢳⡄⠀⠀⠀⢱⠀⠀⠀⢸⠇⢸⣀⣀⣴⣲⡆⣸⠁
//⠀⠀⠀⠀⠙⢾⡀⠀⠀⠀⠀⠀⠀⠀⢺⡀⠀⢸⡇⠘⡄⠀⠀⠀⣧⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⣾⠁⠀⠀⢀⡽⣁⣴⣿⣿⣿⡏⡇⠀⠀⠀⢸⠀⠀⠀⡿⣠⠏⠈⠈⡇⠁⢰⠏⠀
//⠀⠀⠀⠀⠀⠀⣧⠀⠀⡀⠀⠀⠀⠀⠈⣿⣄⠀⢣⠀⢱⡀⠀⠀⢻⡆⠀⠀⠀⢿⣖⠀⠀⣀⣀⣙⣀⣀⣀⣠⣾⣿⣿⣿⣿⣿⠀⢧⠀⠀⠀⡘⠀⠀⢠⡷⠋⠀⠀⢀⡇⠀⡾⠀⠀
//⠀⠀⠀⠀⠀⠀⠘⣦⠀⠷⣤⣀⣤⣤⠤⠬⢭⣷⣬⣧⠈⢷⡀⠀⠀⢿⡄⠀⠀⠈⢿⣿⣷⣮⣽⣍⣽⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⡾⠀⠀⠀⡇⠀⢀⡞⠀⠀⠀⠀⢸⠇⢠⡇⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠈⠙⠇⢰⣿⣷⣶⠀⠀⠀⠐⢿⣿⣦⢸⣿⣆⠀⠈⢿⣆⠀⠀⠈⢻⣿⣿⣿⣯⣿⣿⣿⠿⢿⠿⣿⡿⠃⡀⢠⣿⠀⠀⣼⠁⢠⠞⠀⠀⠀⠀⣤⡏⠀⢸⡇⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣦⣦⣿⣿⣿⣿⡿⠛⠦⣄⠙⢆⡀⠀⠀⠙⢿⣿⣟⣯⡅⠀⣀⣴⠟⠁⠀⠀⣿⡞⠸⣄⣰⣗⣚⣁⣀⣀⣠⣤⣞⣉⣹⣿⣾⡇⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⡤⢤⣀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⢀⣤⣾⣿⣶⣽⣦⣄⣀⠀⠙⣿⠷⢶⠚⠉⠀⠀⠀⠀⣠⠟⠀⠀⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⡇⠀⠈⢳⡀⣠⠼⠛⠿⠿⠿⠿⠿⠟⢧⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠉⠀⠀⡠⠀⠀⠀⠐⣲⠿⠋⠀⠀⠀⡏⢿⣟⠿⠿⠿⠿⠿⢿⣿⣿⣿⡿⠟⢻⡀⠀
//⠀⠀⠀⠀⠀⠀⢰⠃⠀⠀⠀⢻⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⣀⠜⠁⢀⣠⠔⠋⠁⢀⠠⠄⠀⠀⡇⠀⠈⠙⠲⢤⡀⠀⣴⣿⣧⡇⠀⠀⠀⢷⠀
//⠀⠀⠀⠀⠀⠀⡿⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠿⠟⠻⠿⠯⠤⠴⠯⠕⠒⠛⠉⠀⠀⠐⠈⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠙⢶⣿⣿⡇⡇⠀⠀⠀⠈⢇
//⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⠀⠀⢸⡆⠀⠀⣠⡴⠒⠒⠉⢳⡀⠀⠀⠀⠀⠀⠀⣰⠂⠀⠀⠀⠀⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⢹⡏⠻⣽⡀⠀⠀⠀⠘
//⠀⠀⠀⠀⠐⠁⠀⠀⠀⠀⠀⣀⡼⢃⡴⠋⠁⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⢠⠏⠂⠀⠀⠀⠀⠘⢿⡦⣀⡀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⢸⢹⠀⠙⢧⠀⠀⠀⠀
//⠀⢀⣠⠀⠀⠀⠀⠀⠀⢀⣿⠋⣠⢾⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⠂⣀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣸⠀⠀⠈⣧⠀⠀⠀
