# Norminette integration for Neovim written in Lua

Norminette Diagnostigs
![view of norminette diagnostics](https://github.com/hardyrafael17/norminette42.nvim/blob/main/wiki/showcase/showcase1.png)

42 Header
![view of norminette diagnostics](https://github.com/hardyrafael17/norminette42.nvim/blob/main/wiki/showcase/showcase2.gif)

<br clear="left"/>
<br />

## Requirements

[neovim >=0.7.0](https://github.com/neovim/neovim/wiki/Installing-Neovim)

[norminette v3.3.51](https://github.com/42School/norminette/tree/master/norminette) Currently tested only on that version

## Install

##### With [packer](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'hardyrafael17/norminette42.nvim',
}
```
##### With [lazy](https://www.lazyvim.org/):
```lua
{ "hardyrafael17/norminette42.nvim" },
```

## Setup

Setup should be run in a lua file or in a lua heredoc [:help lua-heredoc](https://neovim.io/doc/user/lua.html) if using in a vim file.
##### Packer:
```lua
-- setup with some options
require("norminette").setup({
  runOnSave = ,         -- Optional, Defaults to true, check for errors after save
  maxErrorsToShow = 5,  -- Only show 5 errors
  active = false,       -- Optional, Defaults to true can be set to false to deactivate plugin
  })
```

```lua
-- setup with without options
require("norminette").setup()
```

##### Lazy
```lua
	{
		"hardyrafael17/norminette42.nvim",
		config = function()
		local norminette = require("norminette")
		norminette.setup({
				runOnSave = true,
				maxErrorsToShow = 5,
				active = true,
		})
	end,
	},
```

## Commands

Basic commands:

`:Header42` Inserts the 42 Header or updates it if it finds one.

## Mappings

No default mappings yet

## Roadmap

This plugin is in it's very initial steps and there are many ideas, some of those will be listed bellow
Users are encouraged to add their own custom features via the public [API](#api).

Development is focused on:
* Making it more stable and making tests for modules
* Performance
* Making fix commands for auto fix

### Actions

Custom actions may be mapped which can invoke API or perform your own actions.

## Contributing

PRs are always welcome.

### Help Wanted

This is for sure a ver ugly and buggy plugin, (It's my first one), so expect bugs, Please report it by creating an issue.

Users for testing, also if anyone wants to help develope, it would be nice.

