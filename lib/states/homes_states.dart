enum CatState {INIT , LOADING ,LOADED ,ERROR}
enum MarketsState {INIT , LOADING ,LOADED ,ERROR}
enum MarketSlidersState {INIT , LOADING ,LOADED ,ERROR}
enum MarketOffersState {INIT , LOADING ,LOADED ,ERROR}
enum MarketCategoriesState {INIT , LOADING ,LOADED ,ERROR}
enum MakeOrderState {INIT , LOADING ,LOADED ,ERROR}
enum CurrentOrderState {INIT , LOADING ,LOADED ,ERROR}
enum PreviousOrderState {INIT , LOADING ,LOADED ,ERROR}
enum FetchChatSate {INIT , LOADING ,LOADED ,ERROR}
enum SendMsgSate {INIT , LOADING ,LOADED ,ERROR}

class HomeStates{
  static CatState catState = CatState.INIT;
  static MarketsState marketsState = MarketsState.INIT;
  static MarketSlidersState marketSlidersState = MarketSlidersState.INIT;
  static MarketOffersState marketOffersState = MarketOffersState.INIT;
  static MarketCategoriesState marketCategoriesState = MarketCategoriesState.INIT;
  static MakeOrderState makeOrderState = MakeOrderState.INIT;
  static CurrentOrderState currentOrderState = CurrentOrderState.INIT;
  static PreviousOrderState previousOrderState = PreviousOrderState.INIT;
  static FetchChatSate fetchChatSate = FetchChatSate.INIT;
  static SendMsgSate sendMsgSate = SendMsgSate.INIT;
}