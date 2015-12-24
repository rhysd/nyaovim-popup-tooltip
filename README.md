Popup Tooltip UI for [NyaoVim](https://github.com/rhysd/NyaoVim)
================================================================

This is a [NyaoVim](https://github.com/rhysd/NyaoVim) UI plugin to provide popup tooltip which shows images on Neovim.

![screenshot](https://raw.githubusercontent.com/rhysd/ss/master/nyaovim-popup-tooltip/main.gif)

## Installation

This is normal Neovim plugin.  Please put this repo to the directory in `runtimepath`.  If you use a plugin manager, install this plugin as other plugins.

After installing this repository as Neovim plugin, put `<popup-tooltip>` component to your `~/.config/nyaovimrc.html`.

```html
<neovim-editor id="nyaovim-editor" argv$="[[argv]]"></neovim-editor>
<!-- Add below line -->
<popup-tooltip editor="[[editor]]"></popup-tooltip>
```

## Usage

This plugin defines two `<Plug>(nyaovim-popup-tooltip-open)` mapping on normal mode and visual mode.  You can map it.

If `g:nyaovim_popup_tooltip_default_mapping` is not set to `0`, this plugin overrides `gi` mapping.  Below mappings are defined.

```vim
nmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)
vmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)
```

When you enter `gi` on path to image (both local path and remote http address will do), NyaoVim shows up image tooltip as above screenshot.  Popup emerges on the cursor.

And three functions are available.

- `TogglePopupTooltip(path, line, col)`
- `OpenPopupTooltip(path, line, col)`
- `ClosePopupTooltip()`

## License

Licensed MIT License.

```
Copyright (c) 2015 rhysd
```

