-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GUI STYLES

local styles = data.raw['gui-style'].default

-- -----------------------------------------------------------------------------
-- BUTTON STYLES

local slot_buttons_tileset = '__LtnManager__/graphics/gui/slot-buttons.png'

local function slot_button(y, glow_color, default_x, size)
  return {
    type = 'button_style',
    parent = 'quick_bar_slot_button',
    size = size or 40,
    default_graphical_set = {
      base = {border=4, position={(default_x or 0),y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
    },
    hovered_graphical_set = {
      base = {border=4, position={80,y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
      glow = offset_by_2_rounded_corners_glow(glow_color)
    },
    clicked_graphical_set = {
      base = {border=4, position={160,y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
    }
  }
end

local row_shadow = {
  position = {351,109},
  corner_size = 10,
  top_outer_border_shift = 4,
  bottom_outer_border_shift = -4,
  left_outer_border_shift = 4,
  right_outer_border_shift = -4,
  draw_type = 'outer'
}

local function bordered_slot_button(y, glow_color, default_x, size)
  return {
    type = 'button_style',
    size = size or 32,
    padding = -2,
    default_graphical_set = {
      base = {border=4, position={(default_x or 0),y}, size=80, filename=slot_buttons_tileset},
      shadow = row_shadow
    },
    hovered_graphical_set = {
      base = {border=4, position={80,y}, size=80, filename=slot_buttons_tileset},
      shadow = row_shadow,
      glow = offset_by_2_rounded_corners_glow(glow_color)
    },
    clicked_graphical_set = {
      base = {border=4, position={160,y}, size=80, filename=slot_buttons_tileset},
      shadow = row_shadow
    }
  }
end

local slot_button_data = {
  {name='dark_grey', y=0, glow=default_glow_color},
  {name='light_grey', y=80, glow=default_glow_color},
  {name='red', y=160, glow={255,166,123,128}},
  {name='green', y=240, glow={34,255,75,128}},
  {name='blue', y=320, glow={34,181,255,128}},
}

for _,data in ipairs(slot_button_data) do
  styles['ltnm_slot_button_'..data.name] = slot_button(data.y, data.glow)
  styles['ltnm_small_slot_button_'..data.name] = slot_button(data.y, data.glow, nil, 36)
  styles['ltnm_bordered_slot_button_'..data.name] = bordered_slot_button(data.y, data.glow)
  styles['ltnm_active_slot_button_'..data.name] = slot_button(data.y, data.glow, 82)
  styles['ltnm_active_small_slot_button_'..data.name] = slot_button(data.y, data.glow, 82, 36)
  styles['ltnm_active_bordered_slot_button_'..data.name] = bordered_slot_button(data.y, data.glow, 82)
end

local function ltnm_tab_base(pos)
  return {
    position = pos,
    corner_size = 8,
    bottom = {},
    left_bottom = {},
    right_bottom = {}
  }
end

local mock_frame_shadow = {
  layers = {
    {
      position = {208,128},
      size = {1, 8},
      tint = hard_shadow_color,
      scale = 0.5
    },
    {
      position = {8, 0},
      size = {1, 8},
      shift = {0, 4}
    }
  }
}

styles.ltnm_mock_frame_tab = {
  type = 'button_style',
  font = 'default-bold',
  height = 32,
  top_padding = 6,
  bottom_padding = 6,
  minimal_width = 84,
  default_graphical_set = {
    base = ltnm_tab_base{102, 0},
    shadow = tab_glow(default_shadow_color, 0.5),
    glow = {bottom=mock_frame_shadow}
  },
  hovered_graphical_set = {
    base = ltnm_tab_base{153, 0},
    glow = {
      left_top = {position = {216, 0}, size = 16, tint = default_glow_color, scale = 0.5},
      top = {position = {208, 128}, size = {1, 8}, tint = default_glow_color, scale = 0.5},
      right_top = {position = {232, 0}, size = 16, tint = default_glow_color, scale = 0.5},
      left = {position = {200, 136}, size = {8, 1}, tint = default_glow_color, scale = 0.5},
      right = {position = {209, 136}, size = {8, 1}, tint = default_glow_color, scale = 0.5},
      left_bottom = mock_frame_shadow,
      bottom = mock_frame_shadow,
      right_bottom = mock_frame_shadow,
      top_outer_border_shift = 4,
      left_outer_border_shift = 4,
      right_outer_border_shift = -4,
      bottom_outer_border_shift = -4,
      draw_type = 'outer'
    }
  },
  clicked_vertical_offset = 0,
  clicked_graphical_set = {
    base = ltnm_tab_base{153, 0},
    glow = {bottom=mock_frame_shadow}
  },
  disabled_font_color = heading_font_color,
  disabled_graphical_set = {
    base = ltnm_tab_base{448, 103},
    shadow = tab_glow(default_shadow_color, 0.5)
  }
}

styles.ltnm_depot_button = {
  type = "button_style",
  parent = "button",
  width = 206,
  height = 85,
  padding = 4,
  clicked_vertical_offset = 0,
  clicked_graphical_set = {
    base = {position = {34, 17}, corner_size = 8},
    shadow = default_dirt
  },
  disabled_graphical_set = {
    base = {position = {68, 0}, corner_size = 8},
    shadow = default_dirt
  }
}

-- make the button narrower to account for the scrollbar
styles.ltnm_depot_button_for_scrollbar = {
  type = 'button_style',
  parent = 'ltnm_depot_button',
  width = 202
}

-- -----------------------------------------------------------------------------
-- EMPTY WIDGET STYLES

styles.ltnm_titlebar_drag_handle = {
  type = 'empty_widget_style',
  parent = 'draggable_space_header',
  horizontally_stretchable = 'on',
  natural_height = 24,
  minimal_width = 24,
  -- right_margin = 7
}

-- -----------------------------------------------------------------------------
-- FLOW STYLES

styles.ltnm_titlebar_flow = {
  type = 'horizontal_flow_style',
  direction = 'horizontal',
  horizontally_stretchable = 'on',
  vertical_align = 'center',
  top_margin = -3
}

styles.ltnm_station_labels_flow = {
  type = 'horizontal_flow_style',
  horizontal_spacing = 12,
  vertical_align = 'center'
}

-- -----------------------------------------------------------------------------
-- FRAME STYLES

styles.ltnm_empty_frame = {
  type = 'frame_style',
  graphical_set = {},
  padding = 0,
  margin = 0,
  vertical_flow_style = {
    type = 'vertical_flow_style',
    vertical_spacing = 0
  }
}

styles.ltnm_main_frame_header = {
  type = 'frame_style',
  height = 32,
  graphical_set = {
    base = {
      left_top = {position={0,0}, size={8,8}},
      top = {position={8,0}, size={1,8}},
      right_top = {position={9,0}, size={8,8}},
      right = {position={9,8}, size={8,1}},
      right_bottom = {position={9,8}, size={8,1}},
      bottom = {position={8,8}, size={1,1}},
      left_bottom = {position={26,9}, size={8,8}},
      left = {position={0,8}, size={8,1}},
      center = {position={8,8}, size={1,1}}
    },
    shadow = {
      top = {position={208,128}, size={1,8}},
      left_top = {position={200,128}, size={8,8}},
      left = {position={200,136}, size={1,8}}, -- empty area
      right_top = {position={209,128}, size={8,8}},
      right = {position={209,136}, size={8,1}},
      center = {position={208,136}, size={1,1}},
      tint = default_shadow_color,
      scale = 0.5,
      draw_type = 'outer'
    }
  },
  horizontal_flow_style = {
    type = 'horizontal_flow_style',
    top_padding = 3,
    vertical_align = 'center'
  }
}

styles.ltnm_main_frame_content = {
  type = 'frame_style',
  parent = 'dialog_frame',
  width = 642,
  height = 636,
  graphical_set = {
    base = {
      position = {0,0},
      corner_size = 8,
      top = {},
      left_top = {},
      right_top = {}
    },
    shadow = {
      position = {200, 128},
      corner_size = 8,
      top = {},
      left_top = {},
      right_top = {},
      tint = default_shadow_color,
      scale = 0.5,
      draw_type = 'outer'
    }
  },
  top_padding = 4,
  horizontal_flow_style = {
    type = 'horizontal_flow_style',
    horizontal_spacing = 0
  }
}

styles.ltnm_dark_content_frame = {
  type = 'frame_style',
  parent = 'inside_deep_frame',
  graphical_set = {
    base = {
      position = {17,0}, corner_size = 8,
      center = {position={42,8}, size={1,1}},
      draw_type = 'outer'
    },
    shadow = default_inner_shadow
  },
}

styles.ltnm_dark_content_frame_in_light_frame = {
  type = 'frame_style',
  parent = 'inside_deep_frame',
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = 'outer',
      center = {position={42,8}, size=1}
    },
    shadow = default_inner_shadow
  }
}

styles.ltnm_light_content_frame = {
  type = 'frame_style',
  parent = 'window_content_frame_packed'
}

styles.ltnm_light_content_frame_in_light_frame = {
  type = 'frame_style',
  parent = 'window_content_frame_packed',
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = 'outer',
      center = {position={76,8}, size=1}
    },
    shadow = default_inner_shadow
  }
}

styles.ltnm_depot_frame = {
  type = 'frame_style',
  parent = 'dark_frame',
  left_padding = 4,
  right_padding = 4
}

-- -----------------------------------------------------------------------------
-- SCROLL PANE STYLES

styles.ltnm_blank_scroll_pane = {
  type = "scroll_pane_style",
  extra_padding_when_activated = 0,
  padding = 4,
  graphical_set = {
    shadow = default_inner_shadow
  }
}

styles.ltnm_depots_scroll_pane = {
  type = 'scroll_pane_style',
  parent = 'ltnm_blank_scroll_pane',
  padding = 0,
  minimal_height = 85,
  maximal_height = 170,
  horizontally_stretchable = 'on',
  background_graphical_set = {
    position = {282, 17},
    corner_size = 8,
    overall_tiling_horizontal_padding = 4,
    overall_tiling_horizontal_size = 198,
    overall_tiling_horizontal_spacing = 8,
    overall_tiling_vertical_padding = 4,
    overall_tiling_vertical_size = 78,
    overall_tiling_vertical_spacing = 8
  }
}

-- adjust the rubber grid to fit the slightly narrower buttons when the scrollbar is active
styles.ltnm_depots_scroll_pane_for_scrollbar = {
  type = 'scroll_pane_style',
  parent = 'ltnm_depots_scroll_pane',
  background_graphical_set = {
    position = {282, 17},
    corner_size = 8,
    overall_tiling_horizontal_padding = 4,
    overall_tiling_horizontal_size = 194,
    overall_tiling_horizontal_spacing = 8,
    overall_tiling_vertical_padding = 4,
    overall_tiling_vertical_size = 78,
    overall_tiling_vertical_spacing = 8
  }
}

styles.ltnm_icon_slot_table_scroll_pane = {
  type = 'scroll_pane_style',
  parent = 'ltnm_blank_scroll_pane',
  padding = 0,
  margin = 0,
  extra_padding_when_activated = 0,
  height = 160,
  background_graphical_set = {
    base = {
      position = {282, 17},
      corner_size = 8,
      overall_tiling_horizontal_padding = 4,
      overall_tiling_horizontal_size = 32,
      overall_tiling_horizontal_spacing = 8,
      overall_tiling_vertical_padding = 4,
      overall_tiling_vertical_size = 32,
      overall_tiling_vertical_spacing = 8
    }
  }
}

styles.ltnm_small_icon_slot_table_scroll_pane = {
  type = 'scroll_pane_style',
  parent = 'ltnm_blank_scroll_pane',
  padding = 0,
  margin = 0,
  extra_padding_when_activated = 0,
  height = 72,
  minimal_width = 144,
  background_graphical_set = {
    base = {
      position = {282, 17},
      corner_size = 8,
      overall_tiling_horizontal_padding = 4,
      overall_tiling_horizontal_size = 28,
      overall_tiling_horizontal_spacing = 8,
      overall_tiling_vertical_padding = 4,
      overall_tiling_vertical_size = 28,
      overall_tiling_vertical_spacing = 8
    }
  }
}

styles.ltnm_stations_scroll_pane = {
  type = 'scroll_pane_style',
  parent = 'ltnm_blank_scroll_pane',
  vertically_stretchable = 'on',
  background_graphical_set = {
    position = {282, 17},
    corner_size = 8,
    overall_tiling_vertical_spacing = 12,
    overall_tiling_vertical_size = 32,
    overall_tiling_vertical_padding = 4
  }
}

styles.ltnm_trains_scroll_pane = {
  type = 'scroll_pane_style',
  parent = 'ltnm_blank_scroll_pane',
  extra_right_padding_when_activated = -12
}

styles.ltnm_station_row_frame = {
  type = 'frame_style',
  parent = 'dark_frame',
  minimal_height = 40,
  padding = 0,
  horizontally_stretchable = 'on',
  horizontal_flow_style = {
    type = 'horizontal_flow_style',
    vertical_align = 'center',
    horizontal_spacing = 12
  }
}

styles.ltnm_station_items_frame = {
  type = 'frame_style',
  parent = 'dark_frame',
  padding = 4,
  top_padding = 2,
  vertical_flow_style = {
    type = 'vertical_flow_style',
    vertical_spacing = 4
  }
}

-- -----------------------------------------------------------------------------
-- SPRITE STYLES

styles.ltnm_inventory_selected_icon = {
  type = 'image_style',
  width = 28,
  height = 28,
  stretch_image_to_widget_size = true
}

-- -----------------------------------------------------------------------------
-- TABLE STYLES

styles.ltnm_icon_slot_table = {
  type = 'table_style',
  parent = 'slot_table',
  horizontal_spacing = 0,
  vertical_spacing = 0,
  width = 240
}

styles.ltnm_depots_table = {
  type = "table_style",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  padding = 0
}