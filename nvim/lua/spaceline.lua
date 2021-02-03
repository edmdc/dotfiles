local gl = require('galaxyline')
local utils = require('utils')

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista'}

local colors = {
    bg = '#3c3836',
    fg = '#fbf1c7',
    section_bg = '#665C54',
    blue = '#83a598',
    green = '#b8bb26',
    purple = '#d3869b',
    orange = '#fe8019',
    red1 = '#cc241d',
    red2 = '#fb4934',
    yellow = '#fabd2f',
    gray1 = '#bdae93',
    gray2 = '#dec4a1',
    gray3 = '#7c6f64',
    darkgrey = '#504945',
    grey = '#848586',
    middlegrey = '#8791A5'
}

-- Local helper functions
local buffer_not_empty = function() return not utils.is_buffer_empty() end

local checkwidth = function()
    return utils.has_width_gt(40) and buffer_not_empty()
end

local mode_color = function()
    local mode_colors = {
        n = colors.green,
        i = colors.blue,
        c = colors.green,
        V = colors.purple,
        [''] = colors.purple,
        v = colors.purple,
        R = colors.orange
    }

    if mode_colors[vim.fn.mode()] ~= nil then
        return mode_colors[vim.fn.mode()]
    else
        print(vim.fn.mode())
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. '  ' end
    end
    return file .. ' '
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = 'NORMAL',
                i = 'INSERT',
                c = 'COMMAND',
                v = 'VISUAL',
                V = 'V-LINE',
                [''] = 'VISUAL',
                R = 'REPLACE'
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            if alias[vim.fn.mode()] ~= nil then
                return '  ' .. alias[vim.fn.mode()] .. ' '
            else
                return '  V-BLOCK '
            end
        end,
        highlight = {colors.bg, colors.bg, 'bold'}
    }
}
gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.left[3] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = " ",
        separator_highlight = {colors.section_bg, colors.bg}
    }
}
gls.left[9] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = ' ',
        highlight = {colors.red1, colors.bg}
    }
}
gls.left[10] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.bg}
    }
}
gls.left[11] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = ' ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.left[12] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.bg}
    }
}
gls.left[13] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = ' ',
        highlight = {colors.blue, colors.section_bg},
        separator = ' ',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '+',
        highlight = {colors.green, colors.bg}
    }
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = {colors.red1, colors.bg}
    }
}
gls.right[4] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.bg}
    }
}
gls.right[5] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = buffer_not_empty and
            require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.middlegrey, colors.bg}
    }
}
gls.right[6] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = buffer_not_empty,
        highlight = {colors.middlegrey, colors.bg}
    }
}
gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.blue, colors.bg},
        highlight = {colors.darkgrey, colors.blue}
    }
}

-- Short status line
gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        highlight = {colors.fg, colors.section_bg},
        separator = ' ',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.yellow, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
