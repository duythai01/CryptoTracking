//
//  PreviewProvider+.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/10/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init () {}

    let coin = Coin(id: "bitcoin",
                          symbol: "btc",
                          name: "Bitcoin",
                          image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                          currentPrice: 26848,
                          marketCap: 524054582571,
                          marketCapRank: 1,
                          fullyDilutedValuation: 564009470005,
                          totalVolume: 10011172755,
                          high24H: 26856,
                          low24H: 26571,
                          priceChange24H: 29.61,
                          priceChangePercentage24H:  0.11041,
                          marketCapChange24H: -358687319.45062256,
                          marketCapChangePercentage24H: -0.0684,
                          circulatingSupply: 19512343,
                          totalSupply: 21000000,
                          maxSupply: 21000000,
                          ath: 69045,
                          athChangePercentage: -61.18871,
                          athDate: "2021-11-10T14:24:11.849Z",
                          atl: 67.81,
                          atlChangePercentage: 39418.5938,
                          atlDate: "2013-07-06T00:00:00.000Z",
                          roi: nil, lastUpdated: "2023-10-13T07:19:59.423Z",
                          sparklineIn7D: SparklineIn7D(price: [
                                            27517.47659313017,
                                            27558.748584098343,
                                            27562.639686375685,
                                            27534.994803406487,
                                            27503.43709227742,
                                            27494.18273652981,
                                            27620.121334693493,
                                            27621.813080590975,
                                            27702.884509536205,
                                            27683.873490852977,
                                            27701.91202188015,
                                            27243.358912167776,
                                            27456.300949264096,
                                            27662.24505724077,
                                            28013.47513717081,
                                            27892.269316717717,
                                            27981.479515547853,
                                            27917.380788407478,
                                            27985.7686619,
                                            27985.153411120693,
                                            28141.091408717115,
                                            28015.369152584746,
                                            27958.196437350485,
                                            27935.45095504778,
                                            27929.06137059663,
                                            27919.728618535293,
                                            27928.21340921988,
                                            27933.38550086624,
                                            27916.173694762296,
                                            27918.823019136453,
                                            27905.662730230513,
                                            28019.428794289277,
                                            27955.69272098428,
                                            27952.4164201191,
                                            27951.995889644913,
                                            27975.65933688445,
                                            27954.276783733738,
                                            27962.347106863614,
                                            27954.76428701786,
                                            27965.11535213417,
                                            27963.657703192323,
                                            27902.221666935628,
                                            27876.74105849813,
                                            27933.844027691975,
                                            27959.75997497363,
                                            27974.7571037059,
                                            27977.543490700005,
                                            27991.261470727324,
                                            28018.263813642363,
                                            28031.083435007025,
                                            28088.344154516606,
                                            27941.92298575307,
                                            27950.417711989663,
                                            27910.307222168412,
                                            27922.817290402683,
                                            27918.183840966572,
                                            27920.63263879015,
                                            27838.539286459865,
                                            27831.66156449875,
                                            27834.03341170247,
                                            27945.573583737674,
                                            27938.916346723378,
                                            27907.122197042805,
                                            27925.396851235255,
                                            27890.631604658025,
                                            27876.307273823193,
                                            27902.96253787604,
                                            27924.562097939088,
                                            27976.4021826868,
                                            27919.889110632826,
                                            27948.10365174851,
                                            27841.982877887764,
                                            27984.53805572639,
                                            27956.367599384863,
                                            27940.268226458327,
                                            27945.412331761243,
                                            27871.811818805272,
                                            27921.657949143835,
                                            27843.34062675791,
                                            27752.810045457743,
                                            27556.74411716421,
                                            27542.403193736372,
                                            27502.801112830097,
                                            27477.190872892766,
                                            27489.23855019311,
                                            27486.740612263195,
                                            27453.06304817622,
                                            27354.09084225846,
                                            27559.128308514988,
                                            27572.180546705335,
                                            27591.706658325187,
                                            27573.027758649736,
                                            27615.671048556298,
                                            27600.1025698656,
                                            27593.782534439666,
                                            27571.567985797705,
                                            27611.436747140113,
                                            27710.146587078358,
                                            27636.303091005208,
                                            27598.071725636022,
                                            27609.302251256828,
                                            27660.99451194319,
                                            27656.898901443343,
                                            27677.881446981675,
                                            27661.691949007287,
                                            27633.558104025575,
                                            27555.45416110842,
                                            27459.682235694843,
                                            27388.105989378175,
                                            27461.663275495994,
                                            27435.691802347716,
                                            27476.34616279916,
                                            27382.816290914565,
                                            27303.143762531436,
                                            27393.220734339226,
                                            27398.76882334203,
                                            27452.602014430508,
                                            27453.037553654438,
                                            27392.247702732497,
                                            27461.472926157647,
                                            27433.905574327717,
                                            27151.18796617716,
                                            27023.346113858555,
                                            27133.927296610043,
                                            27099.309393041272,
                                            27070.961853932353,
                                            27050.58956036679,
                                            27091.825435691575,
                                            27246.92567767454,
                                            27267.090378202716,
                                            27200.90759681216,
                                            27167.994395067362,
                                            27153.939800999113,
                                            27110.16947195278,
                                            26836.396715304458,
                                            26655.469046498078,
                                            26634.191751329097,
                                            26697.636089323183,
                                            26779.7722099829,
                                            26696.835596364646,
                                            26721.28918900755,
                                            26782.107677394106,
                                            26878.332841551837,
                                            26803.037160298893,
                                            26778.41225232315,
                                            26900.51950068074,
                                            26838.024608426476,
                                            26839.239935782385,
                                            26852.39455563419,
                                            26872.584515514718,
                                            26801.395089802365,
                                            26789.804116505198,
                                            26738.114236039168,
                                            26753.93158518172,
                                            26856.493568419337,
                                            26811.482197063313,
                                            26732.30125492664,
                                            26670.119454928456,
                                            26666.25252910143,
                                            26678.015256065097,
                                            26621.40736495772,
                                            26648.904590943523,
                                            26707.412827433964,
                                            26727.794166278334,
                                            26727.676890464933,
                                            26741.573640176197,
                                            26729.137205815106,
                                            26803.279034641575
                          ]),
                    priceChangePercentage1HInCurrency: 0.1834080225255728, currentHoldings: 0.2345)

    let conins15 = [
        Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 29958.571358, marketCap: 584808995221, marketCapRank: 1, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:24:11.849Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:55.620Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "ethereum", symbol: "eth", name: "Ethereum", image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 1634.453693, marketCap: 196373304770, marketCapRank: 2, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:24:19.604Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:03.501Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "tether", symbol: "usdt", name: "Tether", image: "https://assets.coingecko.com/coins/images/325/large/Tether.png?1696501661", currentPrice: 1.000336, marketCap: 84209507868, marketCapRank: 3, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2018-07-24T00:00:00.000Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:35:00.555Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "binancecoin", symbol: "bnb", name: "BNB", image: "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970", currentPrice: 214.860484, marketCap: 33004927207, marketCapRank: 4, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-05-10T07:24:17.097Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:01.646Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "ripple", symbol: "xrp", name: "XRP", image: "https://assets.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 0.517994, marketCap: 27654350308, marketCapRank: 5, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2018-01-07T00:00:00.000Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:03.292Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "usd-coin", symbol: "usdc", name: "USDC", image: "https://assets.coingecko.com/coins/images/6319/large/usdc.png?1696506694", currentPrice: 0.999974, marketCap: 25543434100, marketCapRank: 6, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2019-05-08T00:40:28.300Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:58.952Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "staked-ether", symbol: "steth", name: "Lido Staked Ether", image: "https://assets.coingecko.com/coins/images/13442/large/steth_logo.png?1696513206", currentPrice: 1633.524758, marketCap: 14408301670, marketCapRank: 7, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:40:47.256Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:55.142Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "solana", symbol: "sol", name: "Solana", image: "https://assets.coingecko.com/coins/images/4128/large/solana.png?1696504756", currentPrice: 28.756146, marketCap: 11910360388, marketCapRank: 8, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-06T21:54:35.825Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:01.530Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "cardano", symbol: "ada", name: "Cardano", image: "https://assets.coingecko.com/coins/images/975/large/cardano.png?1696502090", currentPrice: 0.257771, marketCap: 9008125407, marketCapRank: 9, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-09-02T06:00:10.474Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:59.993Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "dogecoin", symbol: "doge", name: "Dogecoin", image: "https://assets.coingecko.com/coins/images/5/large/dogecoin.png?1696501409", currentPrice: 0.060883, marketCap: 8607778440, marketCapRank: 10, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-05-08T05:08:23.458Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:01.795Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "tron", symbol: "trx", name: "TRON", image: "https://assets.coingecko.com/coins/images/1094/large/tron-logo.png?1696502193", currentPrice: 0.090372, marketCap: 8057737963, marketCapRank: 11, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2018-01-05T00:00:00.000Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:58.042Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "the-open-network", symbol: "ton", name: "Toncoin", image: "https://assets.coingecko.com/coins/images/17980/large/ton_symbol.png?1696517498", currentPrice: 2.154724, marketCap: 7568843677, marketCapRank: 12, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-12T06:50:02.476Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:56.084Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "matic-network", symbol: "matic", name: "Polygon", image: "https://assets.coingecko.com/coins/images/4713/large/matic-token-icon.png?1696505277", currentPrice: 0.563045, marketCap: 5239052386, marketCapRank: 13, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-12-27T02:08:34.307Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:54.817Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "chainlink", symbol: "link", name: "Chainlink", image: "https://assets.coingecko.com/coins/images/877/large/chainlink-new-logo.png?1696502009", currentPrice: 9.279047, marketCap: 5103687268, marketCapRank: 14, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-05-10T00:13:57.214Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:59.696Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "polkadot", symbol: "dot", name: "Polkadot", image: "https://assets.coingecko.com/coins/images/12171/large/polkadot.png?1696512008", currentPrice: 3.847315, marketCap: 4956288313, marketCapRank: 15, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-04T14:10:09.301Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:57.802Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "wrapped-bitcoin", symbol: "wbtc", name: "Wrapped Bitcoin", image: "https://assets.coingecko.com/coins/images/7598/large/wrapped_bitcoin_wbtc.png?1696507857", currentPrice: 30001.428077, marketCap: 4880339331, marketCapRank: 16, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:40:19.650Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:55.616Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)

        ]

    let coins5 = [
        Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 29958.571358, marketCap: 584808995221, marketCapRank: 1, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:24:11.849Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:37:55.620Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "ethereum", symbol: "eth", name: "Ethereum", image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 1634.453693, marketCap: 196373304770, marketCapRank: 2, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-11-10T14:24:19.604Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:03.501Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "tether", symbol: "usdt", name: "Tether", image: "https://assets.coingecko.com/coins/images/325/large/Tether.png?1696501661", currentPrice: 1.000336, marketCap: 84209507868, marketCapRank: 3, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2018-07-24T00:00:00.000Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:35:00.555Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "binancecoin", symbol: "bnb", name: "BNB", image: "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970", currentPrice: 214.860484, marketCap: 33004927207, marketCapRank: 4, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2021-05-10T07:24:17.097Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:01.646Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,

        Coin(id: "ripple", symbol: "xrp", name: "XRP", image: "https://assets.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 0.517994, marketCap: 27654350308, marketCapRank: 5, fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: nil, priceChangePercentage24H: nil, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: "2018-01-07T00:00:00.000Z", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: "2023-10-22T13:38:03.292Z", sparklineIn7D: nil, priceChangePercentage1HInCurrency: nil, currentHoldings: nil)
        ,
    ]
}
