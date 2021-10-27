local gui = require("__flib__.gui")
local misc = require("__flib__.misc")

local constants = require("constants")
local util = require("scripts.util")

local templates = require("templates")

local depots_tab = {}

function depots_tab.build(widths)
  return {
    tab = {
      type = "tab",
      caption = {"gui.ltnm-depots"},
      ref = {"depots", "tab"},
      actions = {
        on_click = {gui = "main", action = "change_tab", tab = "depots"},
      },
    },
    content = {
      type = "frame",
      style = "ltnm_main_content_frame",
      direction = "vertical",
      ref = {"depots", "content_frame"},
      {type = "frame", style = "ltnm_table_toolbar_frame", style_mods = {right_padding = 4},
        templates.sort_checkbox(
          widths,
          "depots",
          "name",
          true,
          nil,
          true
        ),
        templates.sort_checkbox(
          widths,
          "depots",
          "network_id",
          true
        ),
        templates.sort_checkbox(
          widths,
          "depots",
          "status",
          true
        ),
        templates.sort_checkbox(
          widths,
          "depots",
          "trains",
          true
        ),

      }
    }
  }
end

function depots_tab.update(self)
  local dictionaries = self.player_table.dictionaries

  local state = self.state
  local refs = self.refs.depots
  local widths = self.widths.depots

  local search_query = state.search_query
  local search_network_id = state.network_id
  local search_surface = state.surface

  local ltn_depots = state.ltn_data.depots
  local scroll_pane = refs.scroll_pane
  local children = scroll_pane.children

  local sorts = state.sorts.depots
  local active_sort = sorts._active
  local sorted_depots = state.ltn_data.sorted_depots[active_sort]

  local table_index = 0

  -- False = ascending (arrow down), True = descending (arrow up)
  local start, finish, step
  if sorts[active_sort] then
    start = #sorted_depots
    finish = 1
    step = -1
  else
    start = 1
    finish = #sorted_depots
    step = 1
  end

  for sorted_index = start, finish, step do
    local depot_name = sorted_depots[sorted_index]
    local depot_data = ltn_depots[depot_name]

    if
      (search_surface == -1 or depot_data.surfaces[search_surface])
      and bit32.btest(depot_data.network_id, search_network_id)
      -- TODO: Search
      -- and (
      --   #search_query == 0 or string.find(depot_data.search_strings[self.player.index], string.lower(search_query))
      -- )
    then
      table_index = table_index + 1
      local row = children[table_index]
      local color = table_index % 2 == 0 and "dark" or "light"
      if not row then
        row = gui.add(scroll_pane,
          {type = "frame", style = "ltnm_table_row_frame_"..color,
            {type = "label", style_mods = {width = widths.name}},
            templates.status_indicator(widths.status),
            {type = "label", style_mods = {width = widths.network_id, horizontal_align = "center"}},
          }
        )
      end

      gui.update(row,
        {
          {elem_mods = {caption = depot_name}},
          {
            {elem_mods = {sprite = "flib_indicator_"..depot_data.status.color}},
            {elem_mods = {caption = depot_data.status.count}},
          },
          {elem_mods = {caption = depot_data.network_id}},
        }
      )
    end
  end

  for child_index = table_index + 1, #children do
    children[child_index].destroy()
  end

  if table_index == 0 then
    refs.warning_flow.visible = true
    scroll_pane.visible = false
    refs.content_frame.style = "ltnm_main_warning_frame"
  else
    refs.warning_flow.visible = false
    scroll_pane.visible = true
    refs.content_frame.style = "ltnm_main_content_frame"
  end

end

return depots_tab
