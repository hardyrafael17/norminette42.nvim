# Norminette integration for Neovim written in lua

Norminette Diagnostigs

<br clear="left"/>
<br />

## Requirements

[neovim >=0.7.0](https://github.com/neovim/neovim/wiki/Installing-Neovim)

[norminette v3.3.51](https://github.com/42School/norminette/tree/master/norminette) Currently tested only on that version

## Install

With [packer](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'hardyrafael17/norminette42.nvim',
}
```

## Setup

Setup should be run in a lua file or in a lua heredoc [:help lua-heredoc](https://neovim.io/doc/user/lua.html) if using in a vim file.

```lua
-- examples for your init.lua

-- empty setup using defaults
require("norminette").setup()

-- OR setup with some options
require("norminette").setup({
  runOnSave = true,     -- Check for errors after save
  maxErrorsToShow = 5,  -- Only show 5 errors
  })
```

## Commands

Basic commands:

`:Norminette42` Run norminette on opened file (it needs to be a *.c or an *.h file.

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

[:help nvim-tree-mappings](doc/nvim-tree-lua.txt)

## Contributing

PRs are always welcome. See [wiki](https://github.com/nvim-tree/nvim-tree.lua/wiki/Development) to get started.

See [bug](https://github.com/nvim-tree/nvim-tree.lua/issues?q=is%3Aissue+is%3Aopen+label%3Abug) and [PR Please](https://github.com/nvim-tree/nvim-tree.lua/issues?q=is%3Aopen+is%3Aissue+label%3A%22PR+please%22) issues if you are looking for some work to get you started.

### Help Wanted

Users for testing, also if anyone wants to help develope, it would be nice

## Screenshots

TODO add wiki and showcase
