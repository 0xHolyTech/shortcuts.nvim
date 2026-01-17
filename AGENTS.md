# AGENT GUIDELINES FOR SHORTCUTS.NVIM

## Build, Lint, and Test Commands

This is a Neovim plugin written in Lua, so there are no traditional build steps. 
However, for development and testing purposes, the following commands are available:

- **Run tests**: This is a Lua plugin without explicit test suite configured. However, you can test functionality by:
  - Installing the plugin in Neovim
  - Using the plugin's built-in UI (`:ShortcutsToggle`) to verify shortcuts work
  - Looking at default shortcuts at startup for reference on format

## Code Style Guidelines

### Imports and Module Structure
- All Lua modules are contained in the `lua/` directory
- Module paths follow Neovim plugin conventions like `require('shortcuts.utils.files')`
- Use `require` to import other modules within the plugin

### Naming Conventions
- Use `snake_case` for function and variable names
- Use `PascalCase` for module names (e.g., `Shortcuts`)
- Use `UPPER_CASE` for constants

### Formatting
- Use 4-space indentation
- No trailing whitespace
- Function definitions should have one blank line before and after
- Use consistent spacing around operators and after commas

### Error Handling
- Use `xpcall` for error handling with `vim.api.nvim_err_writeln` for error reporting
- All file operations should include error handling for file reading/writing
- Return error messages with specific context when possible

### Types
- The plugin is written in pure Lua without static typing (Neovim plugin environment)
- Use meaningful variable names to indicate data types (e.g., `command_type`, `async_type`)
- Be consistent with data structure definitions (tables for configuration, strings for commands)

### Configuration
- Configuration files are stored as JSON in `~/.local/share/nvim/shortcuts/`
- Default shortcuts are defined in the main module (`shortcuts.lua`)
- Each project has its own JSON configuration file based on the git root directory

### Code Organization
- Split functionality across separate files in `lua/shortcuts/utils/`
- Main entry point is `lua/shortcuts.lua`
- Use Neovim's API functions (`vim.keymap.set`, `vim.api.nvim_create_user_command`) appropriately
- Maintain backward compatibility for key bindings

### File Structure
- Main plugin files: `lua/shortcuts.lua`
- Utility modules: `lua/shortcuts/utils/files.lua`, `lua/shortcuts/utils/json.lua`, `lua/shortcuts/ui.lua`
- Configuration files are created automatically based on project root
