
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2
DEBUG_FPS = true
-- DEBUG_MEM = true

-- design resolution
CONFIG_SCREEN_WIDTH  = 960
CONFIG_SCREEN_HEIGHT = 640

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

GAME_TEXTURE_DATA_FILENAME  = "fiveinone_chessboard.plist"
GAME_TEXTURE_IMAGE_FILENAME = "fiveinone_chessboard.png"

CHESSBOARD_TMX_FILENAME = "map2.tmx"

CHESSBOARD_TMX_WIDTH = 17 --棋盘的宽度（图块数）
CHESSBOARD_TMX_HEIGHT = 17 --棋盘的高度（图块数）
CHESSBOARD_TMX_ITEM_WIDTH = 70 --棋盘图块的宽度（像素）
CHESSBOARD_TMX_ITEM_HEIGHT = 70 --棋盘图块的高度（像素）

CHESSBOARD_TMX_BOARD_LAYER = "tmxLayer1"
CHESSBOARD_TMX_PIECE_LAYER = "tmxLayer2"

BLACK_CHESS_TMX_POINT = ccp(17 ,0)
WHITE_CHESS_TMX_POINT = ccp(17 ,1)

SCALER_S_SCALER = {1.0, 1.2, 1.4, 1.6, 1.8, 2.0} --用户自定义的缩放比例，是基于自适应屏幕大小的scale之后再做得scale，因此叫做 scaler's scaler

SERIAL_NUM_TO_WIN = 5 --连续多少颗相同的棋子结束游戏（五子棋当然是五颗了，放config里边说明你有强迫症）

SHORT_MOVE_AS_CLICK_LEN = 32 -- 小于该值得短暂的移动只作为点击事件
