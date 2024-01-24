
-- Register toolbar actions
function initUi()
  app.registerUi({["menu"] = "Pen", ["callback"] = "pen", ["accelerator"] = "p"});
  app.registerUi({["menu"] = "Pen", ["callback"] = "pen", ["accelerator"] = "d"});
  -- Can't override built-in keys #3093, stolen by PR #2712
  app.registerUi({["menu"] = "Highlighter", ["callback"] = "hl", ["accelerator"] = "h"});
  app.registerUi({["menu"] = "Highlighter", ["callback"] = "hl", ["accelerator"] = "m"});
  app.registerUi({["menu"] = "Select region", ["callback"] = "lasso", ["accelerator"] = "v"});
  app.registerUi({["menu"] = "Select region", ["callback"] = "lasso", ["accelerator"] = "l"});
  app.registerUi({["menu"] = "Eraser", ["callback"] = "eraser", ["accelerator"] = "e"});
  app.registerUi({["menu"] = "Eraser", ["callback"] = "eraser", ["accelerator"] = "minus"});
  app.registerUi({["menu"] = "Select PDF text", ["callback"] = "pdftext", ["accelerator"] = "s"});
  app.registerUi({["menu"] = "Insert text", ["callback"] = "insert", ["accelerator"] = "t"});
  app.registerUi({["menu"] = "Insert text", ["callback"] = "insert", ["accelerator"] = "i"});
  app.registerUi({["menu"] = "Cycle colors", ["callback"] = "cycle", ["accelerator"] = "c"});
  app.registerUi({["menu"] = "Decrease stroke", ["callback"] = "decreaseStroke", ["accelerator"] = "bracketleft"});
  app.registerUi({["menu"] = "Increase stroke", ["callback"] = "increaseStroke", ["accelerator"] = "bracketright"});
  app.registerUi({["menu"] = "Default", ["callback"] = "pdftext", ["accelerator"] = "Escape"});
  -- app.registerUi({["menu"] = "Default (hand)", ["callback"] = "default", ["accelerator"] = "Escape"});
  app.registerUi({["menu"] = "New page after", ["callback"] = "newpage", ["accelerator"] = "n"});
  app.registerUi({["menu"] = "Delete page", ["callback"] = "delpage", ["accelerator"] = "<shift>Delete"});
  app.registerUi({["menu"] = "Settings", ["callback"] = "settings", ["accelerator"] = "<alt>comma"});
  app.registerUi({["menu"] = "Reset zoom", ["callback"] = "zoomfit", ["accelerator"] = "<ctrl>0"});
end

local colorList = { 
  {"black", 0x000000},  
  {"blue", 0x4263EB},      
  {"red", 0xE03131},        
  {"green", 0x40C057},
  {"gray", 0x575775},   
  {"magenta", 0xE599F7},
  {"white", 0xffffff}
}

local hlColorList = { 
  {"magenta", 0xE599F7},
  {"orange", 0xFFC078},
  {"yellow", 0xFFFF10},
}

local strokeSizes = {
  "ACTION_SIZE_FINE",
  "ACTION_SIZE_MEDIUM",
  "ACTION_SIZE_THICK",
}

-- Starting stroke size index (MEDIUM)
local curStrokeSizeIndex = 1

function decreaseStroke()
  if curStrokeSizeIndex > 1 then
    curStrokeSizeIndex = curStrokeSizeIndex - 1
    app.uiAction({["action"] = strokeSizes[curStrokeSizeIndex]})
  end
end

function increaseStroke()
  if curStrokeSizeIndex < #strokeSizes then
    curStrokeSizeIndex = curStrokeSizeIndex + 1
    app.uiAction({["action"] = strokeSizes[curStrokeSizeIndex]})
  end
end

-- "pen" OR "hl"
local curTool = "pen"
local curList = colorList
local curColor = 0 

function cycle()
  if (curTool == "pen") then
    curList = colorList
  elseif (curTool == "hl") then
    curList = hlColorList
  end
  if (curColor < #curList) then
    curColor = curColor + 1
  else
    curColor = 1
  end
  app.changeToolColor({["color"] = curList[curColor][2], ["selection"] = true})
end

function pen()
  app.uiAction({["action"] = "ACTION_TOOL_PEN"})
  app.uiAction({["action"] = "ACTION_TOOL_DRAW_COORDINATE_SYSTEM", ["enabled"] = false})
  app.uiAction({["action"] = "ACTION_TOOL_RULER", ["enabled"] = false})
  curTool = "pen"
end

function hl()
  app.uiAction({["action"] = "ACTION_TOOL_HIGHLIGHTER"})
  app.uiAction({["action"] = "ACTION_TOOL_DRAW_COORDINATE_SYSTEM", ["enabled"] = false})
  app.uiAction({["action"] = "ACTION_TOOL_RULER", ["enabled"] = false})
  curTool = "hl"
end

function lasso()
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_REGION"})
end

function eraser()
  app.uiAction({["action"] = "ACTION_TOOL_ERASER"})
end

function pdftext()
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_PDF_TEXT_LINEAR"})
end

function insert()
  app.uiAction({["action"] = "ACTION_TOOL_TEXT"})
end

function default()
  app.uiAction({["action"] = "ACTION_TOOL_HAND"})
end

function newpage()
  app.uiAction({["action"] = "ACTION_NEW_PAGE_AFTER"})
end

function newpage()
  app.uiAction({["action"] = "ACTION_NEW_PAGE_AFTER"})
end

function delpage()
  app.uiAction({["action"] = "ACTION_DELETE_PAGE"})
end

function settings()
  app.uiAction({["action"] = "ACTION_SETTINGS"})
end

function zoomfit()
  app.uiAction({["action"] = "ACTION_ZOOM_FIT"})
end

function pairpages()
  app.uiAction({["action"] = "ACTION_VIEW_PAIRED_PAGES"})
end
